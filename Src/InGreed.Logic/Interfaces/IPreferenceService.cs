using InGreed.Domain.Models;
using InGreed.Logic.Enums.Preference;

namespace InGreed.Logic.Interfaces;

public interface IPreferenceService
{
    Preference? GetById(int preferenceId);
    IEnumerable<Preference>? GetByUser(int userId);
    PreferenceServiceModifyResponse Modify(Preference preference, int preferenceToModify);
    PreferenceServiceDeleteResponse Delete(int preferenceId);
}
