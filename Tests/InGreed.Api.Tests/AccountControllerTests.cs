using InGreed.Api.Controllers;
using InGreed.Logic.Interfaces;

namespace InGreed.Api.Tests
{
    [TestClass]
    public class AccountControllerTests
    {
        AccountController _accountController = null!;
        IAccountService _accountService = null!;

        [TestInitialize]
        public void Setup()
        {
            _accountController = new AccountController(_accountService);
        }

        [TestMethod]
        public void UserLogin_CorrectCredentials_ShouldReturnStatusOk()
        {

        }

        [TestMethod]
        public void UserLogin_IncorrectCredentials_ShouldReturnStatusForbidden()
        {

        }

        [TestMethod]
        public void UserRegister_CorrectUser_ShouldReturnStatusOk()
        {

        }

        [TestMethod]
        public void UserRegister_ExistingUser_ShouldReturnStatusConflict()
        {

        }

        [TestMethod]
        public void UserRegister_IncorrectCredentials_ShouldReturnStatusBadRequest()
        {

        }
    }
}