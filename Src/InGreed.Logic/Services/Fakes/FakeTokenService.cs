using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;

namespace InGreed.Logic.Services.Fakes;

public class FakeTokenService : ITokenService
{
    public string GenerateToken(User user)
    {
        return $"{user.Id} - {user.Role.ToString("G")} - validTo:{DateTime.Now.AddHours(2)}";
    }
}
