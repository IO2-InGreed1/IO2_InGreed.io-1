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

}
