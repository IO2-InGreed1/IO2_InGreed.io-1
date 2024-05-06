using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;
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
    public void GetByUser_AuthorisedUser_ShouldReturnStatusOk()
    {
        // Arrange


        // Act


        // Assert

    }

    [Fact]
    public void GetByUser_UnauthorisedUser_ShouldReturnStatusForbidden()
    {
        // Arrange


        // Act


        // Assert

    }

    [Fact]
    public void Modify_ValidModification_ShouldReturnStatusOk()
    {
        // Arrange


        // Act


        // Assert

    }

    [Fact]
    public void Modify_InvalidUserId_ShouldReturnStatusBadRequest()
    {
        // Arrange


        // Act


        // Assert

    }

    [Fact]
    public void Modify_ContradictoryPreference_ShouldReturnStatusBadRequest()
    {
        // Arrange


        // Act


        // Assert

    }

    [Fact]
    public void Delete_ExistingPreference_ShouldReturnStatusOk()
    {
        // Arrange


        // Act


        // Assert

    }

    [Fact]
    public void Delete_nonexistentPreference_ShouldReturnStatusNotFound()
    {
        // Arrange


        // Act


        // Assert

    }
}
