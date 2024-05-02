using InGreed.DataAccess.Enums;
using InGreed.Domain.Models;

namespace InGreed.DataAccess.Interfaces;

public interface IIngredientDA
{
    IEnumerable<Ingredient> GetAll();
    Ingredient? GetById(int ingredientId);
    int Create(Ingredient ingredient);
    IngredientDAAddResponse AddToProduct(int ingredientId, int productId);
    IngredientDARemoveResponse RemoveFromProduct(int ingredientId, int productId);
}
