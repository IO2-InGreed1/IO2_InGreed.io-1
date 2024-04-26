using InGreed.Api.Controllers;
using InGreed.Logic.Interfaces;
using Moq;

namespace InGreed.Api.Tests;

public class IngredientControllerTests
{
    private Mock<IIngredientService> ingredientServiceMock;

    public IngredientControllerTests() 
    {
        ingredientServiceMock = new();
    }

    [Fact] 
    public void GetAdd_ShouldReturnStatusOk()
    {
        // Arrange
        IngredientController sut = new(ingredientServiceMock.Object);

        // Act


        // Assert

    }

    [Fact]
    public void GetById_ExistingIngredient_ShouldReturnStatusOk()
    {
        // Arrange


        // Act


        // Assert

    }

    [Fact]
    public void GetAdd_NonexistentIngredient_ShouldReturnStatusBadRequest()
    {
        // Arrange


        // Act


        // Assert

    }
}
