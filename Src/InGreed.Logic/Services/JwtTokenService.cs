using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;

namespace InGreed.Logic.Services;

public class JwtTokenService : ITokenService
{
    IDateTimeProvider _dateTimeProvider;

    public JwtTokenService(IDateTimeProvider dateTimeProvider)
    {
        _dateTimeProvider = dateTimeProvider;
    }

    public string GenerateToken(User user)
    {
        throw new NotImplementedException();
    }
}
