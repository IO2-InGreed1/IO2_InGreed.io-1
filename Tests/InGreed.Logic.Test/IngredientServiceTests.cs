using InGreed.DataAccess.Interfaces;
using InGreed.Logic.Services;
using InGreed.Domain.Models;
using Moq;

namespace InGreed.Logic.Tests;

public class IngredientServiceTests
{
    private Ingredient testingIngredient;
    private Mock<IIngredientDA> ingredientDAMock;
    private Mock<IProductDA> productDAMock;
    private readonly int id = 1;
    private readonly int badId = 2;

    public IngredientServiceTests() 
    {
        productDAMock = new();
        ingredientDAMock = new();
        testingIngredient = new() { Id = id, Name = "test", IconURL = String.Empty };
    }

    [Fact]
    public void GetAll_ShouldReturnAllIngredients() 
    {
        // Arrange
        List<Ingredient> ingredients = new() { testingIngredient };
        ingredientDAMock.Setup(ida => ida.GetAll()).Returns(ingredients);
        IngredientService sut = new(ingredientDAMock.Object, productDAMock.Object);

        // Act
        var result = sut.GetAll();

        // Assert
        Assert.Equal(result, ingredients);
    }

    [Fact]
    public void GetById_Existingingredient_ShouldReturnCorrectIngredient() 
    {
        // Arrange
        ingredientDAMock.Setup(ida => ida.GetById(id)).Returns(testingIngredient);
        ingredientDAMock.Setup(ida => ida.GetById(badId)).Returns(value: null);
        IngredientService sut = new(ingredientDAMock.Object, productDAMock.Object);

        // Act
        var result = sut.GetById(id);

        // Assert
        Assert.Equal(result, testingIngredient);
    }

    [Fact]
    public void GetById_NonexistentIngredient_ShouldReturnNull() 
    {
        // Arrange
        ingredientDAMock.Setup(ida => ida.GetById(id)).Returns(testingIngredient);
        ingredientDAMock.Setup(ida => ida.GetById(badId)).Returns(value: null);
        IngredientService sut = new(ingredientDAMock.Object, productDAMock.Object);

        // Act
        var result = sut.GetById(badId);

        // Assert
        Assert.Null(result);
    }

    [Fact]
    public void AddToProduct_NonexistentIngredientExistingProduct_ShouldReturnSuccessResponse()
    {
        // Arrange
        IngredientService sut = new(ingredientDAMock.Object, productDAMock.Object);

        // Act
        var result = sut.AddToProduct(testingIngredient, id);

        // Assert

    }

    [Fact]
    public void AddToProduct_NonexistentIngredientNonexistentProduct_ShouldReturnnonexistentProductResponse()
    {
        // Arrange
        IngredientService sut = new(ingredientDAMock.Object, productDAMock.Object);

        // Act
        var result = sut.AddToProduct(testingIngredient, id);

        // Assert

    }

    [Fact]
    public void AddToProduct_ExistingIngredientExistingProduct_ShouldReturnSuccessResponse()
    {
        // Arrange
        IngredientService sut = new(ingredientDAMock.Object, productDAMock.Object);

        // Act
        var result = sut.AddToProduct(testingIngredient, id);

        // Assert

    }

    [Fact]
    public void AddToProduct_ExistingIngredientNonexistentProduct_ShouldReturnNonexistentProductResponse()
    {
        // Arrange
        IngredientService sut = new(ingredientDAMock.Object, productDAMock.Object);

        // Act
        var result = sut.AddToProduct(testingIngredient, id);

        // Assert

    }

    [Fact]
    public void RemoveFromProduct_NonexistentIngredientExistingProduct_ShouldNotUpdateProductIngredients()
    {
        // Arrange
        IngredientService sut = new(ingredientDAMock.Object, productDAMock.Object);

        // Act
        var result = sut.RemoveFromProduct(id, id);

        // Assert

    }

    [Fact]
    public void RemoveFromProduct_NonexistentIngredientNonexistentProduct_ShouldNotModifyingredientsNorProducts()
    {
        // Arrange
        IngredientService sut = new(ingredientDAMock.Object, productDAMock.Object);

        // Act
        var result = sut.RemoveFromProduct(id, id);

        // Assert

    }

    [Fact]
    public void RemoveFromProduct_ExistingIngredientFromTheProduct_ShouldRemoveTheingredientFromProductIngredients()
    {
        // Arrange
        IngredientService sut = new(ingredientDAMock.Object, productDAMock.Object);

        // Act
        var result = sut.RemoveFromProduct(id, id);

        // Assert

    }

    [Fact]
    public void RemoveFromProduct_ExistingIngredientNotFromTheProduct_ShouldNotUpdateProductIngredients()
    {
        // Arrange
        IngredientService sut = new(ingredientDAMock.Object, productDAMock.Object);

        // Act
        var result = sut.RemoveFromProduct(id, id);

        // Assert

    }

    [Fact]
    public void RemoveFromProduct_ExistingIngredientNonexistentProduct_ShouldNotModifyingredientsNorProducts()
    {
        // Arrange
        IngredientService sut = new(ingredientDAMock.Object, productDAMock.Object);

        // Act
        var result = sut.RemoveFromProduct(id, id);

        // Assert

    }
}
