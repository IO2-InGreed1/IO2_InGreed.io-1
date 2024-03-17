using InGreed.Application.Interfaces.Repositories;
using InGreed.Domain.Models;

namespace InGreed.Application.Repositories.InMemory;

public class InMemoryUserRepository : IUserRepository
{
    List<User> _users = new List<User>();
    public void Add(User user)
    {
        if(GetByEmail(user.Email) != null)
        {
            throw new InvalidOperationException("User already exists");
        }
        _users.Add(user);
    }

    public User? GetByEmail(string email)
    {
        return _users.Find(x => x.Email == email);
    }
}
