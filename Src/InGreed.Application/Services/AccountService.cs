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
        throw new NotImplementedException();
    }

    public string Register(User user)
    {
        throw new NotImplementedException();
    }
}
