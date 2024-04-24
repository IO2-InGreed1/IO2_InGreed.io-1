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
    public void CreateProduct_ExistingProduct_ShouldReturnNull()
    {
        // Arrange
        Product product1 = new Product()
        {
            Id = 1
        };
        mockProductDA.Setup(pda => pda.CreateProduct(product1)).Returns(value: null);
        var productService = new ProductService(mockProductDA.Object);

        // Act
        var result = productService.CreateProduct(product1);

        // Assert
        Assert.Null(result);
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

        mockProductDA.Setup(pda => pda.GetAllProducts()).Returns(products);
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

    [Fact]
    public void GetProductByID_NonexistentProduct_ShouldReturnNull()
    {
        // Arrange
        int testedId = 1;
        mockProductDA.Setup(pda => pda.GetProductById(testedId)).Returns(value: null);
        var productService = new ProductService(mockProductDA.Object);

        // Act
        var result = productService.GetProductById(testedId);

        // Assert
        Assert.Null(result);
    }
}