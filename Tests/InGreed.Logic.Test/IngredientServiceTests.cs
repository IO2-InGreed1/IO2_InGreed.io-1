using InGreed.DataAccess.Interfaces;
using InGreed.Logic.Services;
using InGreed.Domain.Models;
using Moq;
using InGreed.DataAccess.Enums;
using InGreed.Logic.Mappers;
using InGreed.Logic.Enums.Ingredient;

namespace InGreed.Logic.Tests;

public class IngredientServiceTests
{
    private Ingredient testingIngredient;
    private Mock<IIngredientDA> ingredientDAMock;
    private IngredientDBtoServiceResponseMapper mapper;
    private readonly int id = 1;
    private readonly int badId = 2;

    public IngredientServiceTests() 
    {
        ingredientDAMock = new();
        testingIngredient = new() { Id = id, Name = "test", IconURL = string.Empty };
        mapper = new();
    }

    [Fact]
    public void GetAll_ShouldReturnAllIngredients() 
    {
        // Arrange
        List<Ingredient> ingredients = new() { testingIngredient };
        ingredientDAMock.Setup(ida => ida.GetAll()).Returns(ingredients);
        IngredientService sut = new(ingredientDAMock.Object, mapper);

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
        IngredientService sut = new(ingredientDAMock.Object, mapper);

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
        IngredientService sut = new(ingredientDAMock.Object, mapper);

        // Act
        var result = sut.GetById(badId);

        // Assert
        Assert.Null(result);
    }

    [Fact]
    public void AddToProduct_NonexistentIngredientExistingProduct_ShouldReturnSuccessResponse()
    {
        // Arrange
        ingredientDAMock.Setup(ida => ida.Create(testingIngredient)).Returns(id);
        ingredientDAMock.Setup(ida => ida.GetById(id)).Returns(value: null);
        ingredientDAMock.Setup(ida => ida.AddToProduct(id, id)).Returns(IngredientDAAddResponse.Success);
        IngredientService sut = new(ingredientDAMock.Object, mapper);

        // Act
        var result = sut.AddToProduct(testingIngredient, id);

        // Assert
        Assert.Equal(IngredientServiceAddResponse.Success, result);
    }

    [Fact]
    public void AddToProduct_NonexistentIngredientNonexistentProduct_ShouldReturnNonexistentProductResponse()
    {
        // Arrange
        ingredientDAMock.Setup(ida => ida.Create(testingIngredient)).Returns(id);
        ingredientDAMock.Setup(ida => ida.GetById(id)).Returns(value: null);
        ingredientDAMock.Setup(ida => ida.AddToProduct(id, id)).Returns(IngredientDAAddResponse.NonexistentProduct);
        IngredientService sut = new(ingredientDAMock.Object, mapper);

        // Act
        var result = sut.AddToProduct(testingIngredient, id);

        // Assert
        Assert.Equal(IngredientServiceAddResponse.NonexistentProduct, result);
    }

    [Fact]
    public void AddToProduct_ExistingIngredientExistingProduct_ShouldReturnSuccessResponse()
    {
        // Arrange
        ingredientDAMock.Setup(ida => ida.GetById(id)).Returns(testingIngredient);
        ingredientDAMock.Setup(ida => ida.AddToProduct(id, id)).Returns(IngredientDAAddResponse.Success);
        IngredientService sut = new(ingredientDAMock.Object, mapper);

        // Act
        var result = sut.AddToProduct(testingIngredient, id);

        // Assert
        Assert.Equal(IngredientServiceAddResponse.Success, result);
    }

    [Fact]
    public void AddToProduct_ExistingIngredientNonexistentProduct_ShouldReturnNonexistentProductResponse()
    {
        // Arrange
        ingredientDAMock.Setup(ida => ida.GetById(id)).Returns(testingIngredient);
        ingredientDAMock.Setup(ida => ida.AddToProduct(id, id)).Returns(IngredientDAAddResponse.NonexistentProduct);
        IngredientService sut = new(ingredientDAMock.Object, mapper);

        // Act
        var result = sut.AddToProduct(testingIngredient, id);

        // Assert
        Assert.Equal(IngredientServiceAddResponse.NonexistentProduct, result);
    }

    [Fact]
    public void RemoveFromProduct_NonexistentIngredientExistingProduct_ShouldReturnIngredientNotFromProductResponse()
    {
        // Arrange
        ingredientDAMock.Setup(ida => ida.GetById(id)).Returns(value: null);
        ingredientDAMock.Setup(ida => ida.RemoveFromProduct(id, id)).Returns(IngredientDARemoveResponse.IngredientNotFromProduct);
        IngredientService sut = new(ingredientDAMock.Object, mapper);

        // Act
        var result = sut.RemoveFromProduct(id, id);

        // Assert
        Assert.Equal(IngredientServiceRemoveResponse.IngredientNotFromProduct, result);
    }

    [Fact]
    public void RemoveFromProduct_NonexistentIngredientNonexistentProduct_ShouldReturnNonexistentProductResponse()
    {
        // Arrange
        ingredientDAMock.Setup(ida => ida.GetById(id)).Returns(value: null);
        ingredientDAMock.Setup(ida => ida.RemoveFromProduct(id, id)).Returns(IngredientDARemoveResponse.NonexistentProduct);
        IngredientService sut = new(ingredientDAMock.Object, mapper);

        // Act
        var result = sut.RemoveFromProduct(id, id);

        // Assert
        Assert.Equal(IngredientServiceRemoveResponse.NonexistentProduct, result);
    }

    [Fact]
    public void RemoveFromProduct_ExistingIngredientFromTheProduct_ShouldReturnSuccessResponse()
    {
        // Arrange
        ingredientDAMock.Setup(ida => ida.GetById(id)).Returns(testingIngredient);
        ingredientDAMock.Setup(ida => ida.RemoveFromProduct(id, id)).Returns(IngredientDARemoveResponse.Success);
        IngredientService sut = new(ingredientDAMock.Object, mapper);

        // Act
        var result = sut.RemoveFromProduct(id, id);

        // Assert
        Assert.Equal(IngredientServiceRemoveResponse.Success, result);
    }

    [Fact]
    public void RemoveFromProduct_ExistingIngredientNotFromTheProduct_ShouldReturnIngredientNotFromProductResponse()
    {
        // Arrange
        ingredientDAMock.Setup(ida => ida.GetById(id)).Returns(testingIngredient);
        ingredientDAMock.Setup(ida => ida.RemoveFromProduct(id, id)).Returns(IngredientDARemoveResponse.IngredientNotFromProduct);
        IngredientService sut = new(ingredientDAMock.Object, mapper);

        // Act
        var result = sut.RemoveFromProduct(id, id);

        // Assert
        Assert.Equal(IngredientServiceRemoveResponse.IngredientNotFromProduct, result);
    }

    [Fact]
    public void RemoveFromProduct_ExistingIngredientNonexistentProduct_ShouldReturnNonexistentProductResponse()
    {
        // Arrange
        ingredientDAMock.Setup(ida => ida.GetById(id)).Returns(testingIngredient);
        ingredientDAMock.Setup(ida => ida.RemoveFromProduct(id, id)).Returns(IngredientDARemoveResponse.NonexistentProduct);
        IngredientService sut = new(ingredientDAMock.Object, mapper);

        // Act
        var result = sut.RemoveFromProduct(id, id);

        // Assert
        Assert.Equal(IngredientServiceRemoveResponse.NonexistentProduct, result);
    }
}
