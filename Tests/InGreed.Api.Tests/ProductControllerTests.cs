﻿using Moq;
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
        testingProduct = new() { Id = id, Category = Domain.Enums.Category.None, Name="test", PromotedUntil=null };
    }

    [Fact]
    public void GetAllProducts_ShouldReturnStatusOk()
    {
        // Act
        PaginationParameters paginationParameters = new();
        List<Product> ingredients = new() { testingProduct };
        productServiceMock.Setup(isa => isa.GetAllProducts(paginationParameters)).Returns(new PaginatedList<Product>(ingredients, 1, 1, paginationParameters.PageSize));
        ProductController sut = new(productServiceMock.Object);

        // Arrange
        var response = sut.GetAllProducts(paginationParameters);

        // Assert
        var actionResult = Assert.IsType<OkObjectResult>(response);
        var responseContent = Assert.IsType<PaginatedList<Product>>(actionResult.Value);
        Assert.Equal(responseContent, ingredients);
    }

    [Fact]
    public void GetById_ExistingProduct_ShouldReturnStatusOk()
    {
        // Act
        productServiceMock.Setup(isa => isa.GetProductById(id)).Returns(testingProduct);
        ProductController sut = new(productServiceMock.Object);

        // Arrange
        var response = sut.GetById(id);

        // Assert
        var actionResult = Assert.IsType<OkObjectResult>(response);
        var responseContent = Assert.IsType<Product>(actionResult.Value);
        Assert.Equal(responseContent, testingProduct);
    }

    [Fact]
    public void GetById_NonexistentProduct_ShouldReturnStatusNotFound()
    {
        // Act
        productServiceMock.Setup(isa => isa.GetProductById(id)).Throws(new ArgumentException());
        ProductController sut = new(productServiceMock.Object);

        // Arrange
        var response = sut.GetById(id);

        // Assert
        Assert.IsType<NotFoundObjectResult>(response);
    }

    [Fact]
    public void Create_ShouldReturnStatusOk()
    {
        // Act
        int newId = 2;
        productServiceMock.Setup(isa => isa.CreateProduct(testingProduct)).Returns(newId);
        ProductController sut = new(productServiceMock.Object);
        CreateRequest request = new(testingProduct);

        // Arrange
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
        // Act
        ProductController sut = new(productServiceMock.Object);
        ModifyRequest request= new(testingProduct);

        // Arrange
        var response = sut.Modify(request, id);

        // Assert
        Assert.IsType<OkObjectResult>(response);
    }
}