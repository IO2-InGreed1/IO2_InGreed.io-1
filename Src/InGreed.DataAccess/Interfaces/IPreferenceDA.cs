using InGreed.Domain.Models;

namespace InGreed.DataAccess.Interfaces;

public interface IPreferenceDA
{
    bool Contains(int preferenceId);
    Preference GetById(int preferenceId);
    public IEnumerable<Preference>? GetByUser(int userId);
    public void Modify(Preference preference, int preferenceToModify);
    public int Create(Preference preference);
}
