﻿using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;
using InGreed.Logic.Enums.Preference;
using InGreed.Logic.Interfaces;

namespace InGreed.Logic.Services;

public class PreferenceService : IPreferenceService
{
    private IPreferenceDA _preferenceDA;
    public PreferenceService(IPreferenceDA preferenceDA)
    {
        _preferenceDA = preferenceDA;
    }

    public PreferenceServiceDeleteResponse Delete(int preferenceId)
    {
        throw new NotImplementedException();
    }

    public Preference? GetById(int preferenceId)
    {
        throw new NotImplementedException();
    }

    public IEnumerable<Preference>? GetByUser(int userId)
    {
        throw new NotImplementedException();
    }

    public PreferenceServiceModifyResponse Modify(Preference preference, int preferenceToModify)
    {
        throw new NotImplementedException();
    }
}
