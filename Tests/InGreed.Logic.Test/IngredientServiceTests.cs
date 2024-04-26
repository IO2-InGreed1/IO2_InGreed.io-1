using InGreed.DataAccess.Interfaces;
using InGreed.Logic.Services;
using Moq;

namespace InGreed.Logic.Tests;

public class IngredientServiceTests
{
    private Mock<IIngredientDA> ingredientDAMock;
    public IngredientServiceTests() 
    {
        ingredientDAMock = new();
    }

    [Fact]
    public void GetAll_ShouldReturnAllIngredients() 
    {
        // Arrange
        IngredientService sut = new(ingredientDAMock.Object);

        // Act
        // Assert
    }

    [Fact]
    public void GetById_Existingingredient_ShouldReturnCorrectIngredient() 
    {
        // Arrange
        IngredientService sut = new(ingredientDAMock.Object);

        // Act
        // Assert
    }

    [Fact]
    public void GetById_NonexistentIngredient_ShouldReturnNull() 
    {
        // Arrange
        IngredientService sut = new(ingredientDAMock.Object);

        // Act
        // Assert
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
