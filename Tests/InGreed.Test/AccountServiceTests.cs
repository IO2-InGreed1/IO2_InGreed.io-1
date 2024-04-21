using InGreed.Domain.Enums;
using InGreed.Domain.Models;
using InGreed.Logic.Services;

namespace InGreed.Test
{
    [TestClass]
    public class AccountServiceTests
    {
        User ExistingUser { get; set; } = null!;
        User NonExistingUser { get; set; } = null!;

        AccountService AccountService { get; set; } = null!;

        [TestInitialize]
        public void Setup()
        {
            ExistingUser = new User
            {
                Id = 1,
                Banned = false,
                Email = "Existing@test.com",
                Password = "Existing",
                Username = "ExistingTest",
                Role = Role.User
            };
            NonExistingUser = new User
            {
                Banned = false,
                Email = "NonExisting@test.com",
                Password = "NonExisting",
                Username = "NonExistingTest",
                Role = Role.User
            };

            AccountService = new AccountService();
        }

        [TestMethod]
        public void UserRegister_CorrectUser_ShouldReturnValidToken()
        {
            var result = AccountService.Register(NonExistingUser);

            Assert.IsNotNull(result);
        }

        [TestMethod]
        public void UserRegister_ExistingUsername_ShouldThrowArgumentException()
        {
            var testMethod = () => AccountService.Register(ExistingUser);

            var exception = Assert.ThrowsException<ArgumentException>(testMethod);
            Assert.AreEqual("User already registered", exception.Message);
        }

        [TestMethod]
        public void UserLogin_CorrectCredentials_ShouldReturnValidToken()
        {
            var result = AccountService.Login(ExistingUser);

            Assert.IsNotNull(result);
        }

        [TestMethod]
        public void UserLogin_IncorrectCredentials_ShouldThrowArgumentException()
        {
            var testMethod = () => AccountService.Login(NonExistingUser);

            var exception = Assert.ThrowsException<ArgumentException>(testMethod);
            Assert.AreEqual("Invalid Credential", exception.Message);
        }
    }
}
