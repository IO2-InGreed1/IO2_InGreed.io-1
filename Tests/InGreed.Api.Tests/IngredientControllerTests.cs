using InGreed.Api.Controllers;
using InGreed.Logic.Interfaces;
using InGreed.Domain.Models;
using Moq;
using Microsoft.AspNetCore.Mvc;

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
        var responseContent = Assert.IsType<List<Ingredient>>(actionResult.Value);
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
        var responseContent = Assert.IsType<Ingredient>(actionResult.Value);
        Assert.Equal(responseContent, testingIngredient);
    }

    [Fact]
    public void GetAdd_NonexistentIngredient_ShouldReturnStatusBadRequest()
    {
        // Arrange
        ingredientServiceMock.Setup(isa => isa.GetById(id)).Returns(value:null);
        IngredientController sut = new(ingredientServiceMock.Object);

        // Act
        var response = sut.GetById(id);

        // Assert
        var actionResult = Assert.IsType<BadRequestResult>(response);
    }
}
