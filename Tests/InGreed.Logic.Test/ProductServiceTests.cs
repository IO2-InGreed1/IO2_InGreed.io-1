using InGreed.DataAccess.Interfaces;
using InGreed.Logic.Services;
using InGreed.Domain.Models;
using Moq;
using InGreed.Logic.Interfaces;
using InGreed.Domain.Enums;

namespace InGreed.Logic.Test;

public class ProductServiceTests
{
    Product ExistingProductWithIngredientsAndOpinions1 { get; set; } = null!;
    Product ExistingProduct2 { get; set; } = null!;

    Product NonExistentProduct { get; set; } = null!;

    ProductService mockProductService { get; set; } = null!;
    IProductDA productMockDA { get; set; } = null!;

    Mock<IProductDA> mockProductDA;

    public ProductServiceTests()
    {
        mockProductDA = new Mock<IProductDA>();
    }

    [Fact]
    public void CreateProduct_NotExistingProduct_ShouldCreateNewProduct_AndReturnCreatedProductId()
    {
        // Arrange
        Product product1 = new Product()
        {
            Id = 1
        };
        int testedId = 1;
        mockProductDA.Setup(pda => pda.CreateProduct(product1)).Returns(testedId);
        var productService = new ProductService(mockProductDA.Object);

        // Act
        var result = productService.CreateProduct(product1);

        // Assert
        Assert.Equal(testedId, result);
    }

    [Fact]
    public void ModifyProduct_ExistingProduct_ShouldModifyProduct()
    {
        // Arrange
        Product oldProduct = new Product()
        {
            Id = 1,
            Name = "Old name"
        };
        Product newProduct = new Product()
        {
            Id = 2,
            Name = "New name",
            Category = Category.Drinks
        };
        int testedId = 1;
        mockProductDA.Setup(pda => pda.ModifyProduct(It.IsAny<int>(), It.IsAny<Product>())).Callback<int, Product>((i, obj) => {
            oldProduct.Name = obj.Name;
            oldProduct.PromotedUntil = obj.PromotedUntil;
            oldProduct.Category = obj.Category;
            oldProduct.Ingredients.Clear();
            foreach (Ingredient ingredient in obj.Ingredients) oldProduct.Ingredients.Add(ingredient);
            oldProduct.Opinions.Clear();
            foreach (Opinion opinion in obj.Opinions) oldProduct.Opinions.Add(opinion);
        });
        var productService = new ProductService(mockProductDA.Object);

        // Act 
        productService.ModifyProduct(testedId, newProduct);

        // Assert
        mockProductDA.Verify(pda => pda.ModifyProduct(It.IsAny<int>(), It.IsAny<Product>()), Times.Once());
        Assert.Equal(testedId, oldProduct.Id);
        Assert.Equal(oldProduct.Name, newProduct.Name);
        Assert.Equal(oldProduct.PromotedUntil, newProduct.PromotedUntil);
        Assert.Equal(oldProduct.Category, newProduct.Category);
        Assert.Equal(oldProduct.Ingredients, newProduct.Ingredients);
        Assert.Equal(oldProduct.Opinions, newProduct.Opinions);
    }

    [Fact]
    public void GetAllProducts_ShouldReturnListOfAllProducts()
    {
        // Arrange
        List<Product> products = new List<Product>();
        Product product1 = new Product()
        {
            Id = 1
        };
        Product product2 = new Product()
        {
            Id = 2
        };
        products.Add(product1);
        products.Add(product2);

        mockProductDA.Setup(pda => pda.GetAll()).Returns(products);
        var productService = new ProductService(mockProductDA.Object);

        // Act
        var result = productService.GetAllProducts().ToList();

        // Assert
        Assert.Equal(products, result);
    }

    [Fact]
    public void GetProductByID_ExistingProduct_ShouldReturnTheRightProduct()
    {
        // Arrange
        Product product1 = new Product()
        {
            Id = 1
        };
        int testedId = 1;
        mockProductDA.Setup(pda => pda.GetProductById(testedId)).Returns(product1);
        var productService = new ProductService(mockProductDA.Object);

        // Act
        var result = productService.GetProductById(testedId);

        // Assert
        Assert.Equal(product1, result);
    }
}