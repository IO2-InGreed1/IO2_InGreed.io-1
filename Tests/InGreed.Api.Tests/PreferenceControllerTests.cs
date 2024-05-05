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
    public void GetById_ExistingPreference_ShouldReturnStatusOk()
    {
        // Act


        // Arrange


        // Assert

    }

    [Fact]
    public void GetById_NonexistingPreference_ShouldReturnStatusNotFound()
    {
        // Act


        // Arrange


        // Assert

    }

    [Fact]
    public void GetByUser_ExistingUser_ShouldReturnStatusOk()
    {
        // Act


        // Arrange


        // Assert

    }

    [Fact]
    public void GetByUser_NonexistentUser_ShouldReturnStatusNotFound()
    {
        // Act


        // Arrange


        // Assert

    }

    [Fact]
    public void Modify_ValidModification_ShouldReturnStatusOk()
    {
        // Act


        // Arrange


        // Assert

    }

    [Fact]
    public void Modify_InvalidUserId_ShouldReturnStatusBadRequest()
    {
        // Act


        // Arrange


        // Assert

    }

    [Fact]
    public void Modify_ContradictoryPreference_ShouldReturnStatusBadRequest()
    {
        // Act


        // Arrange


        // Assert

    }

    [Fact]
    public void Delete_ExistingPreference_ShouldReturnStatusOk()
    {
        // Act


        // Arrange


        // Assert

    }

    [Fact]
    public void Delete_nonexistentPreference_ShouldReturnStatusNotFound()
    {
        // Act


        // Arrange


        // Assert

    }
}
