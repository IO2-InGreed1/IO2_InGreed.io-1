using InGreed.Domain.Models;
using Microsoft.AspNetCore.Identity;

namespace InGreed.DataAccess;

public class UserFakeRepository : IUserStore<User>, IUserEmailStore<User>, IUserPasswordStore<User>
{
    static List<User> _users = new List<User>();
    public Task<IdentityResult> CreateAsync(User user, CancellationToken cancellationToken)
    {
        _users.Add(user);
        return Task.FromResult(IdentityResult.Success);
    }

    public Task<IdentityResult> DeleteAsync(User user, CancellationToken cancellationToken)
    {
        _users.Remove(user);
        return Task.FromResult(IdentityResult.Success);
    }

    public void Dispose()
    {
    }

    public Task<User?> FindByEmailAsync(string normalizedEmail, CancellationToken cancellationToken)
    {
        var result = _users.Where(u => u.Email == normalizedEmail).FirstOrDefault();
        return Task.FromResult(result);
    }

    public Task<User?> FindByIdAsync(string userId, CancellationToken cancellationToken)
    {
        var result = _users.Where(u => u.Username == userId).FirstOrDefault();
        return Task.FromResult(result);
    }

    public Task<User?> FindByNameAsync(string normalizedUserName, CancellationToken cancellationToken)
    {
        var result = _users.Where(u => u.Username== normalizedUserName).FirstOrDefault();
        return Task.FromResult(result);
    }

    public Task<string?> GetEmailAsync(User user, CancellationToken cancellationToken)
    {
        return Task.FromResult(user.Email);
    }

    public Task<bool> GetEmailConfirmedAsync(User user, CancellationToken cancellationToken)
    {
        return Task.FromResult(true);
    }

    public Task<string?> GetNormalizedEmailAsync(User user, CancellationToken cancellationToken)
    {
        return Task.FromResult(user.Email);
    }

    public Task<string?> GetNormalizedUserNameAsync(User user, CancellationToken cancellationToken)
    {
        return Task.FromResult(user.Username);
    }

    public Task<string?> GetPasswordHashAsync(User user, CancellationToken cancellationToken)
    {
        return Task.FromResult(user.Password);
    }

    public Task<string> GetUserIdAsync(User user, CancellationToken cancellationToken)
    {
        return Task.FromResult(user.Email);
    }

    public Task<string?> GetUserNameAsync(User user, CancellationToken cancellationToken)
    {
        return Task.FromResult(user.Username);
    }

    public Task<bool> HasPasswordAsync(User user, CancellationToken cancellationToken)
    {
        return Task.FromResult(true);
    }

    public Task SetEmailAsync(User user, string? email, CancellationToken cancellationToken)
    {
        user.Email = email;
        return Task.CompletedTask;
    }

    public Task SetEmailConfirmedAsync(User user, bool confirmed, CancellationToken cancellationToken)
    {
        return Task.CompletedTask;
    }

    public Task SetNormalizedEmailAsync(User user, string? normalizedEmail, CancellationToken cancellationToken)
    {
        user.Email = normalizedEmail;
        return Task.CompletedTask;
    }

    public Task SetNormalizedUserNameAsync(User user, string? normalizedName, CancellationToken cancellationToken)
    {
        user.Username = normalizedName;
        return Task.CompletedTask;
    }

    public Task SetPasswordHashAsync(User user, string? passwordHash, CancellationToken cancellationToken)
    {
        user.Password = passwordHash;
        return Task.CompletedTask;
    }

    public Task SetUserNameAsync(User user, string? userName, CancellationToken cancellationToken)
    {
        user.Username = userName;
        return Task.CompletedTask;
    }

    public Task<IdentityResult> UpdateAsync(User user, CancellationToken cancellationToken)
    {
        throw new NotImplementedException();
    }
}
