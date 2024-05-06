using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;
using InGreed.Logic.Enums.Preference;
using InGreed.Logic.Interfaces;

namespace InGreed.Logic.Services;

public class PreferenceService : IPreferenceService
{
    private IPreferenceDA _preferenceDA;
    private IUserDA _userDA;
    public PreferenceService(IPreferenceDA preferenceDA, IUserDA userDA)
    {
        _preferenceDA = preferenceDA;
        _userDA = userDA;
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
        if (preference.Forbidden.Intersect(preference.Preferred).Any()) return PreferenceServiceModifyResponse.ContradictoryPreference;
        if (_userDA.GetUserById(preference.OwnerId) is null) return PreferenceServiceModifyResponse.InvalidOwnerId;
        if (!_preferenceDA.Contains(preferenceToModify)) preference.Id = _preferenceDA.Create(preference);
        else _preferenceDA.Modify(preference, preferenceToModify);
        return PreferenceServiceModifyResponse.Success;
    }
}
