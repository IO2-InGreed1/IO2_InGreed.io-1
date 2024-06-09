using InGreed.Api.Controllers;
using InGreed.Logic.Interfaces;
using InGreed.Domain.Models;
using Moq;
using Microsoft.AspNetCore.Mvc;
using InGreed.Api.Contracts.Ingredient;
using InGreed.Logic.Enums.Ingredient;

namespace InGreed.Api.Tests;

public class IngredientControllerTests
{
    private Mock<IIngredientService> ingredientServiceMock;
    private Ingredient testingIngredient;
    private readonly int id = 1;

    public IngredientControllerTests() 
    {
        ingredientServiceMock = new();
        testingIngredient = new() { Id = id, Name = "test", IconURL = String.Empty };
    }

    [Fact]
    public void GetAll_ShouldReturnStatusOk()
    {
        // Arrange
        List<Ingredient> ingredients = new() { testingIngredient };
        ingredientServiceMock.Setup(isa => isa.GetAll()).Returns(ingredients);
        IngredientController sut = new(ingredientServiceMock.Object);

        // Act
        var response = sut.GetAll();

        // Assert
        var actionResult = Assert.IsType<OkObjectResult>(response);
        var responseContent = Assert.IsType<GetAllResponse>(actionResult.Value);
        Assert.Equal(responseContent.ingredients, ingredients);
    }

    [Fact]
    public void GetById_ExistingIngredient_ShouldReturnStatusOk()
    {
        // Arrange
        ingredientServiceMock.Setup(isa => isa.GetById(id)).Returns(testingIngredient);
        IngredientController sut = new(ingredientServiceMock.Object);

        // Act
        var response = sut.GetById(id);

        // Assert
        var actionResult = Assert.IsType<OkObjectResult>(response);
        var responseContent = Assert.IsType<GetByIdResponse>(actionResult.Value);
        Assert.Equal(responseContent.ingredient, testingIngredient);
    }

    [Fact]
    public void GetById_NonexistentIngredient_ShouldReturnStatusBadRequest()
    {
        // Arrange
        ingredientServiceMock.Setup(isa => isa.GetById(id)).Returns(value:null);
        IngredientController sut = new(ingredientServiceMock.Object);

        // Act
        var response = sut.GetById(id);

        // Assert
        Assert.IsType<BadRequestResult>(response);
    }

    [Fact]
    public void AddToProduct_ExistingProduct_ShouldReturnStatusOk()
    {
        // Arrange
        ingredientServiceMock.Setup(isa => isa.AddToProduct(testingIngredient, id)).Returns(IngredientServiceAddResponse.Success);
        IngredientController sut = new(ingredientServiceMock.Object);
        AdditionRequest request = new(testingIngredient);

        // Act
        var response = sut.AddToProduct(request, id);

        // Assert
        Assert.IsType<OkResult>(response);
    }

    [Fact]
    public void AddToProduct_NonexistentProduct_ShouldReturnStatusBadRequest()
    {
        // Arrange
        ingredientServiceMock.Setup(isa => isa.AddToProduct(testingIngredient, id)).Returns(IngredientServiceAddResponse.NonexistentProduct);
        IngredientController sut = new(ingredientServiceMock.Object);
        AdditionRequest request = new(testingIngredient);

        // Act
        var response = sut.AddToProduct(request, id);

        // Assert
        var actionResult = Assert.IsType<NotFoundObjectResult>(response);
        var responseContent = Assert.IsType<string>(actionResult.Value);
        Assert.Equal($"There is no product with an id {id}.", responseContent);
    }

    [Fact]
    public void RemoveFromProduct_ExistingIngredientExistingProduct_ShouldReturnStatusOk()
    {
        // Arrange
        ingredientServiceMock.Setup(isa => isa.RemoveFromProduct(id, id)).Returns(IngredientServiceRemoveResponse.Success);
        IngredientController sut = new(ingredientServiceMock.Object);

        // Act
        var response = sut.RemoveFromProduct(id, id);

        // Assert
        Assert.IsType<OkResult>(response);
    }

    [Fact]
    public void RemoveFromProduct_NonexistentProduct_ShouldReturnStatusNotFound()
    {
        // Arrange
        ingredientServiceMock.Setup(isa => isa.RemoveFromProduct(id, id)).Returns(IngredientServiceRemoveResponse.NonexistentProduct);
        IngredientController sut = new(ingredientServiceMock.Object);

        // Act
        var response = sut.RemoveFromProduct(id, id);

        // Assert
        var actionResult = Assert.IsType<NotFoundObjectResult>(response);
        var responseContent = Assert.IsType<string>(actionResult.Value);
        Assert.Equal($"There is no product with an id {id}.", responseContent);
    }

    [Fact]
    public void RemoveFromProduct_IngredientNotFromProduct_ShouldReturnStatusNotFound()
    {
        // Arrange
        ingredientServiceMock.Setup(isa => isa.RemoveFromProduct(id, id)).Returns(IngredientServiceRemoveResponse.IngredientNotFromProduct);
        IngredientController sut = new(ingredientServiceMock.Object);

        // Act
        var response = sut.RemoveFromProduct(id, id);

        // Assert
        var actionResult = Assert.IsType<NotFoundObjectResult>(response);
        var responseContent = Assert.IsType<string>(actionResult.Value);
        Assert.Equal($"Product {id} does not contain an Ingredient with an id {id}.", responseContent);
    }
}
