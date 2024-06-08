using InGreed.DataAccess.Interfaces;
using InGreed.Logic.Services;
using InGreed.Domain.Models;
using Moq;
using InGreed.Domain.Enums;
using InGreed.Domain.Queries;
using InGreed.Domain.Helpers;

namespace InGreed.Logic.Test;

public class ProductServiceTests
{
    private Mock<IUserDA> mockUserDA;
    private Mock<IProductDA> mockProductDA;
    private readonly string producent = "Producent";

    public ProductServiceTests()
    {
        mockUserDA = new();
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
        var productService = new ProductService(mockProductDA.Object, mockUserDA.Object);

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
        var productService = new ProductService(mockProductDA.Object, mockUserDA.Object);

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
        ProductParameters parameters = new();
        List<ProductWithOwner> products = new();
        Product product1 = new Product()
        {
            Id = 1
        };
        Product product2 = new Product()
        {
            Id = 2
        };
        products.Add(new() { Product = product1, Owner = "Producent 1" });
        products.Add(new() { Product = product2, Owner = "Producent 2" });

        mockProductDA.Setup(pda => pda.GetAll(parameters)).Returns(new PaginatedList<ProductWithOwner>(products, 1, 1, parameters.PageSize));
        var productService = new ProductService(mockProductDA.Object, mockUserDA.Object);

        // Act
        var result = productService.GetAllProducts(parameters).ToList();

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
        User p = new() { Id = 1, Username = producent };
        ProductWithOwner po = new ProductWithOwner { Product = product1, Owner = producent };
        int testedId = 1;
        mockUserDA.Setup(mud => mud.GetUserById(product1.ProducentId)).Returns(p);
        mockProductDA.Setup(pda => pda.GetProductById(testedId)).Returns(po);
        var productService = new ProductService(mockProductDA.Object, mockUserDA.Object);

        // Act
        var result = productService.GetProductById(testedId);

        // Assert
        Assert.Equal(po, result);
    }

    [Fact]
    public void Report_ExistingProduct_ShouldReturnTrue()
    {
        // Arrange
        int id = 1;
        mockProductDA.Setup(pda => pda.Report(id)).Returns(true);
        var sut = new ProductService(mockProductDA.Object, mockUserDA.Object);

        // Act
        var result = sut.Report(id);

        // Assert
        Assert.True(result);
    }

    [Fact]
    public void Report_NonexistentProduct_ShouldReturnFalse()
    {
        // Arrange
        int id = 1;
        mockProductDA.Setup(pda => pda.Report(id)).Returns(false);
        var sut = new ProductService(mockProductDA.Object, mockUserDA.Object);

        // Act
        var result = sut.Report(id);

        // Assert
        Assert.False(result);
    }

    [Fact]
    public void RemoveReports_ExistingProduct_ShouldReturnTrue()
    {
        // Arrange
        int id = 1;
        mockProductDA.Setup(pda => pda.RemoveReports(id)).Returns(true);
        var sut = new ProductService(mockProductDA.Object, mockUserDA.Object);

        // Act
        var result = sut.RemoveReports(id);

        // Assert
        Assert.True(result);
    }

    [Fact]
    public void RemoveReports_NonexistentProduct_ShouldReturnFalse()
    {
        // Arrange
        int id = 1;
        mockProductDA.Setup(pda => pda.RemoveReports(id)).Returns(false);
        var sut = new ProductService(mockProductDA.Object, mockUserDA.Object);

        // Act
        var result = sut.RemoveReports(id);

        // Assert
        Assert.False(result);
    }
}