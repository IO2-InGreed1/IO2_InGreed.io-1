using InGreed.DataAccess.Interfaces;
using InGreed.Application.Services;
using InGreed.Domain.Enums;
using InGreed.Domain.Models;
using Moq;

namespace InGreed.Test;

[TestClass]
public class ProductServiceTests
{
    Product ExistingProductWithIngredientsAndOpinions1 { get; set; } = null!;
    Product ExistingProduct2 { get; set; } = null!;
    List<Product> Products { get; set;} = null!;
    Product NonExistingProduct { get; set; } = null!;

    List<Ingredient> ingredients { get; set; } = null!;

    List<Opinion> opinions { get; set; } = null!;

    ProductService ProductService { get; set; } = null!;
    IProductDA MockProductDA { get; set; } = null!;

    [TestInitialize]
    public void Setup()
    {
        Ingredient Ingredient1 = new Ingredient()
        {
            Id=1,
            Name = "Ingredient no 1"
        };
        Ingredient Ingredient2 = new Ingredient()
        {
            Id = 1,
            Name = "Ingredient no 2"
        };
        ingredients.Add(Ingredient1);
        ingredients.Add(Ingredient2);

        Opinion Opinion1 = new Opinion()
        {
            Id = 1,
            Content = "Opinion no 1"
        };
        Opinion Opinion2 = new Opinion()
        {
            Id = 1,
            Content = "Opinion no 2"
        };
        opinions.Add(Opinion1);
        opinions.Add(Opinion2);

        ExistingProductWithIngredientsAndOpinions1 = new Product
        {
            Id = 1,
            Name = "I exist!",
        };
        ExistingProductWithIngredientsAndOpinions1.Ingredients.Add(Ingredient1);
        ExistingProductWithIngredientsAndOpinions1.Ingredients.Add(Ingredient2);
        ExistingProductWithIngredientsAndOpinions1.Opinions.Add(Opinion1);
        ExistingProductWithIngredientsAndOpinions1.Opinions.Add(Opinion2);

        ExistingProduct2 = new Product
        {
            Id = 2,
            Name = "I also exist!"
        };
        NonExistingProduct = new Product
        {
            Name = "I do not exist!"
        };

        Products.Add(ExistingProductWithIngredientsAndOpinions1);
        Products.Add(ExistingProduct2);

        var mock = new Mock<IProductDA>();

        MockProductDA = mock.Object;

        ProductService = new ProductService(MockProductDA);
    }

    [TestMethod]
    public void GetAllProducts_ShouldReturnListOfAllProducts()
    {
        // Arrange
        List<Product> result;

        // Act
        result = ProductService.GetAll().ToList();

        // Assert
        Assert.AreEqual(Products, result);
    }

    [TestMethod]
    public void GetProductByID_ExistingProduct_ShouldReturnTheRightProduct()
    {
        // Arrange
        Product result;

        // Act
        result = ProductService.GetProductById(ExistingProductWithIngredientsAndOpinions1.Id);

        // Assert
        Assert.AreEqual(ExistingProductWithIngredientsAndOpinions1, result);
    }

    [TestMethod]
    public void GetProductByID_NonexistentProduct_ShouldThrowArgumentException()
    {
        // Arrange

        // Act

        // Assert

    }

    [TestMethod]
    public void PromoteProduct_ExistingNotPromotedProduct_ShouldChangeProductStateToPromoted()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void PromoteProduct_ExistingPromotedProduct_ShouldKeepProductPromotedState()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void PromoteProduct_NonexistentProduct_ShouldThrowArgumentException()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void AddOpinion_ExistingProductExistingOpinion_ShouldAddOpinionToProductOpinions()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void AddOpinion_NonexistentProductExistingOpinion_ShouldThrowArgumentException()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void AddOpinion_ExistingProductNonexistantOpinion_ShouldThrowArgumentException()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void AddOpinion_NonexistentProductNonexistantOpinion_ShouldThrowArgumentException()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void DeleteOpinion_ExistingProductExistingOpinion_ShouldDeleteOpinionFromProductopinions()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void DeleteOpinion_ExistingProductNonexistentOpinion_ShouldThrowArgumentException()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void DeleteOpinion_NonexistentProductExistingOpinion_ShouldThrowArgumentException()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void DeleteOpinion_NonexistentProductNonexistentOpinion_ShouldThrowArgumentException()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void AddIngredient_ExistingProductExistingIngredient_ShouldAddIngredientToProductIngredients()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void AddIngredient_ExistingProductNonexistantIngredient_ShouldThrowArgumentException()
    {
        // Arrange
        // Act
        // Assert
}

    [TestMethod]
    public void AddIngredient_NonexistantProductExistingIngredient_ShouldThrowArgumentException()
    {
        // Arrange
        // Act
        // Assert
    }
    
    [TestMethod]
    public void AddIngredient_NonexistantProductNonexistantIngredient_ShouldThrowArgumentException()
    {
        // Arrange
        // Act
        // Assert
    }
    
    [TestMethod]
    public void RemoveIngredient_ExistingProductExistingIngredient_ShouldRemoveIngredientFromProductIngredients()
    {
        // Arrange
        // Act
        // Assert
    }
    
    [TestMethod]
    public void RemoveIngredient_ExistingProductNonexistantIngredient_ShouldThrowArgumentException()
    {
        // Arrange
        // Act
        // Assert
    }
    
    [TestMethod]
    public void RemoveIngredient_NonexistantProductExistingIngredient_ShouldThrowArgumentException()
    {
        // Arrange
        // Act
        // Assert
    }
    
    [TestMethod]
    public void RemoveIngredient_NonexistantProductNonexistantIngredient_ShouldThrowArgumentException()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void GetOpinions_ShouldReturnListOfAllOpinions()
    {
        // Arrange
        List<Opinion> result;

        // Act
        result = ProductService.GetOpinions(ExistingProductWithIngredientsAndOpinions1).ToList();

        // Assert
        Assert.AreEqual(opinions, result);
    }

    [TestMethod]
    public void GetIngredients_ShouldReturnListOfAllOpinions()
    {
        // Arrange
        List<Ingredient> result;

        // Act
        result = ProductService.GetIngredients(ExistingProductWithIngredientsAndOpinions1).ToList();

        // Assert
        Assert.AreEqual(ingredients, result);
    }
}