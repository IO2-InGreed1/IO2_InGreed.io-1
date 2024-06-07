using InGreed.DataAccess.Interfaces;
using InGreed.Logic.Services;
using InGreed.Domain.Models;
using Moq;
using InGreed.Logic.Mappers;
using InGreed.Logic.Enums.Opinion;
using InGreed.DataAccess.Enums.Opinion;

namespace InGreed.Logic.Tests;
public class OpinionServiceTests
{
    Mock<IOpinionDA> opinionDAMock;
    private Opinion testingOpinion;
    private OpinionDBtoServiceResponseMapper mapper;
    private readonly int id = 1;
    private readonly int badId = 2;

    public OpinionServiceTests()
    {
        opinionDAMock = new();
        testingOpinion = new() { Id = id, productId = 1, authorId = 1, Content = "test opinion", reportCount = 0 };
        mapper = new();
    }

    [Fact]
    public void GetById_ExistingOpinion_ShouldReturnCorrectOpinion()
    {
        // Arrange
        opinionDAMock.Setup(oda => oda.GetById(id)).Returns(testingOpinion);
        opinionDAMock.Setup(oda => oda.GetById(badId)).Returns(value: null);
        OpinionService sut = new(opinionDAMock.Object, mapper);

        // Act
        var result = sut.GetById(id);

        // Assert
        Assert.Equal(result, testingOpinion);
    }

    [Fact]
    public void GetById_NonexistentOpinion_ShouldReturnNull()
    {
        // Arrange
        opinionDAMock.Setup(oda => oda.GetById(id)).Returns(testingOpinion);
        opinionDAMock.Setup(oda => oda.GetById(badId)).Returns(value: null);
        OpinionService sut = new(opinionDAMock.Object, mapper);

        // Act
        var result = sut.GetById(badId);

        // Assert
        Assert.Null(result);
    }

    [Fact]
    public void AddToProduct_NonexistentOpinionExistingProduct_ShouldReturnSuccessResponse()
    {
        // Arrange
        opinionDAMock.Setup(oda => oda.Create(testingOpinion)).Returns(id);
        opinionDAMock.Setup(oda => oda.GetById(id)).Returns(value: null);
        opinionDAMock.Setup(oda => oda.AddToProduct(id, id)).Returns(OpinionDAAddResponse.Success);
        OpinionService sut = new(opinionDAMock.Object, mapper);

        // Act
        var result = sut.AddToProduct(testingOpinion, id);

        // Assert
        Assert.Equal((OpinionServiceAddResponse.Success, id), result);
    }

    [Fact]
    public void AddToProduct_NonexistentOpinionNonexistentProduct_ShouldReturnNonexistentProductResponse()
    {
        // Arrange
        opinionDAMock.Setup(oda => oda.Create(testingOpinion)).Returns(id);
        opinionDAMock.Setup(oda => oda.GetById(id)).Returns(value: null);
        opinionDAMock.Setup(oda => oda.AddToProduct(id, id)).Returns(OpinionDAAddResponse.NonexistentProduct);
        OpinionService sut = new(opinionDAMock.Object, mapper);

        // Act
        var result = sut.AddToProduct(testingOpinion, id);

        // Assert
        Assert.Equal((OpinionServiceAddResponse.NonexistentProduct, id), result);
    }

    [Fact]
    public void AddToProduct_ExistingOpinionExistingProduct_ShouldReturnSuccessResponse()
    {
        // Arrange
        opinionDAMock.Setup(oda => oda.GetById(id)).Returns(testingOpinion);
        opinionDAMock.Setup(oda => oda.AddToProduct(id, id)).Returns(OpinionDAAddResponse.Success);
        OpinionService sut = new(opinionDAMock.Object, mapper);

        // Act
        var result = sut.AddToProduct(testingOpinion, id);

        // Assert
        Assert.Equal((OpinionServiceAddResponse.Success, id), result);
    }

    [Fact]
    public void AddToProduct_ExistingOpinionNonexistentProduct_ShouldReturnNonexistentProductResponse()
    {
        // Arrange
        opinionDAMock.Setup(oda => oda.GetById(id)).Returns(testingOpinion);
        opinionDAMock.Setup(oda => oda.AddToProduct(id, id)).Returns(OpinionDAAddResponse.NonexistentProduct);
        OpinionService sut = new(opinionDAMock.Object, mapper);

        // Act
        var result = sut.AddToProduct(testingOpinion, id);

        // Assert
        Assert.Equal((OpinionServiceAddResponse.NonexistentProduct, id), result);
    }

    [Fact]
    public void RemoveFromProduct_NonexistentOpinionExistingProduct_ShouldReturnOpinionNotFromProductResponse()
    {
        // Arrange
        opinionDAMock.Setup(oda => oda.GetById(id)).Returns(value: null);
        opinionDAMock.Setup(oda => oda.RemoveFromProduct(id, id)).Returns(OpinionDARemoveResponse.OpinionNotFromProduct);
        OpinionService sut = new(opinionDAMock.Object, mapper);

        // Act
        var result = sut.RemoveFromProduct(id, id);

        // Assert
        Assert.Equal(OpinionServiceRemoveResponse.OpinionNotFromProduct, result);
    }

