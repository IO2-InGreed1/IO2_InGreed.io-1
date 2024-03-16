using InGreed.Application.Interfaces.Repositories;
using InGreed.Domain.Models;

namespace InGreed.Application.Repositories.InMemory;

public class UserInMemoryRepository : IUserRepository
{
    public void Add(User user)
    {
        throw new NotImplementedException();
    }

    public User GetByEmail(string email)
    {
        throw new NotImplementedException();
    }
}
