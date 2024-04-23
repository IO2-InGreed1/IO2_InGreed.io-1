using InGreed.Domain.Enums;

namespace InGreed.Domain.Models;

public class User
{
    public int Id { get; set; }
    public string Email { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
    public string Username { get; set; } = string.Empty;
    public Role Role { get; set; } = 0;
    public bool Banned { get; set; } = false;

    public User() { }
    public User(int id, string email, string password, string username, Role role, bool banned)
    {
        Id = id;
        Email = email;
        Password = password;
        Username = username;
        Role = role;
        Banned = banned;
    }
}
