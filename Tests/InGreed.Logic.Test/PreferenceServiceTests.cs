using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;
using InGreed.Logic.Services;
using Moq;

namespace InGreed.Logic.Tests;

public class PreferenceServiceTests
{
    private Preference testingPreference;
    private Mock<IPreferenceDA> preferenceDAMock;
    private readonly int id = 1;

    public PreferenceServiceTests() 
    { 
        testingPreference = new() { Id = id, OwnerId = id, Active = true, Name = "test" };
        preferenceDAMock = new();
    }

    [Fact]
    public void GetById_ExistingPreference_ShouldReturnCorrectPreference()
    {
        // Arrange
        preferenceDAMock.Setup(ida => ida.GetById(id)).Returns(testingPreference);
        PreferenceService sut = new(preferenceDAMock.Object);

        // Act
        var response = sut.GetById(id);

        // Assert
        Assert.Equal(testingPreference, response);
    }

    [Fact]
    public void GetById_NonexistentgPreference_ShouldReturnNull()
    {
        // Arrange
        preferenceDAMock.Setup(ida => ida.GetById(id)).Returns(value: null);
        PreferenceService sut = new(preferenceDAMock.Object);

        // Act
        var response = sut.GetById(id);

        // Assert
        Assert.Null(response);
    }

    [Fact]
    public void GetByUser_ExistingUser_ShouldReturnUserPreferences()
    {
        // Arrange
        List<Preference> preferences = new() { testingPreference };
        preferenceDAMock.Setup(ida => ida.GetByUser(id)).Returns(preferences);
        PreferenceService sut = new(preferenceDAMock.Object);

        // Act
        var response = sut.GetByUser(id);

        // Assert
        Assert.Equal(preferences, response);
    }

    [Fact]
    public void GetByUser_NonexistingUser_ShouldReturnNull()
    {
        // Arrange
        List<Preference> preferences = new() { testingPreference };
        preferenceDAMock.Setup(ida => ida.GetByUser(id)).Returns(value: null);
        PreferenceService sut = new(preferenceDAMock.Object);

        // Act
        var response = sut.GetByUser(id);

        // Assert
        Assert.Null(response);
    }

    [Fact]
    public void Delete_ExistingPreference_ShouldReturnSuccessResponse()
    {
        // Arrange


        // Act


        // Assert

    }

    [Fact]
    public void Delete_NonexistentPreference_ShouldReturnNonexistentPreferenceResponse()
    {
        // Arrange


        // Act


        // Assert

    }
}
