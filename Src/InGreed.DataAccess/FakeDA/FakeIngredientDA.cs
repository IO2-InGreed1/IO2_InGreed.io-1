using InGreed.DataAccess.Enums;
using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;

namespace InGreed.DataAccess.FakeDA;

public class FakeIngredientDA : IIngredientDA
{
    private static List<Ingredient> _ingredients = new()
    {
        new() { Id = 1, IconURL = string.Empty, Name = "Ender Pearl" },
        new() { Id = 2, IconURL = string.Empty, Name = "Nether Wart" },
        new() { Id = 3, IconURL = string.Empty, Name = "Bone Meal" }
    };
    private int currentId = 3;

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
