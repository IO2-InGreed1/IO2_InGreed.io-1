using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;
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


        // Act


        // Assert

    }

    [Fact]
    public void GetById_NonexistentgPreference_ShouldReturnNull()
    {
        // Arrange


        // Act


        // Assert

    }

    [Fact]
    public void GetByUser_ExistingUser_ShouldReturnUserPreferences()
    {
        // Arrange


        // Act


        // Assert

    }

    [Fact]
    public void GetByUser_NonexistingUser_ShouldReturnNull()
    {
        // Arrange


        // Act


        // Assert

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
