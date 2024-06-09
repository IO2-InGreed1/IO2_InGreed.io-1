using InGreed.Api.Controllers;
using InGreed.Logic.Interfaces;
using InGreed.Domain.Models;
using Moq;
using Microsoft.AspNetCore.Mvc;
using InGreed.Api.Contracts.Opinion;
using InGreed.Logic.Enums.Opinion;
using InGreed.Domain.Queries;
using InGreed.Domain.Helpers;
using Microsoft.AspNetCore.Http;
using System.Security.Claims;

namespace InGreed.Api.Tests;

public class OpinionControllerTests
{
    private Mock<IOpinionService> opinionServiceMock;
    private Mock<IAccountService> accountServiceMock;
    private Mock<IProductService> productServiceMock;
    private Opinion testingOpinion;
    private User testingUser;
    private readonly int id = 1;

    public OpinionControllerTests()
    {
        opinionServiceMock = new();
        accountServiceMock = new();
        productServiceMock = new();
        testingOpinion = new() { Id = id, productId = 1, authorId = 1, Content = "test opinion", reportCount = 0 };
        testingUser = new() { Id = id, Banned = false, Email = "test", IconURL = "test", Password = "test", Role = Domain.Enums.Role.User, Username = "test" };
    }

    [Fact]
    public void GetById_ExistingOpinion_ShouldReturnStatusOk()
    {
        // Arrange
        accountServiceMock.Setup(asm => asm.GetUserById(id)).Returns(testingUser);
        opinionServiceMock.Setup(osa => osa.GetById(id)).Returns(testingOpinion);
        OpinionController sut = new(opinionServiceMock.Object, accountServiceMock.Object, productServiceMock.Object);

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
        accountServiceMock.Setup(asm => asm.GetUserById(id)).Returns(testingUser);
        opinionServiceMock.Setup(osa => osa.GetById(id)).Returns(value: null);
        OpinionController sut = new(opinionServiceMock.Object, accountServiceMock.Object, productServiceMock.Object);

        // Act
        var response = sut.GetById(id);

        // Assert
        Assert.IsType<NotFoundResult>(response);
    }

    [Fact]
    public void AddToProduct_ExistingProduct_ShouldReturnStatusOk()
    {
        // Arrange
        var context = new ControllerContext
        {
            HttpContext = new DefaultHttpContext
            {
                User = new(new List<ClaimsIdentity>() 
                { 
                    new(new List<Claim>() 
                    { 
                        new Claim(ClaimTypes.Role, "Administrator"),
                        new Claim(ClaimTypes.NameIdentifier, id.ToString())
                    }) 
                })
            }
        };
        opinionServiceMock.Setup(osa => osa.AddToProduct(testingOpinion, id)).Returns((OpinionServiceAddResponse.Success, id));
        OpinionController sut = new(opinionServiceMock.Object, accountServiceMock.Object, productServiceMock.Object);
        AdditionRequest request = new(testingOpinion);
        sut.ControllerContext = context;

        // Act
        var response = sut.AddToProduct(request);

        // Assert
        Assert.IsType<OkObjectResult>(response);
    }

    [Fact]
    public void AddToProduct_NonexistentProduct_ShouldReturnStatusBadRequest()
    {
        // Arrange
        var context = new ControllerContext
        {
            HttpContext = new DefaultHttpContext
            {
                User = new(new List<ClaimsIdentity>()
                {
                    new(new List<Claim>()
                    {
                        new Claim(ClaimTypes.Role, "Administrator"),
                        new Claim(ClaimTypes.NameIdentifier, id.ToString())
                    })
                })
            }
        };
        opinionServiceMock.Setup(osa => osa.AddToProduct(testingOpinion, id)).Returns((OpinionServiceAddResponse.NonexistentProduct, id));
        OpinionController sut = new(opinionServiceMock.Object, accountServiceMock.Object, productServiceMock.Object);
        AdditionRequest request = new(testingOpinion);
        sut.ControllerContext = context;

        // Act
        var response = sut.AddToProduct(request);

        // Assert
        var actionResult = Assert.IsType<NotFoundObjectResult>(response);
        var responseContent = Assert.IsType<string>(actionResult.Value);
        Assert.Equal($"There is no product with an id {id}.", responseContent);
    }

    [Fact]
    public void RemoveFromProduct_ExistingOpinionExistingProduct_ShouldReturnStatusOk()
    {
        // Arrange
        var context = new ControllerContext
        {
            HttpContext = new DefaultHttpContext
            {
                User = new(new List<ClaimsIdentity>() { new(new List<Claim>() { new Claim(ClaimTypes.Role, "Administrator") }) })
            }
        };
        opinionServiceMock.Setup(osa => osa.RemoveFromProduct(id, id)).Returns(OpinionServiceRemoveResponse.Success);
        OpinionController sut = new(opinionServiceMock.Object, accountServiceMock.Object, productServiceMock.Object);
        sut.ControllerContext = context;

        // Act
        var response = sut.RemoveFromProduct(id, id);

        // Assert
        Assert.IsType<OkResult>(response);
    }

