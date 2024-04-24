using InGreed.DataAccess.Interfaces;
using InGreed.Logic.Services;
using InGreed.Domain.Models;
using Moq;
using InGreed.Logic.Interfaces;

namespace InGreed.Logic.Test;

public class ProductServiceTests
{
    Product ExistingProductWithIngredientsAndOpinions1 { get; set; } = null!;
    Product ExistingProduct2 { get; set; } = null!;

    Product NonExistentProduct { get; set; } = null!;

    ProductService mockProductService { get; set; } = null!;
    IProductDA productMockDA { get; set; } = null!;

    public ProductServiceTests()
    {
        var mock = new Mock<IProductDA>();
        mockProductService = new ProductService(productMockDA);
    }

    [Fact]
    public void CreateProduct_NotExistingProduct_ShouldCreateNewProduct()
    {
        // Arrange

        // Act

        // Assert
    }

    [Fact]
    public void CreateProduct_ExistingProduct_ShouldThrowException()
    {
        // Arrange

        // Act

        // Assert
    }

    [Fact]
    public void GetAllProducts_ShouldReturnListOfAllProducts()
    {
        // Arrange

        // Act

        // Assert
    }

    [Fact]
    public void GetProductByID_ExistingProduct_ShouldReturnTheRightProduct()
    {
        // Arrange

        // Act

        // Assert
    }

    [Fact]
    public void GetProductByID_NonexistentProduct_ShouldThrowArgumentException()
    {
        // Arrange

        // Act

        // Assert
    }
}