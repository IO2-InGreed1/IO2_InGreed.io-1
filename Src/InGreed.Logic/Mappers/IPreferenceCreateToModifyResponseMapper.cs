using InGreed.Logic.Enums.Preference;

namespace InGreed.Logic.Mappers;

public interface IPreferenceCreateToModifyResponseMapper
{
    PreferenceServiceModifyResponse ModifyResponseMapper(PreferenceServiceCreateResponse createResponse);
}
