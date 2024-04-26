using InGreed.Api.Contracts.Authorization;
using InGreed.Domain.Models;
using Riok.Mapperly.Abstractions;

namespace InGreed.Api.Mappers;

[Mapper(PropertyNameMappingStrategy = PropertyNameMappingStrategy.CaseInsensitive)]
public partial class ContractsToModelsMapper : IContractsToModelsMapper
{
    public partial User LoginRequestToUser(LoginRequest request);
    public partial User RegisterRequestToUser(RegisterRequest request);
}
