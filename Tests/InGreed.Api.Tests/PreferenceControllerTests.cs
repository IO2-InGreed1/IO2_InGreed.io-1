using InGreed.Api.Contracts.Preference;
using InGreed.Api.Controllers;
using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Moq;

namespace InGreed.Api.Tests;

public class PreferenceControllerTests
{
    private Mock<IPreferenceService> preferenceServiceMock;
    private Preference testingPreference;
    private readonly int id = 1;

    public PreferenceControllerTests()
    {
        preferenceServiceMock = new();
        testingPreference = new() { Id = id, OwnerId = id, Active = true, Name = "test" };
    }

    [Fact]
    public void GetById_ExistingPreference_ShouldReturnStatusOk()
    {
        // Arrange
        preferenceServiceMock.Setup(psm => psm.GetById(id)).Returns(testingPreference);
        PreferenceController sut = new(preferenceServiceMock.Object);

        // Act
        var response = sut.GetById(id);

        // Assert
        var actionResult = Assert.IsType<OkObjectResult>(response);
        var responseContent = Assert.IsType<Preference>(actionResult.Value);
        Assert.Equal(responseContent, testingPreference);
    }

    [Fact]
    public void GetById_NonexistentPreference_ShouldReturnStatusNotFound()
    {
        // Arrange
        preferenceServiceMock.Setup(psm => psm.GetById(id)).Returns(value: null);
        PreferenceController sut = new(preferenceServiceMock.Object);

        // Act
        var response = sut.GetById(id);

        // Assert
        var actionResult = Assert.IsType<NotFoundObjectResult>(response);
        var responseContent = Assert.IsType<string>(actionResult.Value);
        Assert.Equal($"There is no preference with an id {id}.", responseContent);
    }

    [Fact]
    public void GetByUser_AuthorisedUser_ShouldReturnStatusOk()
    {
        // Arrange
        PreferenceController sut = new(preferenceServiceMock.Object);

        // Act
        var result = sut.GetByUser();

        // Assert

    }

    [Fact]
    public void GetByUser_UnauthorisedUser_ShouldReturnStatusForbidden()
    {
        // Arrange
        PreferenceController sut = new(preferenceServiceMock.Object);

        // Act
        var result = sut.GetByUser();

        // Assert

    }

    [Fact]
    public void Modify_ValidModification_ShouldReturnStatusOk()
    {
        // Arrange
        PreferenceController sut = new(preferenceServiceMock.Object);
        ModifyRequest request = new(testingPreference);

        // Act
        var result = sut.Modify(request, id);

        // Assert

    }

    [Fact]
    public void Modify_InvalidUserId_ShouldReturnStatusBadRequest()
    {
        // Arrange
        PreferenceController sut = new(preferenceServiceMock.Object);
        ModifyRequest request = new(testingPreference);

        // Act
        var result = sut.Modify(request, id);

        // Assert

    }

    [Fact]
    public void Modify_ContradictoryPreference_ShouldReturnStatusBadRequest()
    {
        // Arrange
        PreferenceController sut = new(preferenceServiceMock.Object);

        // Act


        // Assert

    }

    [Fact]
    public void Modify_NonexistentPreference_ShouldReturnStatusNotFound()
    {
        // Arrange
        PreferenceController sut = new(preferenceServiceMock.Object);

        // Act


        // Assert

    }

    [Fact]
    public void Delete_ExistingPreference_ShouldReturnStatusOk()
    {
        // Arrange
        PreferenceController sut = new(preferenceServiceMock.Object);

        // Act


        // Assert

    }

    [Fact]
    public void Delete_nonexistentPreference_ShouldReturnStatusNotFound()
    {
        // Arrange
        PreferenceController sut = new(preferenceServiceMock.Object);

        // Act


        // Assert

    }

    [Fact]
    public void Create_ValidPreference_ShouldReturnStatusOk()
    {
        // Arrange
        PreferenceController sut = new(preferenceServiceMock.Object);

        // Act


        // Assert

    }

    [Fact]
    public void Create_ContradictoryPreference_ShouldReturnStatusBadRequest()
    {
        // Arrange
        PreferenceController sut = new(preferenceServiceMock.Object);

        // Act


        // Assert

    }

    [Fact]
    public void Create_InvalidUserId_ShouldReturnStatusBadRequest()
    {
        // Arrange
        PreferenceController sut = new(preferenceServiceMock.Object);

        // Act


        // Assert

    }
}
