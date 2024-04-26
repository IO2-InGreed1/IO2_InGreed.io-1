using InGreed.Domain.Models;

namespace InGreed.Logic.Interfaces;

public interface IIngredientService
{
    IEnumerable<Ingredient> GetAll();
    Ingredient? GetById(int ingredientId);
    void AddToProduct(Ingredient ingredient, int productId);
    void RemoveFromProuct(int ingredientId, int productId);
}
