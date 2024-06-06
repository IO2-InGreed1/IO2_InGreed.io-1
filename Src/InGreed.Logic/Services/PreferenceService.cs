using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;
using InGreed.Logic.Enums.Preference;
using InGreed.Logic.Interfaces;
using InGreed.Logic.Mappers;

namespace InGreed.Logic.Services;

public class PreferenceService : IPreferenceService
{
    private IPreferenceDA _preferenceDA;
    private IUserDA _userDA;
    private IPreferenceCreateToModifyResponseMapper _mapper;
    public PreferenceService(IPreferenceDA preferenceDA, IUserDA userDA, IPreferenceCreateToModifyResponseMapper mapper)
    {
        _preferenceDA = preferenceDA;
        _userDA = userDA;
        _mapper = mapper;
    }

    public PreferenceServiceDeleteResponse Delete(int preferenceId)
    {
        if (!_preferenceDA.Contains(preferenceId)) return PreferenceServiceDeleteResponse.NonexistentPreference;
        _preferenceDA.Delete(preferenceId);
        return PreferenceServiceDeleteResponse.Success;
    }

    public Preference? GetById(int preferenceId)
    {
        return _preferenceDA.GetById(preferenceId);
    }

    public IEnumerable<Preference>? GetByUser(int userId)
    {
        return _preferenceDA.GetByUser(userId);
    }

    public PreferenceServiceModifyResponse Modify(Preference preference, int preferenceToModify)
    {
        PreferenceServiceModifyResponse result = _mapper.ModifyResponseMapper(Validate(preference));
        if (result != PreferenceServiceModifyResponse.Success) return result;
        if (!_preferenceDA.Contains(preferenceToModify)) return PreferenceServiceModifyResponse.NonexistentPreference;
        else _preferenceDA.Modify(preference, preferenceToModify);
        return PreferenceServiceModifyResponse.Success;
    }

    public (PreferenceServiceCreateResponse, int) Create(Preference preference)
    {
        PreferenceServiceCreateResponse result = Validate(preference);
        if (result != PreferenceServiceCreateResponse.Success) return (result, 0);
        int id = _preferenceDA.Create(preference);
        return (PreferenceServiceCreateResponse.Success, id);
    }

    private PreferenceServiceCreateResponse Validate(Preference preference)
    {
        if (preference.Forbidden.Intersect(preference.Preferred).Any()) return PreferenceServiceCreateResponse.ContradictoryPreference;
        if (_userDA.GetUserById(preference.OwnerId) is null) return PreferenceServiceCreateResponse.InvalidOwnerId;
        return PreferenceServiceCreateResponse.Success;
    }
}
