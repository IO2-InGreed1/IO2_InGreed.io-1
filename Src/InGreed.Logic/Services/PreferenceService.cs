using InGreed.Domain.Models;
using InGreed.Logic.Enums.Preference;
using InGreed.Logic.Interfaces;

namespace InGreed.Logic.Services;

public class PreferenceService : IPreferenceService
{
    public PreferenceServiceDeleteResponse Delete(int preferenceId)
    {
        throw new NotImplementedException();
    }

    public Preference? GetById(int preferenceId)
    {
        throw new NotImplementedException();
    }

    public IEnumerable<Preference> GetByUser(int userId)
    {
        throw new NotImplementedException();
    }

    public void Modify(Preference preference, int preferenceToModify)
    {
        throw new NotImplementedException();
    }
}
