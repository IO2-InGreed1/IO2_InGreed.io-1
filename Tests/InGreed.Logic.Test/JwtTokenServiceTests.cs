using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;
using InGreed.Logic.Services;
using Moq;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;

namespace InGreed.Logic.Tests;

public class JwtTokenServiceTests
{
    User testingUser;
    Mock<IDateTimeProvider> dateTimeProviderMock;

    public JwtTokenServiceTests()
    {
        testingUser = new User()
        {
            Id = 1,
            Email = "test@test.com",
            Username = "Test"
        };

        dateTimeProviderMock = new Mock<IDateTimeProvider>();
        dateTimeProviderMock.Setup(dt => dt.Now).Returns(new DateTime(2024, 5, 2));
    }

    [Fact]
    public void GenerateToken_UserIsNull_ReturnEmptyToken()
    {
        //Arrange
        var sut = new JwtTokenService(dateTimeProviderMock.Object);

        //Act
        var token = sut.GenerateToken(null);

        //Assert
        Assert.Empty(token);
    }

    [Fact]
    public void GenerateToken_UserIsCorrect_ReturnValidToken()
    {
        //Arrange
        var dateTimeProvider = dateTimeProviderMock.Object;
        var sut = new JwtTokenService(dateTimeProvider);

        //Act
        var token = new JwtSecurityToken(sut.GenerateToken(testingUser));

        //Assert
        Assert.True(token.ValidTo > dateTimeProvider.Now);
    }

    [Fact]
    public void GenerateToken_UserIsCorrect_TokenValidFromNow()
    {
        //Arrange
        var dateTimeProvider = dateTimeProviderMock.Object;
        var sut = new JwtTokenService(dateTimeProvider);

        //Act
        var token = new JwtSecurityToken(sut.GenerateToken(testingUser));

        //Assert
        Assert.True(token.ValidFrom == dateTimeProvider.Now);
    }

    [Fact]
    public void GenerateToken_UserIsCorrect_TokenValidForMaxHour()
    {
        //Arrange
        var dateTimeProvider = dateTimeProviderMock.Object;
        var sut = new JwtTokenService(dateTimeProvider);

        //Act
        var token = new JwtSecurityToken(sut.GenerateToken(testingUser));

        //Assert
        Assert.True(token.ValidTo < dateTimeProvider.Now.AddHours(1));
    }

    [Fact]
    public void GenerateToken_UserIsCorrect_TokenHasValidUsername()
    {
        //Arrange
        var sut = new JwtTokenService(dateTimeProviderMock.Object);

        //Act
        var token = new JwtSecurityToken(sut.GenerateToken(testingUser));
        var claims = token.Claims;
        var username = claims.FirstOrDefault(c => c.Type.Equals(JwtRegisteredClaimNames.Name));

        //Assert
        Assert.Equal(testingUser.Username, username?.Value);
    }

    [Fact]
    public void GenerateToken_UserIsCorrect_TokenHasValidEmail()
    {
        //Arrange
        var sut = new JwtTokenService(dateTimeProviderMock.Object);

        //Act
        var token = new JwtSecurityToken(sut.GenerateToken(testingUser));
        var claims = token.Claims;
        var email = claims.FirstOrDefault(c => c.Type.Equals(JwtRegisteredClaimNames.Email));

        //Assert
        Assert.Equal(testingUser.Email, email?.Value);
    }

    [Fact]
    public void GenerateToken_UserIsCorrect_TokenHasValidId()
    {
        //Arrange
        var sut = new JwtTokenService(dateTimeProviderMock.Object);

        //Act
        var token = new JwtSecurityToken(sut.GenerateToken(testingUser));
        var claims = token.Claims;
        var id = claims.FirstOrDefault(c => c.Type.Equals(JwtRegisteredClaimNames.Sub));

        //Assert
        Assert.NotNull(id);
        Assert.Equal(testingUser.Id, int.Parse(id.Value));
    }
}
