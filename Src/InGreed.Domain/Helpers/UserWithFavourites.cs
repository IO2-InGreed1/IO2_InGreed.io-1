using InGreed.Domain.Enums;
using InGreed.Domain.Models;

namespace InGreed.Domain.Helpers
{
    public class UserWithFavourites
    {
        public int Id { get; set; }
        public string Email { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public string Username { get; set; } = string.Empty;
        public Role Role { get; set; } = 0;
        public bool Banned { get; set; } = false;
        public string IconURL { get; set; } = string.Empty;
        public List<ProductWithOwner> Favourites { get; set; } = new();

        public UserWithFavourites(User u, List<ProductWithOwner> favourites)
        {
            Id = u.Id;
            Email = u.Email;
            Password = u.Password;
            Username = u.Username;
            Role = u.Role;
            Banned = u.Banned;
            IconURL = u.IconURL;
            Favourites = favourites;
        }
    }
}
