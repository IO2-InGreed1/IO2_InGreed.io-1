using InGreed.Domain.Enums;

namespace InGreed.Domain.Models;

public class User
{
    public string Email { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
    public string Username { get; set; } = string.Empty;
    public Role Role { get; set; } = 0;
    public bool Banned { get; set; } = false;
}
