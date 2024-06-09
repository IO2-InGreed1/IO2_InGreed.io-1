using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;

namespace InGreed.DataAccess.FakeDA;

public class FakePreferenceDA : IPreferenceDA
{
    private static List<Preference> _preferences = new()
    {
        new() 
        { 
            Id = 1, 
            Active = true, 
            Name = "preference 1", 
            OwnerId = 1 ,
            Category = Domain.Enums.Category.Food,
            Forbidden = new()
            {
                new() { Id = 1, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/f/f6/Ender_Pearl_JE3_BE2.png", Name = "Ender Pearl" }
            },
            Preferred = new()
            {
                new() { Id = 2, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/3/3f/Nether_Wart_(item)_JE2_BE1.png", Name = "Nether Wart" }
            }
        },
        new() 
        { 
            Id = 2, 
            Active = true, 
            Name = "preference 2", 
            OwnerId = 1,
            Category = Domain.Enums.Category.Drinks,
        },
        new() 
        { 
            Id = 3, 
            Active = false, 
            Name = "preference 3", 
            OwnerId = 1,
            Category = null,
            Forbidden = new()
            {
                 new() { Id = 3, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/b/b1/Bone_Meal_JE3_BE3.png", Name = "Bone Meal" },
                 new() { Id = 4, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/7/72/Blaze_Rod_JE2_BE2.png", Name = "Blaze Rod" }
            },
            Preferred = new()
            {
                 new() { Id = 15, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/8/8a/Gold_Ingot_JE4_BE2.png", Name = "Gold Ingot" },
                 new() { Id = 16, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/a/af/Apple_JE3_BE3.png", Name = "Apple" }
            }
        },
        new() 
        { 
            Id = 4, 
            Active = true, 
            Name = "preference 1", 
            OwnerId = 4,
            Category = Domain.Enums.Category.Cosmetics,
            Forbidden = new()
            {
                new() { Id = 16, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/a/af/Apple_JE3_BE3.png", Name = "Apple" },
                new() { Id = 17, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/e/e7/Water_Bottle_JE2_BE2.png", Name = "Water Bottle" }
            },
            Preferred = new()
            {
                new() { Id = 25, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/7/7b/Blaze_Powder_JE2_BE2.png", Name = "Blaze Powder" }
            }
        },
        new() 
        { 
            Id = 5, 
            Active = true, 
            Name = "preference 2", 
            OwnerId = 4,
            Category = null,
            Forbidden = new()
            {
                new() { Id = 7, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/e/e6/Ghast_Tear_JE2_BE2.png", Name = "Ghast Tear" },
                new() { Id = 8, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/5/51/Diamond_JE3_BE3.png", Name = "Diamond" },
                new() { Id = 9, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/2/2d/Lapis_Lazuli_JE3_BE3.png", Name = "Lapis Lazuli" },
                new() { Id = 10, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/4/4e/Redstone_Dust_JE3_BE3.png", Name = "Redstone Dust" },
                new() { Id = 11, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/6/68/Dragon_Egg_JE3_BE2.png", Name = "Dragon Egg" },
                new() { Id = 12, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/8/84/Phantom_Membrane_JE2_BE2.png", Name = "Phantom Membrane" }
            },
            Preferred = new()
            {
                new() { Id = 19, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/3/36/Glistering_Melon_Slice_JE2_BE2.png", Name = "Glistering Melon" }
            }
        },
        new() 
        { 
            Id = 6, 
            Active = false, 
            Name = "preference 3", 
            OwnerId = 4,
            Category = Domain.Enums.Category.Food
        }

    };
    private static int currentId = 6;

    public bool Contains(int preferenceId)
    {
        Preference? match = _preferences.Find(p => p.Id == preferenceId);
        return match is not null;
    }

    public int Create(Preference preference)
    {
        preference.Id = ++currentId;
        _preferences.Add(preference);
        return currentId;
    }

    public void Delete(int preferenceId)
    {
        Preference? toRemove = GetById(preferenceId);
        if (toRemove is not null) _preferences.Remove(toRemove);
    }

    public Preference? GetById(int preferenceId)
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
        if (preference.Name is not null) toModify.Name = preference.Name;
        toModify.OwnerId = preference.OwnerId;
        if (preference.Forbidden is not null)
        {
            toModify.Forbidden.Clear();
            foreach (Ingredient forbidden in preference.Forbidden) toModify.Forbidden.Add(forbidden);
        }
        if (preference.Preferred is not null)
        {
            toModify.Preferred.Clear();
            foreach (Ingredient preferred in preference.Preferred) toModify.Preferred.Add(preferred);
        }
    }
}
