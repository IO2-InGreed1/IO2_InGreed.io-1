using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

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
        if(user is null || string.IsNullOrEmpty(user.Email) || string.IsNullOrEmpty(user.Username))
        {
            return string.Empty;
        }

        var claims = new Claim[]
        {
            new Claim(JwtRegisteredClaimNames.Sub, user.Id.ToString()),
            new Claim(JwtRegisteredClaimNames.Email, user.Email),
            new Claim(JwtRegisteredClaimNames.Name, user.Username),
            new Claim(JwtRegisteredClaimNames.Nbf, _dateTimeProvider.Now.toun),
            new Claim(JwtRegisteredClaimNames.Exp, _dateTimeProvider.Now.AddHours(1).ToLongDateString())
        };
        var jwtToken = new JwtSecurityToken(
        claims: claims,
        signingCredentials: new SigningCredentials(
            new SymmetricSecurityKey(
               Encoding.UTF8.GetBytes("ThisismySecretKeyThatIsReallyVeryLong")
                ),
            SecurityAlgorithms.HmacSha256Signature)
        );
        return new JwtSecurityTokenHandler().WriteToken(jwtToken);
    }
}
