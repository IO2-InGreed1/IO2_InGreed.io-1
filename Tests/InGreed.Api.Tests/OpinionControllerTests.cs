using InGreed.Api.Controllers;
using InGreed.Logic.Interfaces;
using InGreed.Domain.Models;
using Moq;
using Microsoft.AspNetCore.Mvc;
using InGreed.Api.Contracts.Opinion;
using InGreed.Logic.Enums.Opinion;

namespace InGreed.Api.Tests;

public class OpinionControllerTests
{
    private Mock<IOpinionService> opinionServiceMock;
    private Opinion testingOpinion;
    private readonly int id = 1;

    public OpinionControllerTests()
    {
        opinionServiceMock = new();
        testingOpinion = new() { Id = id, productId = 1, authorId = 1, Content = "test opinion", reportCount = 0 };
    }

    [Fact]
    public void GetById_ExistingOpinion_ShouldReturnStatusOk()
    {
        // Arrange
        opinionServiceMock.Setup(osa => osa.GetById(id)).Returns(testingOpinion);
        OpinionController sut = new(opinionServiceMock.Object);

        // Act
        var response = sut.GetById(id);

        // Assert
        var actionResult = Assert.IsType<OkObjectResult>(response);
        var responseContent = Assert.IsType<GetByIdResponse>(actionResult.Value);
        Assert.Equal(responseContent.opinion, testingOpinion);
    }

    [Fact]
    public void GetById_NonexistentOpinion_ShouldReturnStatusNotFound()
    {
        // Arrange
        opinionServiceMock.Setup(osa => osa.GetById(id)).Returns(value: null);
        OpinionController sut = new(opinionServiceMock.Object);

        // Act
        var response = sut.GetById(id);

        // Assert
        Assert.IsType<NotFoundResult>(response);
    }

    [Fact]
    public void AddToProduct_ExistingProduct_ShouldReturnStatusOk()
    {
        // Arrange
        opinionServiceMock.Setup(osa => osa.AddToProduct(testingOpinion, id)).Returns(OpinionServiceAddResponse.Success);
        OpinionController sut = new(opinionServiceMock.Object);
        AdditionRequest request = new(testingOpinion);

        // Act
        var response = sut.AddToProduct(request, id);

        // Assert
        Assert.IsType<OkResult>(response);
    }

    [Fact]
    public void AddToProduct_NonexistentProduct_ShouldReturnStatusBadRequest()
    {
        // Arrange
        opinionServiceMock.Setup(osa => osa.AddToProduct(testingOpinion, id)).Returns(OpinionServiceAddResponse.NonexistentProduct);
        OpinionController sut = new(opinionServiceMock.Object);
        AdditionRequest request = new(testingOpinion);

        // Act
        var response = sut.AddToProduct(request, id);

        // Assert
        var actionResult = Assert.IsType<NotFoundObjectResult>(response);
        var responseContent = Assert.IsType<string>(actionResult.Value);
        Assert.Equal($"There is no product with an id {id}.", responseContent);
    }

    [Fact]
    public void RemoveFromProduct_ExistingOpinionExistingProduct_ShouldReturnStatusOk()
    {
        // Arrange
        opinionServiceMock.Setup(osa => osa.RemoveFromProduct(id, id)).Returns(OpinionServiceRemoveResponse.Success);
        OpinionController sut = new(opinionServiceMock.Object);

        // Act
        var response = sut.RemoveFromProduct(id, id);

        // Assert
        Assert.IsType<OkResult>(response);
    }

    [Fact]
    public void RemoveFromProduct_NonexistentProduct_ShouldReturnStatusNotFound()
    {
        // Arrange
        opinionServiceMock.Setup(osa => osa.RemoveFromProduct(id, id)).Returns(OpinionServiceRemoveResponse.NonexistentProduct);
        OpinionController sut = new(opinionServiceMock.Object);

        // Act
        var response = sut.RemoveFromProduct(id, id);

        // Assert
        var actionResult = Assert.IsType<NotFoundObjectResult>(response);
        var responseContent = Assert.IsType<string>(actionResult.Value);
        Assert.Equal($"There is no product with an id {id}.", responseContent);
    }

    [Fact]
    public void RemoveFromProduct_OpinionNotFromProduct_ShouldReturnStatusNotFound()
    {
        // Arrange
        opinionServiceMock.Setup(osa => osa.RemoveFromProduct(id, id)).Returns(OpinionServiceRemoveResponse.OpinionNotFromProduct);
        OpinionController sut = new(opinionServiceMock.Object);

        // Act
        var response = sut.RemoveFromProduct(id, id);

        // Assert
        var actionResult = Assert.IsType<NotFoundObjectResult>(response);
        var responseContent = Assert.IsType<string>(actionResult.Value);
        Assert.Equal($"Product {id} does not contain an Opinion with an id {id}.", responseContent);
    }

    [Fact]
    public void GetAllReported_ShouldReturnStatusOk()
    {
        // Arrange
        testingOpinion.reportCount = 1;
        List<Opinion> opinions = new() { testingOpinion };
        opinionServiceMock.Setup(osa => osa.GetAllReported()).Returns(opinions);
        OpinionController sut = new(opinionServiceMock.Object);

        // Act
        var response = sut.GetAllReported();

        // Assert
        var actionResult = Assert.IsType<OkObjectResult>(response);
        var responseContent = Assert.IsType<GetAllReportedResponse>(actionResult.Value);
        Assert.Equal(responseContent.opinions, opinions);
    }

    [Fact]
    public void AddReport_ExistingOpinion_ShouldReturnStatusOk()
    {
        // Arrange
        opinionServiceMock.Setup(osa => osa.AddReport(id)).Returns(OpinionServiceAddReportResponse.Success);
        OpinionController sut = new(opinionServiceMock.Object);

        // Act
        var response = sut.AddReport(id);

        // Assert
        Assert.IsType<OkResult>(response);
    }

    [Fact]
    public void AddReport_NonexistentOpinion_ShouldReturnStatusNotFound()
    {
        // Arrange
        opinionServiceMock.Setup(osa => osa.AddReport(id)).Returns(OpinionServiceAddReportResponse.NonexistentOpinion);
        OpinionController sut = new(opinionServiceMock.Object);

        // Act
        var response = sut.AddReport(id);

        // Assert
        var actionResult = Assert.IsType<NotFoundObjectResult>(response);
        var responseContent = Assert.IsType<string>(actionResult.Value);
        Assert.Equal($"There is no opinion with an id {id}.", responseContent);
    }
}