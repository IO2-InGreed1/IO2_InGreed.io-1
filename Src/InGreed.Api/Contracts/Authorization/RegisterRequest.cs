namespace InGreed.Api.Contracts.Authorization;

public record RegisterRequest(string email, string username, string password);
