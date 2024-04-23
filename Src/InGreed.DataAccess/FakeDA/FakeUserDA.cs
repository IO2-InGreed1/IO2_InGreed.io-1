using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Enums;
using InGreed.Domain.Models;

namespace InGreed.DataAccess.FakeDA;

public class FakeUserDA : IUserDA
{
    private List<User> _users = new()
    {
        new(){Id = 1, Email = "example1@mail.com", Password = "1", Username = "User 1", Role = Role.User, Banned = false },
        new(){Id = 2, Email = "example2@mail.com", Password = "2", Username = "User 2", Role = Role.Moderator, Banned = false },
        new(){Id = 3, Email = "example3@mail.com", Password = "3", Username = "User 3", Role = Role.Producent, Banned =false }
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
