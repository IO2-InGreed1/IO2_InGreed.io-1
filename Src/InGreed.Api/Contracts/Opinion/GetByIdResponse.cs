namespace InGreed.Api.Contracts.Opinion;

public record GetByIdResponse(Domain.Models.Opinion opinion, string username, string icon);
