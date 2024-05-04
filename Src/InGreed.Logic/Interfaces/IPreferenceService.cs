using InGreed.Domain.Models;

namespace InGreed.Logic.Interfaces;

public interface IPreferenceService
{
    Preference? GetById(int preferenceId);
    IEnumerable<Preference> GetByUser(int userId);

}
