using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Enums;
using InGreed.Domain.Models;

namespace InGreed.DataAccess.FakeDA;

public class FakeUserDA : IUserDA
{
    public void CreateUser(User user)
    {
        throw new NotImplementedException();
    }

    public User GetUserByEmail(string email)
    {
        throw new NotImplementedException();
    }

    public User GetUserById(int id)
    {
        throw new NotImplementedException();
    }

    public void RemoveUserById(int id)
    {
        throw new NotImplementedException();
    }

    public void UpdateUserRoles(int id, Role newRole)
    {
        throw new NotImplementedException();
    }
}
