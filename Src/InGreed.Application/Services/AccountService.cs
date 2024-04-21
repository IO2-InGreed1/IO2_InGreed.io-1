using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;

namespace InGreed.Logic.Services;

public class AccountService : IAccountService
{
    IUserDA _userDA;

    public AccountService(IUserDA userDA)
    {
        _userDA = userDA;
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

        return "";
    }

    public string Register(User user)
    {
        throw new NotImplementedException();
    }
}
