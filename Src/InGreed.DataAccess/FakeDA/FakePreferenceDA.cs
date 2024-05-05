﻿using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;

namespace InGreed.DataAccess.FakeDA;

public class FakePreferenceDA : IPreferenceDA
{
    private static List<Preference> _preferences = new()
    {
        new() { Id = 1, Active = true, Name = "preference 1", OwnerId = 2 },
        new() { Id = 2, Active = true, Name = "preference 2", OwnerId = 1 },
        new() { Id = 3, Active = false, Name = "preference 3", OwnerId = 2 }
    };
    private int currentId = 3;

    public bool Contains(int preferenceId)
    {
        Preference? match = _preferences.Find(p => p.Id == preferenceId);
        return match is not null;
    }

    public int Create(Preference preference)
    {
        if (Contains(currentId)) return 0;
        preference.Id = ++currentId;
        _preferences.Add(preference);
        return currentId;
    }

    public Preference GetById(int preferenceId)
    {
        return _preferences.Find(p => p.Id == preferenceId)!; 
    }

    public IEnumerable<Preference>? GetByUser(int userId)
    {
        FakeUserDA userDA = new();
        if (userDA.GetUserById(userId) is null) return null;
        return _preferences.Where(p => p.OwnerId == userId);
    }

    public void Modify(Preference preference, int preferenceToModify)
    {
        if (!Contains(currentId)) return;
        Preference toModify = GetById(preferenceToModify);
        toModify.Active = preference.Active;
        toModify.Name = preference.Name;
        toModify.OwnerId = preference.OwnerId;
        toModify.Forbidden.Clear();
        foreach (Ingredient forbidden in preference.Forbidden) toModify.Forbidden.Add(forbidden);
        toModify.Preferred.Clear();
        foreach (Ingredient preferred in preference.Preferred) toModify.Preferred.Add(preferred);
    }
}
