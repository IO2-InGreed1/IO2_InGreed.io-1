using InGreed.DataAccess.Enums;
using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;

namespace InGreed.DataAccess.FakeDA;

public class FakeIngredientDA : IIngredientDA
{
    private static List<Ingredient> _ingredients = new()
    {
        new() { Id = 1, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/f/f6/Ender_Pearl_JE3_BE2.png", Name = "Ender Pearl" },
        new() { Id = 2, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/3/3f/Nether_Wart_(item)_JE2_BE1.png", Name = "Nether Wart" },
        new() { Id = 3, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/b/b1/Bone_Meal_JE3_BE3.png", Name = "Bone Meal" },
        new() { Id = 4, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/7/72/Blaze_Rod_JE2_BE2.png", Name = "Blaze Rod" },
        new() { Id = 5, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/c/c3/Slimeball_JE2_BE2.png", Name = "Slimeball" },
        new() { Id = 6, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/3/3a/Emerald_JE3_BE3.png", Name = "Emerald" },
        new() { Id = 7, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/e/e6/Ghast_Tear_JE2_BE2.png", Name = "Ghast Tear" },
        new() { Id = 8, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/5/51/Diamond_JE3_BE3.png", Name = "Diamond" },
        new() { Id = 9, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/2/2d/Lapis_Lazuli_JE3_BE3.png", Name = "Lapis Lazuli" },
        new() { Id = 10, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/4/4e/Redstone_Dust_JE3_BE3.png", Name = "Redstone Dust" },
        new() { Id = 11, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/6/68/Dragon_Egg_JE3_BE2.png", Name = "Dragon Egg" },
        new() { Id = 12, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/8/84/Phantom_Membrane_JE2_BE2.png", Name = "Phantom Membrane" },
        new() { Id = 13, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/1/16/Nautilus_Shell_JE2_BE2.png", Name = "Nautilus Shell" },
        new() { Id = 14, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/4/44/Shulker_Shell_JE2_BE2.png", Name = "Shulker Shell" },
        new() { Id = 15, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/8/8a/Gold_Ingot_JE4_BE2.png", Name = "Gold Ingot" },
        new() { Id = 16, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/a/af/Apple_JE3_BE3.png", Name = "Apple" },
        new() { Id = 17, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/e/e7/Water_Bottle_JE2_BE2.png", Name = "Water Bottle" },
        new() { Id = 19, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/3/36/Glistering_Melon_Slice_JE2_BE2.png", Name = "Glistering Melon" },
        new() { Id = 25, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/7/7b/Blaze_Powder_JE2_BE2.png", Name = "Blaze Powder" }
    };
    private static int currentId = 25;

    public IngredientDAAddResponse AddToProduct(int ingredient, int productId)
    {
        return IngredientDAAddResponse.Success;
    }

    public int Create(Ingredient ingredient)
    {
        if (GetById(ingredient.Id) is not null) return 0;
        ingredient.Id = ++currentId;
        _ingredients.Add(ingredient);
        return currentId;
    }

    public IEnumerable<Ingredient> GetAll()
    {
        return _ingredients;
    }

    public Ingredient? GetById(int ingredientId)
    {
        return _ingredients.Find(p => p.Id == ingredientId);
    }

    public IngredientDARemoveResponse RemoveFromProduct(int ingredientId, int productId)
    {
        return IngredientDARemoveResponse.Success;
    }
}
