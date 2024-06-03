using InGreed.Domain.Models;

namespace InGreed.Logic.Interfaces;

public interface IAccountService
{
    string Login(User user);
    string Register(User user);
    User GetUserById(int id);
}
