using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;
using InGreed.Logic.Services;
using InGreed.Logic.Enums.Preference;
using Moq;

namespace InGreed.Logic.Tests;

public class PreferenceServiceTests
{
    private Preference testingPreference;
    private Mock<IPreferenceDA> preferenceDAMock;
    private Mock<IUserDA> userDAMock;
    private readonly int id = 1;

    public PreferenceServiceTests() 
    { 
        testingPreference = new() { Id = id, OwnerId = id, Active = true, Name = "test" };
        preferenceDAMock = new();
        userDAMock = new();
    }

    [Fact]
    public void GetById_ExistingPreference_ShouldReturnCorrectPreference()
    {
        // Arrange
        preferenceDAMock.Setup(ida => ida.GetById(id)).Returns(testingPreference);
        PreferenceService sut = new(preferenceDAMock.Object, userDAMock.Object);

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
        PreferenceService sut = new(preferenceDAMock.Object, userDAMock.Object);

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
        PreferenceService sut = new(preferenceDAMock.Object, userDAMock.Object);

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
        PreferenceService sut = new(preferenceDAMock.Object, userDAMock.Object);

        // Act
        var response = sut.GetByUser(id);

        // Assert
        Assert.Null(response);
    }

    [Fact]
    public void Modify_ValidModification_ShouldReturnSuccessResponse()
    {
        // Arrange
        User testingUser = new() { Banned = false, Email = "test@test.test", Id = id, Password = "test", Role = Domain.Enums.Role.User, Username = "test" };
        userDAMock.Setup(uda => uda.GetUserById(id)).Returns(testingUser);
        preferenceDAMock.Setup(pda => pda.Modify(testingPreference, id));
        PreferenceService sut = new(preferenceDAMock.Object, userDAMock.Object);

        // Act
        var response = sut.Modify(testingPreference, id);

        // Assert
        Assert.Equal(PreferenceServiceModifyResponse.Success, response);
    }

    [Fact]
    public void Modify_InvalidUserId_ShouldReturnInvalidOwnerIdResponse()
    {
        // Arrange
        userDAMock.Setup(uda => uda.GetUserById(id)).Returns(value: null!);
        preferenceDAMock.Setup(pda => pda.Modify(testingPreference, id));
        PreferenceService sut = new(preferenceDAMock.Object, userDAMock.Object);

        // Act
        var response = sut.Modify(testingPreference, id);

        // Assert
        Assert.Equal(PreferenceServiceModifyResponse.InvalidOwnerId, response);
    }

    [Fact]
    public void Modify_ContradictoryPreference_ShouldReturnContradictoryPreferenceResponse()
    {
        // Arrange
        Ingredient testingIngredient = new() { Id = id, IconURL = string.Empty, Name = "test" };
        testingPreference.Preferred.Add(testingIngredient);
        testingPreference.Forbidden.Add(testingIngredient);
        User testingUser = new() { Banned = false, Email = "test@test.test", Id = id, Password = "test", Role = Domain.Enums.Role.User, Username = "test" };
        userDAMock.Setup(uda => uda.GetUserById(id)).Returns(testingUser);
        preferenceDAMock.Setup(pda => pda.Modify(testingPreference, id));
        PreferenceService sut = new(preferenceDAMock.Object, userDAMock.Object);

        // Act
        var response = sut.Modify(testingPreference, id);

        // Assert
        Assert.Equal(PreferenceServiceModifyResponse.ContradictoryPreference, response);
    }

    [Fact]
    public void Delete_ExistingPreference_ShouldReturnSuccessResponse()
    {
        // Arrange
        preferenceDAMock.Setup(ida => ida.Contains(id)).Returns(true);
        preferenceDAMock.Setup(ida => ida.Delete(id));
        PreferenceService sut = new(preferenceDAMock.Object, userDAMock.Object);

        // Act
        var response = sut.Delete(id);

        // Assert
        Assert.Equal(PreferenceServiceDeleteResponse.Success, response);
    }

    [Fact]
    public void Delete_NonexistentPreference_ShouldReturnNonexistentPreferenceResponse()
    {
        // Arrange
        preferenceDAMock.Setup(ida => ida.Contains(id)).Returns(false);
        preferenceDAMock.Setup(ida => ida.Delete(id));
        PreferenceService sut = new(preferenceDAMock.Object, userDAMock.Object);

        // Act
        var response = sut.Delete(id);

        // Assert
        Assert.Equal(PreferenceServiceDeleteResponse.NonexistentPreference, response);
    }
}
