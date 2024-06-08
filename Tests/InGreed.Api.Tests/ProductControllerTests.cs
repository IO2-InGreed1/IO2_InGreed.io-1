using Moq;
using InGreed.Logic.Interfaces;
using InGreed.Domain.Models;
using InGreed.Api.Controllers;
using Microsoft.AspNetCore.Mvc;
using InGreed.Api.Contracts.Product;
using InGreed.Domain.Queries;
using InGreed.Domain.Helpers;

namespace InGreed.Api.Tests;

public class ProductControllerTests
{
    private Mock<IProductService> productServiceMock;
    private Product testingProduct;
    private readonly int id = 1;

    public ProductControllerTests()
    {
        productServiceMock = new();
        testingProduct = new() { Id = id, Category = Domain.Enums.Category.None, Name="test", PromotedUntil=null, ReportCount = 0, ProducentId = id, IconURL = "test" };
    }

    [Fact]
    public void GetAllProducts_ShouldReturnStatusOk()
    {
        // Arrange
        ProductParameters parameters = new();
        List<ProductWithOwner> products = new() { new() { Product = testingProduct, Owner = "Producent" } };
        productServiceMock.Setup(isa => isa.GetAllProducts(parameters)).Returns(new PaginatedList<ProductWithOwner>(products, 1, 1, parameters.PageSize));
        ProductController sut = new(productServiceMock.Object);

        var response = sut.GetAllProducts(parameters);

        // Assert
        var actionResult = Assert.IsType<OkObjectResult>(response);
        var responseContent = Assert.IsType<PaginatedList<ProductWithOwner>>(actionResult.Value);
        Assert.Equal(responseContent, products);
    }

    [Fact]
    public void GetById_ExistingProduct_ShouldReturnStatusOk()
    {
        // Arrange
        ProductWithOwner productWithOwner = new() { Product = testingProduct, Owner = "Producent" };
        productServiceMock.Setup(isa => isa.GetProductById(id)).Returns(productWithOwner);
        ProductController sut = new(productServiceMock.Object);

        // Act
        var response = sut.GetById(id);

        // Assert
        var actionResult = Assert.IsType<OkObjectResult>(response);
        var responseContent = Assert.IsType<GetByIdResponse>(actionResult.Value);
        Assert.Equal(responseContent, new GetByIdResponse(productWithOwner.Product, productWithOwner.Owner));
    }

    [Fact]
    public void GetById_NonexistentProduct_ShouldReturnStatusNotFound()
    {
        // Arrange
        productServiceMock.Setup(isa => isa.GetProductById(id)).Returns( new ProductWithOwner() { Product = null!, Owner = string.Empty });
        ProductController sut = new(productServiceMock.Object);

        // Act
        var response = sut.GetById(id);

        // Assert
        Assert.IsType<NotFoundResult>(response);
    }

    [Fact]
    public void Create_ShouldReturnStatusOk()
    {
        // Arrange
        int newId = 2;
        productServiceMock.Setup(isa => isa.CreateProduct(testingProduct)).Returns(newId);
        ProductController sut = new(productServiceMock.Object);
        CreateRequest request = new(testingProduct);

        // Act
        var response = sut.Create(request);

        // Assert
        var actionResult = Assert.IsType<OkObjectResult>(response);
        var responseContent = Assert.IsType<Product>(actionResult.Value);
        testingProduct.Id = newId;
        Assert.Equal(responseContent, testingProduct);
    }

    [Fact]
    public void Modify_ExistingProduct_ShouldReturnStatusOk()
    {
        // Arrange
        ProductController sut = new(productServiceMock.Object);
        ModifyRequest request= new(testingProduct);

        // Act
        var response = sut.Modify(request, id);

        // Assert
        Assert.IsType<OkObjectResult>(response);
    }

    [Fact]
    public void RemoveReports_ExistingProduct_ShouldReturnStatusOk()
    {
        // Arrange
        productServiceMock.Setup(ps => ps.RemoveReports(id)).Returns(true);
        ProductController sut = new(productServiceMock.Object);

        // Act
        var response = sut.RemoveReports(id);

        // Assert
        Assert.IsType<OkResult>(response);
    }

    [Fact]
    public void RemoveReports_NonexistentProduct_ShouldReturnStatusNotFound()
    {
        // Arrange
        productServiceMock.Setup(ps => ps.RemoveReports(id)).Returns(false);
        ProductController sut = new(productServiceMock.Object);

        // Act
        var response = sut.RemoveReports(id);

        // Assert
        var ActionResult = Assert.IsType<NotFoundObjectResult>(response);
        var ResponseContent = Assert.IsType<string>(ActionResult.Value);
        Assert.Equal($"Cannot reset report count for product with the id {id} as such product does not exist.", ResponseContent);
    }

    [Fact]
    public void AddReport_ExistingProduct_ShouldReturnStatusOk()
    {
        // Arrange
        productServiceMock.Setup(ps => ps.Report(id)).Returns(true);
        ProductController sut = new(productServiceMock.Object);

        // Act
        var response = sut.AddReport(id);

        // Assert
        Assert.IsType<OkResult>(response);
    }

    [Fact]
    public void AddReport_NonexistentProduct_ShouldReturnStatusNotFound()
    {
        // Arrange
        productServiceMock.Setup(ps => ps.Report(id)).Returns(false);
        ProductController sut = new(productServiceMock.Object);

        // Act
        var response = sut.AddReport(id);

        // Assert
        var ActionResult = Assert.IsType<NotFoundObjectResult>(response);
        var ResponseContent = Assert.IsType<string>(ActionResult.Value);
        Assert.Equal($"Cannot report product with the id {id} as such product does not exist.", ResponseContent);
    }
}