    [Fact]
    public void RemoveFromProduct_NonexistentOpinionNonexistentProduct_ShouldReturnNonexistentProductResponse()
    {
        // Arrange
        opinionDAMock.Setup(oda => oda.GetById(id)).Returns(value: null);
        opinionDAMock.Setup(oda => oda.RemoveFromProduct(id, id)).Returns(OpinionDARemoveResponse.NonexistentProduct);
        OpinionService sut = new(opinionDAMock.Object, mapper);

        // Act
        var result = sut.RemoveFromProduct(id, id);

        // Assert
        Assert.Equal(OpinionServiceRemoveResponse.NonexistentProduct, result);
    }

    [Fact]
    public void RemoveFromProduct_ExistingOpinionFromTheProduct_ShouldReturnSuccessResponse()
    {
        // Arrange
        opinionDAMock.Setup(oda => oda.GetById(id)).Returns(testingOpinion);
        opinionDAMock.Setup(oda => oda.RemoveFromProduct(id, id)).Returns(OpinionDARemoveResponse.Success);
        OpinionService sut = new(opinionDAMock.Object, mapper);

        // Act
        var result = sut.RemoveFromProduct(id, id);

        // Assert
        Assert.Equal(OpinionServiceRemoveResponse.Success, result);
    }

    [Fact]
    public void RemoveFromProduct_ExistingOpinionNotFromTheProduct_ShouldReturnOpinionNotFromProductResponse()
    {
        // Arrange
        opinionDAMock.Setup(oda => oda.GetById(id)).Returns(testingOpinion);
        opinionDAMock.Setup(oda => oda.RemoveFromProduct(id, id)).Returns(OpinionDARemoveResponse.OpinionNotFromProduct);
        OpinionService sut = new(opinionDAMock.Object, mapper);

        // Act
        var result = sut.RemoveFromProduct(id, id);

        // Assert
        Assert.Equal(OpinionServiceRemoveResponse.OpinionNotFromProduct, result);
    }

    [Fact]
    public void RemoveFromProduct_ExistingOpinionNonexistentProduct_ShouldReturnNonexistentProductResponse()
    {
        // Arrange
        opinionDAMock.Setup(oda => oda.GetById(id)).Returns(testingOpinion);
        opinionDAMock.Setup(oda => oda.RemoveFromProduct(id, id)).Returns(OpinionDARemoveResponse.NonexistentProduct);
        OpinionService sut = new(opinionDAMock.Object, mapper);

        // Act
        var result = sut.RemoveFromProduct(id, id);

        // Assert
        Assert.Equal(OpinionServiceRemoveResponse.NonexistentProduct, result);
    }

    [Fact]
    public void GetAllReported_ShouldReturnAllReportedOpinions()
    {
        // Arrange
        testingOpinion.reportCount = 1;
        List<Opinion> opinions = new() { testingOpinion };
        opinionDAMock.Setup(oda => oda.GetAll()).Returns(opinions);
        OpinionService sut = new(opinionDAMock.Object, mapper);

        // Act
        var result = sut.GetAllReported();

        // Assert
        Assert.Equal(result, opinions);
    }

    [Fact]
    public void AddReport_ExistingOpinion_ShouldReturnSuccessResponse()
    {
        // Arrange
        opinionDAMock.Setup(oda => oda.GetById(id)).Returns(testingOpinion);
        opinionDAMock.Setup(oda => oda.AddReport(id)).Returns(OpinionDAAddReportResponse.Success);
        OpinionService sut = new(opinionDAMock.Object, mapper);

        // Act
        var result = sut.AddReport(id);

        // Assert
        Assert.Equal(OpinionServiceAddReportResponse.Success, result);
    }

    [Fact]
    public void AddReport_NonexistentOpinion_ShouldReturnNonexistentOpinionResponse()
    {
        // Arrange
        opinionDAMock.Setup(oda => oda.GetById(id)).Returns(value: null);
        opinionDAMock.Setup(oda => oda.AddReport(id)).Returns(OpinionDAAddReportResponse.NonexistentOpinion);
        OpinionService sut = new(opinionDAMock.Object, mapper);

        // Act
        var result = sut.AddReport(id);

        // Assert
        Assert.Equal(OpinionServiceAddReportResponse.NonexistentOpinion, result);
    }

    [Fact]
    public void RemoveReports_ExistingOpinion_ShouldReturnSuccessResponse()
    {
        // Arrange
        opinionDAMock.Setup(oda => oda.GetById(id)).Returns(testingOpinion);
        opinionDAMock.Setup(oda => oda.RemoveReports(id)).Returns(OpinionDARemoveReportsResponse.Success);
        OpinionService sut = new(opinionDAMock.Object, mapper);

        // Act
        var result = sut.RemoveReports(id);

        // Assert
        Assert.Equal(OpinionServiceRemoveReportsResponse.Success, result);
    }

    [Fact]
    public void RemoveReports_NonexistentOpinion_ShouldReturnNonexistentOpinionResponse()
    {
        // Arrange
        opinionDAMock.Setup(oda => oda.GetById(id)).Returns(value: null);
        opinionDAMock.Setup(oda => oda.RemoveReports(id)).Returns(OpinionDARemoveReportsResponse.NonexistentOpinion);
        OpinionService sut = new(opinionDAMock.Object, mapper);

        // Act
        var result = sut.RemoveReports(id);

        // Assert
        Assert.Equal(OpinionServiceRemoveReportsResponse.NonexistentOpinion, result);
    }
}