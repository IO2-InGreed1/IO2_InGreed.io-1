using Moq;
using InGreed.Logic.Services;
using InGreed.Api.Controllers;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace InGreed.Api.Tests;

public class UserControllerTests
{
    private Mock<FavouritesService> favouritesServiceMock;
    private ControllerContext context;
    private readonly int id = 1;

    public UserControllerTests() 
    {
        favouritesServiceMock = new();
        context = new ControllerContext
        {
            HttpContext = new DefaultHttpContext
            {
                User = new(new List<ClaimsIdentity>() { new(new List<Claim>() { new Claim(ClaimTypes.NameIdentifier, "1") }) })
            }
        };
    }

    [Fact]
    public void AddToFavourites_ExistingProductNotFromFavouritesAuthorisedUser_ShouldReturnStatusOk()
    {
        // Arrange 
        UserController sut = new(favouritesServiceMock.Object);
        sut.ControllerContext = context;

        // Act
        var response = sut.AddToFavourites(id);

        // Assert
        Assert.IsType<OkResult>(response);
    }

    [Fact]
    public void AddToFavourites_ExistingProductFromFavouritesAuthorisedUser_ShouldReturnStatusBadRequest()
    {
        // Arrange 
        UserController sut = new(favouritesServiceMock.Object);
        sut.ControllerContext = context;

        // Act
        var response = sut.AddToFavourites(id);

        // Assert
        var actionResult = Assert.IsType<BadRequestObjectResult>(response);
        var responseContent = Assert.IsType<string>(actionResult.Value);
        Assert.Equal($"Product with {id} is already in favourites.", responseContent);
    }

    [Fact]
    public void AddToFavourites_NonexistentProduct_ShouldReturnStatusNotFound()
    {
        // Arrange 
        UserController sut = new(favouritesServiceMock.Object);
        sut.ControllerContext = context;

        // Act
        var response = sut.AddToFavourites(id);

        // Assert
        var actionResult = Assert.IsType<NotFoundObjectResult>(response);
        var responseContent = Assert.IsType<string>(actionResult.Value);
        Assert.Equal($"There is no product with id {id}.", responseContent);
    }

    [Fact]
    public void AddToFavourites_UnauthorizedUser_ShouldReturnStatusUnauthorized()
    {
        // Arrange 
        UserController sut = new(favouritesServiceMock.Object);
        sut.ControllerContext = context;

        // Act
        var response = sut.AddToFavourites(id);

        // Assert
        Assert.IsType<UnauthorizedResult>(response);
    }

    [Fact]
    public void RemoveFromFavourites_ExistingProductFromFavouritesAuthorisedUser_ShouldStatusOk()
    {
        // Arrange 
        UserController sut = new(favouritesServiceMock.Object);
        sut.ControllerContext = context;

        // Act
        var response = sut.RemoveFromFavourites(id);

        // Assert
        Assert.IsType<OkResult>(response);
    }

    [Fact]
    public void RemoveFromFavourites_ExistingProductNotFromFavouritesAuthorisedUser_ShouldReturnStatusBadRequest()
    {
        // Arrange 
        UserController sut = new(favouritesServiceMock.Object);
        sut.ControllerContext = context;

        // Act
        var response = sut.RemoveFromFavourites(id);

        // Assert
        var actionResult = Assert.IsType<BadRequestObjectResult>(response);
        var responseContent = Assert.IsType<string>(actionResult.Value);
        Assert.Equal($"Product with {id} is not in favourites.", responseContent);
    }

    [Fact]
    public void RemoveFromFavourites_NonexistentProduct_ShouldReturnStatusNotFound()
    {
        // Arrange 
        UserController sut = new(favouritesServiceMock.Object);
        sut.ControllerContext = context;

        // Act
        var response = sut.RemoveFromFavourites(id);

        // Assert
        var actionResult = Assert.IsType<NotFoundObjectResult>(response);
        var responseContent = Assert.IsType<string>(actionResult.Value);
        Assert.Equal($"There is no product with id {id}.", responseContent);
    }

    [Fact]
    public void RemoveFromFavourites_UnauthorizedUser_ShouldReturnStatusUnauthorized()
    {
        // Arrange 
        UserController sut = new(favouritesServiceMock.Object);
        sut.ControllerContext = context;

        // Act
        var response = sut.RemoveFromFavourites(id);

        // Assert
        Assert.IsType<UnauthorizedResult>(response);
    }
}
