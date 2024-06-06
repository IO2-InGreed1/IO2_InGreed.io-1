using InGreed.Domain.Enums;
using InGreed.Domain.Models;

namespace InGreed.DataAccess.Interfaces;

public interface IUserDA
{
    User GetUserById(int id);
    User GetUserByEmail(string email);
    void CreateUser(User user);
    void RemoveUserById(int id);
    void UpdateUserRoles(int id, Role newRole);
    bool AddToFavourites(int productId, int userId);
    bool RemoveFavourites(int productId, int userId);
}
