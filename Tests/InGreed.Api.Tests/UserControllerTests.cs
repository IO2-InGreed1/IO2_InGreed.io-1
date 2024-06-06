using Moq;
using InGreed.Logic.Services;
using InGreed.Api.Controllers;

namespace InGreed.Api.Tests;

public class UserControllerTests
{
    private Mock<FavouritesService> favouritesServiceMock;
    private readonly int id = 1;

    public UserControllerTests() 
    {
        favouritesServiceMock = new();
    }

    [Fact]
    public void AddToFavourites_ExistingProductNotFromFavouritesAuthorisedUser_ShouldReturnStatusOk()
    {
        // arrange 
        UserController sut = new(favouritesServiceMock.Object);

        // act


        // assert

    }

    [Fact]
    public void AddToFavourites_ExistingProductFromFavouritesAuthorisedUser_ShouldReturnStatusBadRequest()
    {
        // arrange 
        UserController sut = new(favouritesServiceMock.Object);

        // act


        // assert

    }

    [Fact]
    public void AddToFavourites_NonexistentProduct_ShouldReturnStatusNotFound()
    {
        // arrange 
        UserController sut = new(favouritesServiceMock.Object);

        // act


        // assert

    }

    [Fact]
    public void AddToFavourites_UnauthorisedUser_ShouldReturnStatusNotFound()
    {
        // arrange 
        UserController sut = new(favouritesServiceMock.Object);

        // act


        // assert

    }

    [Fact]
    public void RemoveFromFavourites_ExistingProductFromFavouritesAuthorisedUser_ShouldStatusOk()
    {
        // arrange 
        UserController sut = new(favouritesServiceMock.Object);

        // act


        // assert

    }

    [Fact]
    public void RemoveFromFavourites_ExistingProductNotFromFavouritesAuthorisedUser_ShouldReturnStatusBadRequest()
    {
        // arrange 
        UserController sut = new(favouritesServiceMock.Object);

        // act


        // assert

    }

    [Fact]
    public void RemoveFromFavourites_NonexistentProduct_ShouldReturnStatusNotFound()
    {
        // arrange 
        UserController sut = new(favouritesServiceMock.Object);

        // act


        // assert

    }

    [Fact]
    public void RemoveFromFavourites_UnauthorisedUser_ShouldReturnStatusNotFound()
    {
        // arrange 
        UserController sut = new(favouritesServiceMock.Object);

        // act


        // assert

    }
}
