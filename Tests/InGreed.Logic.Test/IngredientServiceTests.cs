using InGreed.DataAccess.Interfaces;
using InGreed.Logic.Services;
using InGreed.Domain.Models;
using Moq;

namespace InGreed.Logic.Tests;

public class IngredientServiceTests
{
    private Ingredient testingIngredient;
    private Mock<IIngredientDA> ingredientDAMock;
    private readonly int id = 1;
    private readonly int badId = 2;
    public IngredientServiceTests() 
    {
        ingredientDAMock = new();
        testingIngredient = new() { Id = id, Name = "Oak Sapling", IconURL = String.Empty };
    }

    [Fact]
    public void GetAll_ShouldReturnAllIngredients() 
    {
        // Arrange
        List<Ingredient> ingredients = new() { testingIngredient };
        ingredientDAMock.Setup(ida => ida.GetAll()).Returns(ingredients);
        IngredientService sut = new(ingredientDAMock.Object);

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
        IngredientService sut = new(ingredientDAMock.Object);

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
        IngredientService sut = new(ingredientDAMock.Object);

        // Act
        var result = sut.GetById(id);

        // Assert
        Assert.Equal(result, null);
    }

    [Fact]
    public void AddToProduct_NonexistentIngredientExistingProduct_ShouldAddNewIngredientAndAssignItToProduct() 
    {
        // Arrange
        IngredientService sut = new(ingredientDAMock.Object);

        // Act


        // Assert

    }

    [Fact]
    public void AddToProduct_NonexistentIngredientNonexistentProduct_ShouldNotModifyingredientsNorProducts() 
    {
        // Arrange
        IngredientService sut = new(ingredientDAMock.Object);

        // Act


        // Assert

    }

    [Fact]
    public void AddToProduct_ExistingIngredientExistingProduct_ShouldAssignExistingIngredientToProduct() 
    {
        // Arrange
        IngredientService sut = new(ingredientDAMock.Object);

        // Act


        // Assert

    }

    [Fact]
    public void AddToProduct_ExistingIngredientNonexistentProduct_ShouldNotModifyingredientsNorProducts() 
    {
        // Arrange
        IngredientService sut = new(ingredientDAMock.Object);

        // Act


        // Assert

    }

    [Fact]
    public void RemoveFromProduct_NonexistentIngredientExistingProduct_ShouldNotUpdateProductIngredients() 
    {
        // Arrange
        IngredientService sut = new(ingredientDAMock.Object);

        // Act


        // Assert

    }

    [Fact]
    public void RemoveFromProduct_NonexistentIngredientNonexistentProduct_ShouldNotModifyingredientsNorProducts() 
    {
        // Arrange
        IngredientService sut = new(ingredientDAMock.Object);

        // Act


        // Assert

    }

    [Fact]
    public void RemoveFromProduct_ExistingIngredientFromTheProduct_ShouldRemoveTheingredientFromProductIngredients() 
    {
        // Arrange
        IngredientService sut = new(ingredientDAMock.Object);

        // Act


        // Assert

    }

    [Fact]
    public void RemoveFromProduct_ExistingIngredientNotFromTheProduct_ShouldNotUpdateProductIngredients() 
    {
        // Arrange
        IngredientService sut = new(ingredientDAMock.Object);

        // Act


        // Assert

    }

    [Fact]
    public void RemoveFromProduct_ExistingIngredientNonexistentProduct_ShouldNotModifyingredientsNorProducts() 
    {
        // Arrange
        IngredientService sut = new(ingredientDAMock.Object);

        // Act


        // Assert

    }
}
