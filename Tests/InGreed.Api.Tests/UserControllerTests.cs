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

    /*
    [Fact]
    public void AddToFavourites_ExistingProductNotFromFavouritesExistingUser_ShouldReturnStatusOk()
    {
        // arrange 
        UserController sut = new(favouritesServiceMock.Object);

        // act


        // assert

    }

    [Fact]
    public void AddToFavourites_ExistingProductFromFavouritesExistingUser_ShouldReturnStatusBadRequest()
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
    public void AddToFavourites_NonexistentUser_ShouldReturnStatusNotFound()
    {
        // arrange 
        UserController sut = new(favouritesServiceMock.Object);

        // act


        // assert

    }

    [Fact]
    public void RemoveFromFavourites_ExistingProductFromFavouritesExistingUser_ShouldStatusOk()
    {
        // arrange 
        UserController sut = new(favouritesServiceMock.Object);

        // act


        // assert

    }

    [Fact]
    public void RemoveFromFavourites_ExistingProductNotFromFavouritesExistingUser_ShouldReturnStatusBadRequest()
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
    public void RemoveFromFavourites_NonexistentUser_ShouldReturnStatusNotFound()
    {
        // arrange 
        UserController sut = new(favouritesServiceMock.Object);

        // act


        // assert

    }
    */
}
