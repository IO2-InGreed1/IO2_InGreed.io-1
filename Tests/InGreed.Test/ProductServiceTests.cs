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

    Product NonExistentProduct { get; set; } = null!;
    List<Product> products { get; set;} = null!;

    Ingredient Ingredient1 { get; set; } = null!;
    Ingredient Ingredient2 { get; set; } = null!;
    List<Ingredient> ingredients { get; set; } = null!;


    Opinion Opinion1 { get; set; } = null!;
    Opinion Opinion2 { get; set; } = null!;
    List<Opinion> opinions { get; set; } = null!;

    ProductService ProductService { get; set; } = null!;
    IProductDA MockProductDA { get; set; } = null!;

    DateTime dt = new DateTime(2020, 01, 01);

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
        NonExistentProduct = new Product
        {
            Id = 3,
            Name = "Prod no 3 - wasn't existing before"
        };

        products.Add(ExistingProductWithIngredientsAndOpinions1);
        products.Add(ExistingProduct2);

        var mock = new Mock<IProductDA>();
        mock.Setup(productDa => productDa.GetAll()).Returns(products);
        mock.Setup(productDa => productDa.GetById(1)).Returns(ExistingProductWithIngredientsAndOpinions1);
        mock.Setup(productDa => productDa.GetById(2)).Returns(ExistingProduct2);
        mock.Setup(productDa => productDa.GetById(3)).Throws(new ArgumentException("Product not found"));
        mock.Setup(productDa => productDa.Create(NonExistentProduct));
        mock.Setup(productDa => productDa.Create(ExistingProductWithIngredientsAndOpinions1)).Throws(new ArgumentException("Product is already exising"));
        mock.Setup(productDa => productDa.Create(ExistingProduct2)).Throws(new ArgumentException("Product is already exising"));
        mock.Setup(productDa => productDa.Delete(1));
        mock.Setup(productDa => productDa.Delete(2));
        mock.Setup(productDa => productDa.Delete(3)).Throws(new ArgumentException("Product not found"));

        MockProductDA = mock.Object;

        ProductService = new ProductService(MockProductDA);
    }

    [TestMethod]
    public void CreateProduct_NotExistingProduct_ShouldCreateNewProduct()
    {
        // Arrange

        // Act

        // Assert
    }

    [TestMethod]
    public void CreateProduct_ExistingProduct_ShouldThrowException()
    {
        // Arrange

        // Act
        var exception = Assert.ThrowsException<ArgumentException>(() => ProductService.Create(ExistingProductWithIngredientsAndOpinions1));

        // Assert
        Assert.AreEqual("Product is already exising", exception.Message);
    }

    [TestMethod]
    public void DeleteProduct_NotExistingProduct_ShouldThrowException()
    {
        // Arrange
        int testedId = 3;

        // Act
        var exception = Assert.ThrowsException<ArgumentException>(() => ProductService.Delete(testedId));

        // Assert
        Assert.AreEqual("Product not found", exception.Message);
    }

    [TestMethod]
    public void DeleteProduct_ExistingProduct_ShouldDeleteProduct()
    {
        // Arrange

        // Act

        // Assert
    }

    [TestMethod]
    public void GetAllProducts_ShouldReturnListOfAllProducts()
    {
        // Arrange
        List<Product> result;

        // Act
        result = ProductService.GetAll().ToList();

        // Assert
        Assert.AreEqual(products, result);
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
        Assert.AreEqual("Product not found", exception.Message);
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
    public void CancelPromotion_NonexistentProduct_ShouldThrowArgumentException()
    {
        // Arrange
        int testedId = 3;

        // Act
        var exception = Assert.ThrowsException<ArgumentException>(() => ProductService.CancelPromotion(testedId));

        // Assert
        Assert.AreEqual("Product not found", exception.Message);
    }

    [TestMethod]
    public void CancelPromotion_ExistingProductWitouthPromotion_ShouldThrowArgumentException()
    {
        // Arrange
        int testedId = 1;

        // Act
        var exception = Assert.ThrowsException<ArgumentException>(() => ProductService.CancelPromotion(testedId));

        // Assert
        Assert.AreEqual("This product is not promoted", exception.Message);
    }

    [TestMethod]
    public void CancelPromotion_ExistingProductWithPromotion_ShouldCancelPromotion()
    {
        // Arrange
        int testedId = 1;
        Product testedProduct = ExistingProductWithIngredientsAndOpinions1;
        testedProduct.PromotedUntil = dt;

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
    public void GetOpinions_NonexistentProduct_ShouldThrowArgumentException()
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
    public void GetIngredients_NonexistentProduct_ShouldThrowArgumentException()
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