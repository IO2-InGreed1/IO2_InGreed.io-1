using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;

namespace InGreed.Logic.Services;

public class AccountService : IAccountService
{
    IUserDA _userDA;
    ITokenService _tokenService;

    public AccountService(IUserDA userDA, ITokenService tokenService)
    {
        _userDA = userDA;
        _tokenService = tokenService;
    }

    public string Login(User user)
    {
        var email = user.Email;
        var password = user.Password;

        try
        {
            var userToCheck = _userDA.GetUserByEmail(email);
            if (userToCheck.Password != password)
            {
                throw new ArgumentException("Invalid Credentials");
            }
        }
        catch (Exception ex)
        {
            if(ex.Message == "Non existing User")
            {
                throw new ArgumentException("Invalid Credentials");
            }
            else
            {
                throw;
            }
        }

        return _tokenService.GenerateToken(user);
    }

    public string Register(User user)
    {
        try
        {
            _userDA.CreateUser(user);
        }
        catch (Exception ex)
        {
            if(ex.Message == "Existing User")
            {
                throw new ArgumentException("User already registered"); 
            }
        }

        return _tokenService.GenerateToken(user);
    }
}
