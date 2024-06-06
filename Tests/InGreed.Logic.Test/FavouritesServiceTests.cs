using InGreed.DataAccess.Interfaces;
using InGreed.Logic.Services;
using Moq;
using InGreed.Logic.Enums;

namespace InGreed.Logic.Tests;

public class FavouritesServiceTests
{
    private Mock<IUserDA> userDAMock;
    private Mock<IProductDA> productDAMock;
    private int id = 1;

    public FavouritesServiceTests() 
    {
        userDAMock = new();
        productDAMock = new();
    }

    [Fact]
    void Add_ExistingProductNotFromFavouritesExistingUser_ShouldReturnSuccessResponse()
    {
        // arrange
        FavouritesService sut = new(userDAMock.Object, productDAMock.Object);

        // act
        var response = sut.Add(id, id);

        // assert
        Assert.Equal(FavouritesServiceAddResponse.Success, response);
    }

    [Fact]
    void Add_ExistingProductFromFavouritesExistingUser_ShouldReturnAlreadyInFavouritesResponse()
    {
        // arrange
        FavouritesService sut = new(userDAMock.Object, productDAMock.Object);

        // act
        var response = sut.Add(id, id);

        // assert
        Assert.Equal(FavouritesServiceAddResponse.AlreadyInFavourites, response);
    }

    [Fact]
    void Add_NonexistentProduct_ShouldReturnInvalidProductIdResponse()
    {
        // arrange
        FavouritesService sut = new(userDAMock.Object, productDAMock.Object);

        // act
        var response = sut.Add(id, id);

        // assert
        Assert.Equal(FavouritesServiceAddResponse.InvalidProductId, response);
    }

    [Fact]
    void Add_NonexistentUser_ShouldReturnInvalidUserIdResponse()
    {
        // arrange
        FavouritesService sut = new(userDAMock.Object, productDAMock.Object);

        // act
        var response = sut.Add(id, id);

        // assert
        Assert.Equal(FavouritesServiceAddResponse.InvalidUserId, response);
    }

    [Fact]
    void Delete_ExistingProductNotFromFavouritesExistingUser_ShouldReturnSuccessResponse()
    {
        // arrange
        FavouritesService sut = new(userDAMock.Object, productDAMock.Object);

        // act
        var response = sut.Delete(id, id);

        // assert
        Assert.Equal(FavouritesServiceDeleteResponse.Success, response);
    }

    [Fact]
    void Delete_ExistingProductNotFromFavouritesExistingUser_ShouldReturnNotFavouritedResponse()
    {
        // arrange
        FavouritesService sut = new(userDAMock.Object, productDAMock.Object);

        // act
        var response = sut.Delete(id, id);

        // assert
        Assert.Equal(FavouritesServiceDeleteResponse.NotFavourited, response);
    }

    [Fact]
    void Delete_NonexistentProduct_ShouldReturnInvalidProductIdResponse()
    {
        // arrange
        FavouritesService sut = new(userDAMock.Object, productDAMock.Object);

        // act
        var response = sut.Delete(id, id);

        // assert
        Assert.Equal(FavouritesServiceDeleteResponse.InvalidProductId, response);
    }

    [Fact]
    void Delete_NonexistentUser_ShouldReturnInvalidUserIdResponse()
    {
        // arrange
        FavouritesService sut = new(userDAMock.Object, productDAMock.Object);

        // act
        var response = sut.Delete(id, id);

        // assert
        Assert.Equal(FavouritesServiceDeleteResponse.InvalidUserId, response);
    }
}
