using InGreed.Api.Contracts.Authorization;
using InGreed.Api.Controllers;
using InGreed.Api.Mappers;
using InGreed.Domain.Enums;
using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Moq;

namespace InGreed.Api.Tests
{
    public class AccountControllerTests
    {
        User testingUser;
        string correctToken;

        Mock<IAccountService> accountServiceMock;
        Mock<IContractsToModelsMapper> contractsToModelsMapperMock;

        public AccountControllerTests()
        {
            testingUser = new User
            {
                Id = 1,
                Banned = false,
                Email = "test@test.com",
                Password = "test",
                Username = "test",
                Role = Role.User
            };

            correctToken = "Correct Token";

            accountServiceMock = new Mock<IAccountService>();
            contractsToModelsMapperMock = new Mock<IContractsToModelsMapper>();
        }

        [Fact]
        public void UserLogin_CorrectCredentials_ShouldReturnStatusOk()
        {
            // Arrange
            var request = new LoginRequest(testingUser.Email, testingUser.Password);
            contractsToModelsMapperMock.Setup(ctm => ctm.LoginRequestToUser(request)).Returns(testingUser);
            accountServiceMock.Setup(ac => ac.Login(testingUser)).Returns(correctToken);
            var sut = new AccountController(accountServiceMock.Object, contractsToModelsMapperMock.Object);

            // Act
            var response = sut.Login(request);

            // Assert
            var actionResult = Assert.IsType<OkObjectResult>(response);
            var responseContent = Assert.IsType<AuthorizationResponse>(actionResult.Value);
            Assert.NotNull(responseContent.authorizationToken);
            Assert.NotEqual(string.Empty, responseContent.authorizationToken);
        }

        [Fact]
        public void UserLogin_IncorrectCredentials_ShouldReturnStatusForbidden()
        {
            // Arrange
            var request = new LoginRequest(testingUser.Email, testingUser.Password);
            contractsToModelsMapperMock.Setup(ctm => ctm.LoginRequestToUser(request)).Returns(testingUser);
            accountServiceMock.Setup(ac => ac.Login(testingUser)).Throws(new ArgumentException("Invalid Credentials"));
            var sut = new AccountController(accountServiceMock.Object, contractsToModelsMapperMock.Object);

            // Act
            var response = sut.Login(request);

            // Assert
            Assert.IsType<ForbidResult>(response);
        }

        [Fact]
        public void UserRegister_CorrectUser_ShouldReturnStatusOk()
        {
            // Arrange
            var request = new RegisterRequest(testingUser.Email, testingUser.Username, testingUser.Password);
            contractsToModelsMapperMock.Setup(ctm => ctm.RegisterRequestToUser(request)).Returns(testingUser);
            accountServiceMock.Setup(ac => ac.Register(testingUser)).Returns(correctToken);
            var sut = new AccountController(accountServiceMock.Object, contractsToModelsMapperMock.Object);

            // Act
            var response = sut.Register(request);

            // Assert
            var actionResult = Assert.IsType<OkObjectResult>(response);
            var responseContent = Assert.IsType<AuthorizationResponse>(actionResult.Value);
            Assert.NotNull(responseContent.authorizationToken);
            Assert.NotEqual(string.Empty, responseContent.authorizationToken);
        }

        [Fact]
        public void UserRegister_IncorrectCredentials_ShouldReturnStatusBadRequest()
        {
            // Arrange
            var request = new RegisterRequest(testingUser.Email, testingUser.Username, testingUser.Password);
            contractsToModelsMapperMock.Setup(ctm => ctm.RegisterRequestToUser(request)).Returns(testingUser);
            accountServiceMock.Setup(ac => ac.Register(testingUser)).Throws(new ArgumentException("User already registered"));
            var sut = new AccountController(accountServiceMock.Object, contractsToModelsMapperMock.Object);

            // Act
            var response = sut.Register(request);

            // Assert
            Assert.IsType<BadRequestResult>(response);
        }
    }
}