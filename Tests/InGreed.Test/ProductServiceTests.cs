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

    Ingredient Ingredient1 { get; set; } = null!;
    Ingredient Ingredient2 { get; set; } = null!;
    List<Ingredient> ingredients { get; set; } = null!;


    Opinion Opinion1 { get; set; } = null!;
    Opinion Opinion2 { get; set; } = null!;
    List<Opinion> opinions { get; set; } = null!;

    ProductService ProductService { get; set; } = null!;
    IProductDA MockProductDA { get; set; } = null!;

    DateTime dt = new DateTime(2024, 04, 21);

    [TestInitialize]
    public void Setup()
    {
        Ingredient1 = new Ingredient()
        {
            Id=1,
            Name = "Ingredient no 1"
        };
        Ingredient2 = new Ingredient()
        {
            Id = 2,
            Name = "Ingredient no 2"
        };
        ingredients.Add(Ingredient1);
        ingredients.Add(Ingredient2);

        Opinion1 = new Opinion()
        {
            Id = 1,
            Content = "Opinion no 1"
        };
        Opinion2 = new Opinion()
        {
            Id = 2,
            Content = "Opinion no 2"
        };
        opinions.Add(Opinion1);
        opinions.Add(Opinion2);

        ExistingProductWithIngredientsAndOpinions1 = new Product
        {
            Id = 1,
            Name = "Prod no 1",
        };
        ExistingProductWithIngredientsAndOpinions1.Ingredients.Add(Ingredient1);
        ExistingProductWithIngredientsAndOpinions1.Opinions.Add(Opinion1);

        ExistingProduct2 = new Product
        {
            Id = 2,
            Name = "Prod no 2"
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
        int testedId = 3;

        // Act
        var exception = Assert.ThrowsException<ArgumentException>(() => ProductService.GetProductById(testedId));

        // Assert
        Assert.AreEqual("Product with this Id doesn't exist", exception.Message);
    }

    [TestMethod]
    public void PromoteProduct_ExistingNotPromotedProduct_ShouldChangeProductStateToPromoted()
    {
        // Arrange
        int testedId = 1;
        Product testedProduct = ExistingProductWithIngredientsAndOpinions1;

        // Act
        ProductService.Promote(testedId, dt);

        // Assert
        Assert.AreEqual(dt, testedProduct.PromotedUntil);
    }

    [TestMethod]
    public void PromoteProduct_ExistingPromotedProduct_ShouldKeepProductPromotedState()
    {
        // Arrange
        DateTime now = DateTime.Now;
        int testedId = 1;
        Product testedProduct = ExistingProductWithIngredientsAndOpinions1;
        testedProduct.PromotedUntil = dt;

        // Act
        ProductService.Promote(testedId, now);

        // Assert
        Assert.AreEqual(now, testedProduct.PromotedUntil);
    }

    [TestMethod]
    public void PromoteProduct_NonexistentProduct_ShouldThrowArgumentException()
    {
        // Arrange
        int testedId = 3;

        // Act
        var exception = Assert.ThrowsException<ArgumentException>(() => ProductService.Promote(testedId, dt));

        // Assert
        Assert.AreEqual("Product with this Id doesn't exist", exception.Message);
    }

    [TestMethod]
    public void CancelPromotion_NonexistentProduct_ShouldThrowArgumentException()
    {
        // Arrange
        int testedId = 3;

        // Act
        var exception = Assert.ThrowsException<ArgumentException>(() => ProductService.CancelPromotion(testedId));

        // Assert
        Assert.AreEqual("Product with this Id doesn't exist", exception.Message);
    }

    [TestMethod]
    public void CancelPromotion_ExistingProduct_ShouldCancelPromotion()
    {
        // Arrange
        int testedId = 1;
        Product testedProduct = ExistingProductWithIngredientsAndOpinions1;

        // Act
        ProductService.CancelPromotion(testedId);

        // Assert
        Assert.IsNull(testedProduct.PromotedUntil);
    }

    [TestMethod]
    public void AddOpinion_ExistingProductExistingOpinion_ShouldAddOpinionToProductOpinions()
    {
        // Arrange
        Product testedProduct = ExistingProductWithIngredientsAndOpinions1;
        // Act
        ProductService.AddOpinion(ExistingProductWithIngredientsAndOpinions1, Opinion2);

        // Assert
        Assert.AreEqual(opinions, testedProduct.Opinions);
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
        opinions.Remove(Opinion1);
        List<Opinion> listWithDeletedOpinion = opinions;
        Product testedProduct = ExistingProductWithIngredientsAndOpinions1;
        // Act
        ProductService.DeleteOpinion(ExistingProductWithIngredientsAndOpinions1, Opinion1);

        // Assert
        Assert.AreEqual(listWithDeletedOpinion, testedProduct.Opinions);
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
        Product testedProduct = ExistingProductWithIngredientsAndOpinions1;
        // Act
        ProductService.AddIngredient(ExistingProductWithIngredientsAndOpinions1, Ingredient2);

        // Assert
        Assert.AreEqual(ingredients, testedProduct.Ingredients);
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
        ingredients.Remove(Ingredient1);
        List<Ingredient> listWithDeletedIngredient = ingredients;
        Product testedProduct = ExistingProductWithIngredientsAndOpinions1;
        // Act
        ProductService.RemoveIngredient(ExistingProductWithIngredientsAndOpinions1, Ingredient1);

        // Assert
        Assert.AreEqual(listWithDeletedIngredient, testedProduct.Ingredients);
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
    public void GetOpinions_NonexistantProduct_ShouldThrowArgumentException()
    {
        // Arrange

        // Act
        var exception = Assert.ThrowsException<ArgumentException>(() => ProductService.GetOpinions(null));

        // Assert
        Assert.AreEqual("This product doesn't exist", exception.Message);
    }

    [TestMethod]
    public void GetOpinions_ExistingProduct_ShouldReturnListOfAllOpinions()
    {
        // Arrange
        List<Opinion> result;

        // Act
        result = ProductService.GetOpinions(ExistingProductWithIngredientsAndOpinions1).ToList();

        // Assert
        Assert.AreEqual(opinions, result);
    }

    [TestMethod]
    public void GetIngredients_NonexistantProduct_ShouldThrowArgumentException()
    {
        // Arrange

        // Act
        var exception = Assert.ThrowsException<ArgumentException>(() => ProductService.GetIngredients(null));

        // Assert
        Assert.AreEqual("This product doesn't exist", exception.Message);
    }

    [TestMethod]
    public void GetIngredients_ExistingProduct_ShouldReturnListOfAllOpinions()
    {
        // Arrange
        List<Ingredient> result;

        // Act
        result = ProductService.GetIngredients(ExistingProductWithIngredientsAndOpinions1).ToList();

        // Assert
        Assert.AreEqual(ingredients, result);
    }
}