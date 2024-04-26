using InGreed.Api.Contracts.Authorization;
using InGreed.Domain.Models;

namespace InGreed.Api.Mappers;

public interface IContractsToModelsMapper
{
    User LoginRequestToUser(LoginRequest request);
    User RegisterRequestToUser(RegisterRequest request);
}
