using InGreed.Logic.Enums.Preference;
using Riok.Mapperly.Abstractions;

namespace InGreed.Logic.Mappers;

[Mapper(EnumMappingStrategy = EnumMappingStrategy.ByName, EnumMappingIgnoreCase = true)]
public partial class PreferenceCreateToModifyResponseMapper : IPreferenceCreateToModifyResponseMapper
{
    public partial PreferenceServiceModifyResponse ModifyResponseMapper(PreferenceServiceCreateResponse createResponse);
}
