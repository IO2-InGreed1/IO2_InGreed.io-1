using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Enums;
using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;
using InGreed.Logic.Services;
using Moq;

namespace InGreed.Test
{
    [TestClass]
    public class AccountServiceTests
    {
        string CorrectToken { get; set; } = string.Empty;
        User ExistingUser { get; set; } = null!;
        User NonExistingUser { get; set; } = null!;

        AccountService AccountService { get; set; } = null!;
        IUserDA MockUserDA { get; set; } = null!;
        ITokenService MockTokenService { get; set; } = null!;

        void InitializeUserDA()
        {
            var mock = new Mock<IUserDA>();
            mock.Setup(userDa => userDa.CreateUser(ExistingUser)).Throws(new Exception("Existing User"));
            mock.Setup(userDa => userDa.CreateUser(NonExistingUser));
            mock.Setup(userDa => userDa.GetUserByEmail(It.IsIn<string>(ExistingUser.Email))).Returns(ExistingUser);
            mock.Setup(userDa => userDa.GetUserByEmail(It.IsNotIn<string>(ExistingUser.Email))).Throws(new Exception("Non existing User"));

            MockUserDA = mock.Object;
        }

        void InitializeTokenService()
        {
            var mock = new Mock<ITokenService>();
            mock.Setup(tokenService => tokenService.GenerateToken(ExistingUser)).Returns(CorrectToken);
            mock.Setup(tokenService => tokenService.GenerateToken(NonExistingUser)).Returns(CorrectToken);

            MockTokenService = mock.Object;
        }

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

            CorrectToken = "CorrectToken";

            InitializeUserDA();
            InitializeTokenService();

            AccountService = new AccountService(MockUserDA, MockTokenService);
        }

        [TestMethod]
        public void UserRegister_CorrectUser_ShouldReturnValidToken()
        {
            var result = AccountService.Register(NonExistingUser);

            Assert.IsNotNull(result);
            Assert.AreEqual(CorrectToken, result);
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
            Assert.AreEqual(CorrectToken, result);
        }

        [TestMethod]
        public void UserLogin_IncorrectEmail_ShouldThrowArgumentException()
        {
            var testMethod = () => AccountService.Login(NonExistingUser);

            var exception = Assert.ThrowsException<ArgumentException>(testMethod);
            Assert.AreEqual("Invalid Credentials", exception.Message);
        }
        
        [TestMethod]
        public void UserLogin_IncorrectPassword_ShouldThrowArgumentException()
        {
            var userWithInvalidPassword = new User
            {
                Email = ExistingUser.Email,
                Password = ""
            };

            var testMethod = () => AccountService.Login(userWithInvalidPassword);

            var exception = Assert.ThrowsException<ArgumentException>(testMethod);
            Assert.AreEqual("Invalid Credentials", exception.Message);
        }
    }
}
