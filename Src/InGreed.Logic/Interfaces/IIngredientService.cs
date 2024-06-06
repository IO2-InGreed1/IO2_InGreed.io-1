using InGreed.Domain.Models;
using InGreed.Logic.Enums.Ingredient;

namespace InGreed.Logic.Interfaces;

public interface IIngredientService
{
    IEnumerable<Ingredient> GetAll();
    Ingredient? GetById(int ingredientId);
    IngredientServiceAddResponse AddToProduct(Ingredient ingredient, int productId);
    IngredientServiceRemoveResponse RemoveFromProduct(int ingredientId, int productId);
}
