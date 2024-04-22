using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Enums;
using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;
using InGreed.Logic.Services;
using Moq;

namespace InGreed.Test
{
    public class AccountServiceTests
    {
        User testingUser;
        string correctToken;

        Mock<IUserDA> userDAMock;
        Mock<ITokenService> tokenServiceMock;

        public AccountServiceTests()
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
            
            userDAMock = new Mock<IUserDA>();
            tokenServiceMock = new Mock<ITokenService>();
        }

        [Fact]
        public void UserRegister_CorrectUser_ShouldReturnValidToken()
        {
            //Arrange
            tokenServiceMock.Setup(ts => ts.GenerateToken(testingUser)).Returns(correctToken);
            userDAMock.Setup(uda => uda.CreateUser(testingUser));
            var accountService = new AccountService(userDAMock.Object, tokenServiceMock.Object);

            //Act
            var result = accountService.Register(testingUser);

            //Assert
            Assert.NotNull(result);
            Assert.Equal(correctToken, result);
        }

        [Fact]
        public void UserRegister_ExistingUsername_ShouldThrowArgumentException()
        {
            //Arrange
            tokenServiceMock.Verify(ts => ts.GenerateToken(It.IsAny<User>()), Times.Never);
            userDAMock.Setup(uda => uda.CreateUser(testingUser)).Throws(new Exception("Existing User"));
            var accountService = new AccountService(userDAMock.Object, tokenServiceMock.Object);

            //Act
            var testMethod = () => accountService.Register(testingUser);

            //Assert
            var exception = Assert.Throws<ArgumentException>(testMethod);
            Assert.Equal("User already registered", exception.Message);
        }

        [Fact]
        public void UserLogin_CorrectCredentials_ShouldReturnValidToken()
        {
            //Arrange
            tokenServiceMock.Setup(ts => ts.GenerateToken(testingUser)).Returns(correctToken);
            userDAMock.Setup(uda => uda.GetUserByEmail(testingUser.Email)).Returns(testingUser);
            var accountService = new AccountService(userDAMock.Object, tokenServiceMock.Object);

            //Act
            var result = accountService.Login(testingUser);

            //Assert
            Assert.NotNull(result);
            Assert.Equal(correctToken, result);
        }

        [Fact]
        public void UserLogin_IncorrectEmail_ShouldThrowArgumentException()
        {
            //Arrange
            tokenServiceMock.Verify(ts => ts.GenerateToken(It.IsAny<User>()), Times.Never);
            userDAMock.Setup(uda => uda.GetUserByEmail(testingUser.Email)).Throws(new Exception("Non existing User"));
            var accountService = new AccountService(userDAMock.Object, tokenServiceMock.Object);

            //Act
            var testMethod = () => accountService.Login(testingUser);

            //Assert
            var exception = Assert.Throws<ArgumentException>(testMethod);
            Assert.Equal("Invalid Credentials", exception.Message);
        }
        
        [Fact]
        public void UserLogin_IncorrectPassword_ShouldThrowArgumentException()
        {
            //Arrange
            var returnedUser = new User()
            {
                Id = testingUser.Id,
                Email = testingUser.Email,
                Password = $"{testingUser.Password} incorrect"
            };
            tokenServiceMock.Verify(ts => ts.GenerateToken(It.IsAny<User>()), Times.Never);
            userDAMock.Setup(uda => uda.GetUserByEmail(returnedUser.Email)).Returns(testingUser);
            var accountService = new AccountService(userDAMock.Object, tokenServiceMock.Object);

            //Act
            var testMethod = () => accountService.Login(returnedUser);

            //Assert
            var exception = Assert.Throws<ArgumentException>(testMethod);
            Assert.Equal("Invalid Credentials", exception.Message);
        }
    }
}