    [Fact]
    public void RemoveFromProduct_NonexistentProduct_ShouldReturnStatusNotFound()
    {
        // Arrange
        var context = new ControllerContext
        {
            HttpContext = new DefaultHttpContext
            {
                User = new(new List<ClaimsIdentity>() { new(new List<Claim>() { new Claim(ClaimTypes.Role, "Administrator") }) })
            }
        };
        opinionServiceMock.Setup(osa => osa.RemoveFromProduct(id, id)).Returns(OpinionServiceRemoveResponse.NonexistentProduct);
        OpinionController sut = new(opinionServiceMock.Object, accountServiceMock.Object, productServiceMock.Object);
        sut.ControllerContext = context;

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
        var context = new ControllerContext
        {
            HttpContext = new DefaultHttpContext
            {
                User = new(new List<ClaimsIdentity>() { new(new List<Claim>() { new Claim(ClaimTypes.Role, "Administrator") }) })
            }
        };
        opinionServiceMock.Setup(osa => osa.RemoveFromProduct(id, id)).Returns(OpinionServiceRemoveResponse.OpinionNotFromProduct);
        OpinionController sut = new(opinionServiceMock.Object, accountServiceMock.Object, productServiceMock.Object);
        sut.ControllerContext = context;

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
        OpinionParameters parameters = new();
        testingOpinion.reportCount = 1;
        List<Opinion> opinions = new() { testingOpinion };
        List<OpinionWithAuthor> opinionsWithAuthors = new() 
        { 
            new() { Opinion = testingOpinion, Owner = testingUser.Username, IconURL = testingUser.IconURL }
        };
        accountServiceMock.Setup(asm => asm.GetUserById(id)).Returns(testingUser);
        opinionServiceMock.Setup(osa => osa.GetAllReported(parameters)).Returns(new PaginatedList<OpinionWithAuthor>(opinionsWithAuthors, 1, 1, parameters.PageSize));
        OpinionController sut = new(opinionServiceMock.Object, accountServiceMock.Object, productServiceMock.Object);

        // Act
        var response = sut.GetAllReported(parameters);

        // Assert
        var actionResult = Assert.IsType<OkObjectResult>(response);
        var responseContent = Assert.IsType<GetAllReportedResponse>(actionResult.Value);
        Assert.Equal(responseContent.opinions, opinionsWithAuthors);
    }

    [Fact]
    public void AddReport_ExistingOpinion_ShouldReturnStatusOk()
    {
        // Arrange
        opinionServiceMock.Setup(osa => osa.AddReport(id)).Returns(OpinionServiceAddReportResponse.Success);
        OpinionController sut = new(opinionServiceMock.Object, accountServiceMock.Object, productServiceMock.Object);

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
        OpinionController sut = new(opinionServiceMock.Object, accountServiceMock.Object, productServiceMock.Object);

        // Act
        var response = sut.AddReport(id);

        // Assert
        var actionResult = Assert.IsType<NotFoundObjectResult>(response);
        var responseContent = Assert.IsType<string>(actionResult.Value);
        Assert.Equal($"There is no opinion with an id {id}.", responseContent);
    }

    [Fact]
    public void RemoveReports_ExistingOpinion_ShouldReturnStatusOk()
    {
        // Arrange
        opinionServiceMock.Setup(osa => osa.RemoveReports(id)).Returns(OpinionServiceRemoveReportsResponse.Success);
        OpinionController sut = new(opinionServiceMock.Object, accountServiceMock.Object, productServiceMock.Object);

        // Act
        var response = sut.RemoveReports(id);

        // Assert
        Assert.IsType<OkResult>(response);
    }

    [Fact]
    public void RemoveReports_NonexistentOpinion_ShouldReturnStatusNotFound()
    {
        // Arrange
        opinionServiceMock.Setup(osa => osa.RemoveReports(id)).Returns(OpinionServiceRemoveReportsResponse.NonexistentOpinion);
        OpinionController sut = new(opinionServiceMock.Object, accountServiceMock.Object, productServiceMock.Object);

        // Act
        var response = sut.RemoveReports(id);

        // Assert
        var actionResult = Assert.IsType<NotFoundObjectResult>(response);
        var responseContent = Assert.IsType<string>(actionResult.Value);
        Assert.Equal($"There is no opinion with an id {id}.", responseContent);
    }
}