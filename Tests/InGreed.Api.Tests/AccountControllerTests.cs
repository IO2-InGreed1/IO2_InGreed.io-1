using InGreed.Api.Contracts.Authorization;
using InGreed.Api.Controllers;
using InGreed.Domain.Enums;
using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Moq;
using System.Net;

namespace InGreed.Api.Tests
{
    // TODO: Refactor
    public class AccountControllerTests
    {
        AccountController _accountController = null!;
        IAccountService _accountService = null!;

        User existingUser = null!;
        User nonExistingUser = null!;
        string correctToken = string.Empty;

        void MockAccountService()
        {
            var mock = new Mock<IAccountService>();
            mock.Setup(accountService => accountService.Login(existingUser)).Returns(correctToken);
            mock.Setup(accountService => accountService.Login(nonExistingUser)).Throws(new ArgumentException("Invalid Credentials"));
            mock.Setup(accountService => accountService.Register(existingUser)).Throws(new ArgumentException("User already registered"));
            mock.Setup(accountService => accountService.Register(nonExistingUser)).Returns(correctToken);

            _accountService = mock.Object;
        }

        public AccountControllerTests()
        {
            existingUser = new User
            {
                Id = 1,
                Banned = false,
                Email = "Existing@test.com",
                Password = "Existing",
                Username = "ExistingTest",
                Role = Role.User
            };
            nonExistingUser = new User
            {
                Banned = false,
                Email = "NonExisting@test.com",
                Password = "NonExisting",
                Username = "NonExistingTest",
                Role = Role.User
            };

            correctToken = "correctToken";

            MockAccountService();

            _accountController = new AccountController(_accountService);
        }

        [Fact]
        public void UserLogin_CorrectCredentials_ShouldReturnStatusOk()
        {
            var request = new LoginRequest(existingUser.Email, existingUser.Password);

            var response = _accountController.Login(request);

            var actionResult = Assert.IsType<OkObjectResult>(response);
            var responseContent = Assert.IsType<AuthorizationResponse>(actionResult.Value);
            Assert.NotNull(responseContent.authorizationToken);
            Assert.NotEqual(string.Empty, responseContent.authorizationToken);
        }

        [Fact]
        public void UserLogin_IncorrectCredentials_ShouldReturnStatusForbidden()
        {
            var request = new LoginRequest(nonExistingUser.Email, nonExistingUser.Password);

            var response = _accountController.Login(request);

            Assert.IsType<ForbidResult>(response);
        }

        [Fact]
        public void UserRegister_CorrectUser_ShouldReturnStatusOk()
        {
            var request = new RegisterRequest(nonExistingUser.Email, nonExistingUser.Username, nonExistingUser.Password);

            var response = _accountController.Register(request);

            var actionResult = Assert.IsType<OkObjectResult>(response);
            var responseContent = Assert.IsType<AuthorizationResponse>(actionResult.Value);
            Assert.NotNull(responseContent.authorizationToken);
            Assert.NotEqual(string.Empty, responseContent.authorizationToken);
        }

        [Fact]
        public void UserRegister_ExistingUser_ShouldReturnStatusConflict()
        {
            var request = new RegisterRequest(existingUser.Email, existingUser.Username, existingUser.Password);

            var response = _accountController.Register(request);

            Assert.IsType<ConflictResult>(response);
        }

        [Fact]
        public void UserRegister_IncorrectCredentials_ShouldReturnStatusBadRequest()
        {
            var request = new RegisterRequest(nonExistingUser.Email, nonExistingUser.Username, existingUser.Password);

            var response = _accountController.Register(request);

            Assert.IsType<BadRequestResult>(response);
        }
    }
}