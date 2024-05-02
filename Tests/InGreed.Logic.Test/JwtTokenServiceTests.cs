using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;
using InGreed.Logic.Services;
using Moq;
using System.IdentityModel.Tokens.Jwt;

namespace InGreed.Logic.Tests;

public class JwtTokenServiceTests
{
    JwtSecurityTokenHandler _jwtSecurityTokenHandler { get; } = new();

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
        var username = claims.FirstOrDefault(c => c.Type.Equals("username"));

        //Assert
        Assert.Equal(testingUser.Username, username?.ToString());
    }

    [Fact]
    public void GenerateToken_UserIsCorrect_TokenHasValidEmail()
    {
        //Arrange
        var sut = new JwtTokenService(dateTimeProviderMock.Object);

        //Act
        var token = new JwtSecurityToken(sut.GenerateToken(testingUser));
        var claims = token.Claims;
        var email = claims.FirstOrDefault(c => c.Type.Equals("email"));

        //Assert
        Assert.Equal(testingUser.Email, email?.ToString());
    }
}
