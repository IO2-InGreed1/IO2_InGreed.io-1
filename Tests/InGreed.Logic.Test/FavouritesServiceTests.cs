using InGreed.DataAccess.Interfaces;
using InGreed.Logic.Services;
using Moq;
using InGreed.Logic.Enums;
using InGreed.Domain.Models;

namespace InGreed.Logic.Tests;

public class FavouritesServiceTests
{
    private Mock<IUserDA> userDAMock;
    private Mock<IProductDA> productDAMock;
    private int id = 1;
    private User testingUser;
    private Product testingProduct;

    public FavouritesServiceTests() 
    {
        userDAMock = new();
        productDAMock = new();
        testingProduct = new() { Id = id, Category = Domain.Enums.Category.Other, Name = "test", PromotedUntil = null };
        testingUser = new() { Id = id, Banned = false, Email = "test", Password = "test", Role = Domain.Enums.Role.User, Username = "test" };
    }

    [Fact]
    void Add_ExistingProductNotFromFavouritesExistingUser_ShouldReturnSuccessResponse()
    {
        // arrange
        userDAMock.Setup(uda => uda.AddToFavourites(id, id)).Returns(true);
        userDAMock.Setup(uda => uda.GetUserById(id)).Returns(testingUser);
        productDAMock.Setup(pda => pda.GetProductById(id)).Returns(testingProduct);
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
        userDAMock.Setup(uda => uda.AddToFavourites(id, id)).Returns(false);
        userDAMock.Setup(uda => uda.GetUserById(id)).Returns(testingUser);
        productDAMock.Setup(pda => pda.GetProductById(id)).Returns(testingProduct);
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
        userDAMock.Setup(uda => uda.GetUserById(id)).Returns(testingUser);
        productDAMock.Setup(pda => pda.GetProductById(id)).Returns(value: null!);
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
        userDAMock.Setup(uda => uda.GetUserById(id)).Returns(value: null!);
        productDAMock.Setup(pda => pda.GetProductById(id)).Returns(testingProduct);
        FavouritesService sut = new(userDAMock.Object, productDAMock.Object);

        // act
        var response = sut.Add(id, id);

        // assert
        Assert.Equal(FavouritesServiceAddResponse.InvalidUserId, response);
    }

    [Fact]
    void Delete_ExistingProductFromFavouritesExistingUser_ShouldReturnSuccessResponse()
    {
        // arrange
        userDAMock.Setup(uda => uda.AddToFavourites(id, id)).Returns(true);
        userDAMock.Setup(uda => uda.GetUserById(id)).Returns(testingUser);
        productDAMock.Setup(pda => pda.GetProductById(id)).Returns(testingProduct);
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
        userDAMock.Setup(uda => uda.AddToFavourites(id, id)).Returns(false);
        userDAMock.Setup(uda => uda.GetUserById(id)).Returns(testingUser);
        productDAMock.Setup(pda => pda.GetProductById(id)).Returns(testingProduct);
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
        userDAMock.Setup(uda => uda.GetUserById(id)).Returns(testingUser);
        productDAMock.Setup(pda => pda.GetProductById(id)).Returns(value: null!);
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
        userDAMock.Setup(uda => uda.GetUserById(id)).Returns(value: null!);
        productDAMock.Setup(pda => pda.GetProductById(id)).Returns(testingProduct);
        FavouritesService sut = new(userDAMock.Object, productDAMock.Object);

        // act
        var response = sut.Delete(id, id);

        // assert
        Assert.Equal(FavouritesServiceDeleteResponse.InvalidUserId, response);
    }
}
