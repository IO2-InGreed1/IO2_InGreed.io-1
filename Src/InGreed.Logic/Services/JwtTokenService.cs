using InGreed.Domain.Enums;
using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace InGreed.Logic.Services;

public class JwtTokenService : ITokenService
{
    IDateTimeProvider _dateTimeProvider;
    IConfiguration _configuration;

    public JwtTokenService(IDateTimeProvider dateTimeProvider, IConfiguration configuration)
    {
        _dateTimeProvider = dateTimeProvider;
        _configuration = configuration;
    }

    public string GenerateToken(User user)
    {
        if(user is null || string.IsNullOrEmpty(user.Email) || string.IsNullOrEmpty(user.Username))
        {
            return string.Empty;
        }

        var timeNow = new DateTimeOffset(_dateTimeProvider.Now);

        var claims = new Claim[]
        {
            new Claim(JwtRegisteredClaimNames.Sub, user.Id.ToString()),
            new Claim(JwtRegisteredClaimNames.Email, user.Email),
            new Claim(JwtRegisteredClaimNames.Name, user.Username),
            new Claim(ClaimTypes.Role, user.Role.ToString("G"))
        };
        var jwtToken = new JwtSecurityToken(
        claims: claims,
        notBefore: _dateTimeProvider.Now,
        expires: _dateTimeProvider.Now.AddHours(1),
        signingCredentials: new SigningCredentials(
            new SymmetricSecurityKey(
               Encoding.UTF8.GetBytes(_configuration["Jwt:Key"])
                ),
            SecurityAlgorithms.HmacSha256Signature)
        );
        return new JwtSecurityTokenHandler().WriteToken(jwtToken);
    }
}
