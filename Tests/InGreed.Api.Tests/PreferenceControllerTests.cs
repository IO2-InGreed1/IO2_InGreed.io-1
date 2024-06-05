﻿using InGreed.Api.Contracts.Preference;
using InGreed.Api.Controllers;
using InGreed.Domain.Models;
using InGreed.Logic.Enums.Preference;
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
        var responseContent = Assert.IsType<GetByIdResponse>(actionResult.Value);
        Assert.Equal(testingPreference, responseContent.preference);
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
        List<Preference> preferences = new() { testingPreference };
        preferenceServiceMock.Setup(psm => psm.GetByUser(id)).Returns(preferences);
        PreferenceController sut = new(preferenceServiceMock.Object);

        // Act
        var response = sut.GetByUser();

        // Assert
        // var actionResult = Assert.IsType<OkObjectResult>(response);
        // var responseContent = Assert.IsType<GetByUserResponse>(actionResult.Value);
        // Assert.Equal(preferences, responseContent.preferences);
    }

    [Fact]
    public void GetByUser_UnauthorisedUser_ShouldReturnStatusUnauthorised()
    {
        // Arrange
        PreferenceController sut = new(preferenceServiceMock.Object);

        // Act
        var response = sut.GetByUser();

        // Assert
        // Assert.IsType<UnauthorizedResult>(response);
    }

    [Fact]
    public void Modify_ValidModification_ShouldReturnStatusOk()
    {
        // Arrange
        preferenceServiceMock.Setup(psm => psm.Modify(testingPreference, id)).Returns(Logic.Enums.Preference.PreferenceServiceModifyResponse.Success);
        PreferenceController sut = new(preferenceServiceMock.Object);
        ModifyRequest request = new(testingPreference);

        // Act
        var response = sut.Modify(request, id);

        // Assert
        Assert.IsType<OkResult>(response);
    }

    [Fact]
    public void Modify_InvalidUserId_ShouldReturnStatusBadRequest()
    {
        // Arrange
        preferenceServiceMock.Setup(psm => psm.Modify(testingPreference, id)).Returns(Logic.Enums.Preference.PreferenceServiceModifyResponse.InvalidOwnerId);
        PreferenceController sut = new(preferenceServiceMock.Object);
        ModifyRequest request = new(testingPreference);

        // Act
        var response = sut.Modify(request, id);

        // Assert
        var actionResult = Assert.IsType<BadRequestObjectResult>(response);
        var responseContent = Assert.IsType<string>(actionResult.Value);
        Assert.Equal($"Cannot modify Preference as {id} is not a valid OwnerId.", responseContent);
    }

    [Fact]
    public void Modify_ContradictoryPreference_ShouldReturnStatusBadRequest()
    {
        // Arrange
        preferenceServiceMock.Setup(psm => psm.Modify(testingPreference, id)).Returns(Logic.Enums.Preference.PreferenceServiceModifyResponse.ContradictoryPreference);
        PreferenceController sut = new(preferenceServiceMock.Object);
        ModifyRequest request = new(testingPreference);

        // Act
        var response = sut.Modify(request, id);

        // Assert
        var actionResult = Assert.IsType<BadRequestObjectResult>(response);
        var responseContent = Assert.IsType<string>(actionResult.Value);
        Assert.Equal("Cannot modify Preference, referred and forbidden ingredients cannot overlap.", responseContent);
    }

    [Fact]
    public void Modify_NonexistentPreference_ShouldReturnStatusNotFound()
    {
        // Arrange
        preferenceServiceMock.Setup(psm => psm.Modify(testingPreference, id)).Returns(Logic.Enums.Preference.PreferenceServiceModifyResponse.NonexistentPreference);
        PreferenceController sut = new(preferenceServiceMock.Object);
        ModifyRequest request = new(testingPreference);

        // Act
        var response = sut.Modify(request, id);

        // Assert
        var actionResult = Assert.IsType<NotFoundObjectResult>(response);
        var responseContent = Assert.IsType<string>(actionResult.Value);
        Assert.Equal($"There is no preference with an id {id}.", responseContent);
    }

    [Fact]
    public void Delete_ExistingPreference_ShouldReturnStatusOk()
    {
        // Arrange
        preferenceServiceMock.Setup(psm => psm.Delete(id)).Returns(Logic.Enums.Preference.PreferenceServiceDeleteResponse.Success);
        PreferenceController sut = new(preferenceServiceMock.Object);

        // Act
        var response = sut.Delete(id);

        // Assert
        Assert.IsType<OkResult>(response);
    }

    [Fact]
    public void Delete_NonexistentPreference_ShouldReturnStatusNotFound()
    {
        // Arrange
        preferenceServiceMock.Setup(psm => psm.Delete(id)).Returns(Logic.Enums.Preference.PreferenceServiceDeleteResponse.NonexistentPreference);
        PreferenceController sut = new(preferenceServiceMock.Object);

        // Act
        var response = sut.Delete(id);

        // Assert
        var actionResult = Assert.IsType<NotFoundObjectResult>(response);
        var responseContent = Assert.IsType<string>(actionResult.Value);
        Assert.Equal($"There is no preference with an id {id}.", responseContent);
    }

    [Fact]
    public void Create_ValidPreference_ShouldReturnStatusOk()
    {
        // Arrange
        preferenceServiceMock.Setup(psm => psm.Create(testingPreference)).Returns((PreferenceServiceCreateResponse.Success, id));
        PreferenceController sut = new(preferenceServiceMock.Object);
        CreateRequest request = new(testingPreference);

        // Act
        var response = sut.Create(request);

        // Assert
        var actionResult = Assert.IsType<OkObjectResult>(response);
        var responseContent = Assert.IsType<int>(actionResult.Value);
        Assert.Equal(id, responseContent);
    }

    [Fact]
    public void Create_ContradictoryPreference_ShouldReturnStatusBadRequest()
    {
        // Arrange
        preferenceServiceMock.Setup(psm => psm.Create(testingPreference)).Returns((PreferenceServiceCreateResponse.ContradictoryPreference, id));
        PreferenceController sut = new(preferenceServiceMock.Object);
        CreateRequest request = new(testingPreference);

        // Act
        var response = sut.Create(request);

        // Assert
        var actionResult = Assert.IsType<BadRequestObjectResult>(response);
        var responseContent = Assert.IsType<string>(actionResult.Value);
        Assert.Equal("Cannot modify Preference, referred and forbidden ingredients cannot overlap.", responseContent);
    }

    [Fact]
    public void Create_InvalidUserId_ShouldReturnStatusBadRequest()
    {
        // Arrange
        preferenceServiceMock.Setup(psm => psm.Create(testingPreference)).Returns((PreferenceServiceCreateResponse.InvalidOwnerId, id));
        PreferenceController sut = new(preferenceServiceMock.Object);
        CreateRequest request = new(testingPreference);

        // Act
        var response = sut.Create(request);

        // Assert
        var actionResult = Assert.IsType<BadRequestObjectResult>(response);
        var responseContent = Assert.IsType<string>(actionResult.Value);
        Assert.Equal($"Cannot modify Preference as {id} is not a valid OwnerId.", responseContent);
    }
}