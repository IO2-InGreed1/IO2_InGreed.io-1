using InGreed.Domain.Models;

namespace InGreed.Logic.Interfaces;

public interface ITokenService
{
    string GenerateToken(User user);
}
