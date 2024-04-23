using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Enums;
using InGreed.Domain.Models;

namespace InGreed.DataAccess.FakeDA;

public class FakeUserDA : IUserDA
{
    private List<User> _users = new()
    {
        new(1, "example1@mail.com", "1", "User 1", Role.User, false),
        new(2, "example2@mail.com", "2", "User 2", Role.Moderator, false),
        new(3, "example3@mail.com", "3", "User 3", Role.Producent, false)
    };

    public void CreateUser(User user)
    {
        _users.Add(user);
    }

    public User GetUserByEmail(string email)
    {
        return _users.Find(u => u.Email == email)!;
    }

    public User GetUserById(int id)
    {
        return _users.Find(u => u.Id == id)!;
    }

    public void RemoveUserById(int id)
    {
        User toRemove = GetUserById(id);
        if (toRemove is not null) _users.Remove(toRemove);
    }

    public void UpdateUserRoles(int id, Role newRole)
    {
        User toUpdate = GetUserById(id);
        if (toUpdate is not null) toUpdate.Role = newRole;
    }
}
