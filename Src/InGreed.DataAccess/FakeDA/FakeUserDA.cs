using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Enums;
using InGreed.Domain.Models;

namespace InGreed.DataAccess.FakeDA;

public class FakeUserDA : IUserDA
{
    private static List<User> _users = new()
    {
        new()
        {
            Id = 1, 
            Email = "example1@mail.com", 
            Password = "1", 
            Username = "Funny guy", 
            Role = Role.User, 
            Banned = false,
            IconURL = "https://img.freepik.com/premium-vector/people-profile-graphic_24911-21373.jpg",
            Favourites = new() { 1,2,3 }
        },
        new()
        {
            Id = 2, 
            Email = "example2@mail.com", 
            Password = "2", Username = "User 2", 
            Role = Role.Moderator, Banned = true,
            IconURL = "https://img.freepik.com/premium-vector/people-profile-graphic_24911-21373.jpg" 
        },
        new()
        {
            Id = 3, 
            Email = "example3@mail.com", 
            Password = "3", 
            Username = "Best Products", 
            Role = Role.Producent, 
            Banned =false,
            IconURL = "https://img.freepik.com/premium-vector/people-profile-graphic_24911-21373.jpg" 
        },
        new()
        {
            Id = 4, 
            Email = "client", 
            Password = "client", 
            Username = "client", 
            Role = Role.User, 
            Banned = false,
            IconURL = "https://img.freepik.com/premium-vector/people-profile-graphic_24911-21373.jpg",
            Favourites = new() { 5,6,7,8 }
        },
        new()
        {
            Id = 5, 
            Email = "producer", 
            Password = "producer", 
            Username = "Worst Products", 
            Role = Role.Producent, 
            Banned =false,
            IconURL = "https://img.freepik.com/premium-vector/people-profile-graphic_24911-21373.jpg" 
        },
        new()
        {
            Id = 6, 
            Email = "admin", 
            Password = "admin", 
            Username = "admin", 
            Role = Role.Administrator, 
            Banned = false,
            IconURL = "https://img.freepik.com/premium-vector/people-profile-graphic_24911-21373.jpg" 
        },
        new()
        {
            Id = 7, 
            Email = "moderator", 
            Password = "moderator", 
            Username = "moderator", 
            Role = Role.Moderator, 
            Banned =false,
            IconURL = "https://img.freepik.com/premium-vector/people-profile-graphic_24911-21373.jpg" 
        }
    };
    private static int currentId = 7;

    public bool AddToFavourites(int productId, int userId)
    {
        User toUpdate = GetUserById(userId);
        if (toUpdate is null) return false;
        if (toUpdate.Favourites.Contains(productId)) return false;
        toUpdate.Favourites.Add(productId);
        return true;
    }

    public void CreateUser(User user)
    {
        user.Id = ++currentId;
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

    public bool RemoveFavourites(int productId, int userId)
    {
        User toUpdate = GetUserById(userId);
        if (toUpdate is null) return false;
        if (!toUpdate.Favourites.Contains(productId)) return false;
        toUpdate.Favourites.Remove(productId);
        return true;
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
