using InGreed.Domain.Models;

namespace InGreed.Application.Interfaces.Repositories;

public interface IUserRepository
{
    User GetByEmail(string email);
    void Add(User user);
}
