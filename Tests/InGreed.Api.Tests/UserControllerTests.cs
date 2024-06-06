using Moq;
using InGreed.Logic.Interfaces;
using InGreed.Api.Controllers;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace InGreed.Api.Tests;

public class UserControllerTests
{
    private Mock<IFavouritesService> favouritesServiceMock;
    private ControllerContext context;
    private readonly int id = 1;

    public UserControllerTests() 
    {
        favouritesServiceMock = new();
        context = new ControllerContext
        {
            HttpContext = new DefaultHttpContext()
        };
    }

    [Fact]
    public void AddToFavourites_ExistingProductNotFromFavouritesAuthorisedUser_ShouldReturnStatusOk()
    {
        // Arrange 
        context.HttpContext.User = new(new List<ClaimsIdentity>() 
        { 
            new(new List<Claim>() 
            { 
                new Claim(ClaimTypes.NameIdentifier, "1") 
            }) 
        });
        favouritesServiceMock.Setup(fsm => fsm.Add(id, id)).Returns(Logic.Enums.FavouritesServiceAddResponse.Success);
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
        context.HttpContext.User = new(new List<ClaimsIdentity>()
        {
            new(new List<Claim>()
            {
                new Claim(ClaimTypes.NameIdentifier, "1")
            })
        });
        favouritesServiceMock.Setup(fsm => fsm.Add(id, id)).Returns(Logic.Enums.FavouritesServiceAddResponse.AlreadyInFavourites);
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
        context.HttpContext.User = new(new List<ClaimsIdentity>()
        {
            new(new List<Claim>()
            {
                new Claim(ClaimTypes.NameIdentifier, "1")
            })
        });
        favouritesServiceMock.Setup(fsm => fsm.Add(id, id)).Returns(Logic.Enums.FavouritesServiceAddResponse.InvalidProductId);
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
        context.HttpContext.User = null!;
        favouritesServiceMock.Setup(fsm => fsm.Add(id, id)).Returns(Logic.Enums.FavouritesServiceAddResponse.Success);
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
        context.HttpContext.User = new(new List<ClaimsIdentity>()
        {
            new(new List<Claim>()
            {
                new Claim(ClaimTypes.NameIdentifier, "1")
            })
        });
        favouritesServiceMock.Setup(fsm => fsm.Delete(id, id)).Returns(Logic.Enums.FavouritesServiceDeleteResponse.Success);
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
        context.HttpContext.User = new(new List<ClaimsIdentity>()
        {
            new(new List<Claim>()
            {
                new Claim(ClaimTypes.NameIdentifier, "1")
            })
        });
        favouritesServiceMock.Setup(fsm => fsm.Delete(id, id)).Returns(Logic.Enums.FavouritesServiceDeleteResponse.NotFavourited);
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
        context.HttpContext.User = new(new List<ClaimsIdentity>()
        {
            new(new List<Claim>()
            {
                new Claim(ClaimTypes.NameIdentifier, "1")
            })
        });
        favouritesServiceMock.Setup(fsm => fsm.Delete(id, id)).Returns(Logic.Enums.FavouritesServiceDeleteResponse.InvalidProductId);
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
        context.HttpContext.User = null!;
        favouritesServiceMock.Setup(fsm => fsm.Delete(id, id)).Returns(Logic.Enums.FavouritesServiceDeleteResponse.Success);
        UserController sut = new(favouritesServiceMock.Object);
        sut.ControllerContext = context;

        // Act
        var response = sut.RemoveFromFavourites(id);

        // Assert
        Assert.IsType<UnauthorizedResult>(response);
    }
}
