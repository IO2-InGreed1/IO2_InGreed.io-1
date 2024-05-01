using InGreed.Api.Controllers;
using InGreed.Logic.Interfaces;
using InGreed.Domain.Models;
using Moq;
using Microsoft.AspNetCore.Mvc;
using InGreed.Api.Contracts.Ingredient;

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
        GetByIdRequest request = new(id);

        // Act
        var response = sut.GetById(request);

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
        GetByIdRequest request = new(id);

        // Act
        var response = sut.GetById(request);

        // Assert
        Assert.IsType<BadRequestResult>(response);
    }

    [Fact]
    public void AddToProduct_ExistingProduct_ShouldReturnStatusOk()
    {
        // Arrange
        IngredientController sut = new(ingredientServiceMock.Object);
        AdditionRequest request = new(testingIngredient, id);

        // Act
        var response = sut.AddToProduct(request);

        // Assert
        var actionResult = Assert.IsType<OkObjectResult>(response);
    }

    [Fact]
    public void AddToProduct_NonexistentProduct_ShouldReturnStatusBadRequest()
    {
        // Arrange
        IngredientController sut = new(ingredientServiceMock.Object);
        AdditionRequest request = new(testingIngredient, id);

        // Act
        var response = sut.AddToProduct(request);

        // Assert
        Assert.IsType<BadRequestResult>(response);
    }

    [Fact]
    public void RemoveFromProduct_ExistingIngredientExistingProduct_ShouldReturnStatusOk()
    {
        // Arrange
        IngredientController sut = new(ingredientServiceMock.Object);
        RemovalRequest request = new(id, id);

        // Act
        var response = sut.RemoveFromProduct(request);

        // Assert
        var actionResult = Assert.IsType<OkObjectResult>(response);
    }

    [Fact]
    public void RemoveFromProduct_NonexistentIngredient_ShouldReturnStatusBadRequest()
    {
        // Arrange
        IngredientController sut = new(ingredientServiceMock.Object);
        RemovalRequest request = new(id, id);

        // Act
        var response = sut.RemoveFromProduct(request);

        // Assert
        Assert.IsType<BadRequestResult>(response);
    }

    [Fact]
    public void RemoveFromProduct_NonexistentProduct_ShouldReturnStatusBadRequest()
    {
        // Arrange
        IngredientController sut = new(ingredientServiceMock.Object);
        RemovalRequest request = new(id, id);

        // Act
        var response = sut.RemoveFromProduct(request);

        // Assert
        Assert.IsType<BadRequestResult>(response);
    }
}
