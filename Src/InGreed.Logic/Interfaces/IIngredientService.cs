using InGreed.Domain.Models;

namespace InGreed.Logic.Interfaces;

public interface IIngredientService
{
    IEnumerable<Ingredient> GetAll();
    IEnumerable<Ingredient>? GetByProduct(int productId);
    Ingredient? GetById(int ingredientId);
    void AddToProduct(int ingredientId, int productId);
    void RemoveFromProuct(int ingredientId, int productId);
}
