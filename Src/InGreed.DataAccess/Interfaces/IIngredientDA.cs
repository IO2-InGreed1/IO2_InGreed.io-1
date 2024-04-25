using InGreed.Domain.Models;

namespace InGreed.DataAccess.Interfaces;

public interface IIngredientDA
{
    IEnumerable<Ingredient> GetAll();
    IEnumerable<Ingredient>? GetByProduct(int productId);
    Ingredient? GetById(int ingredientId);
    int Create(Ingredient ingredient);
    void AddToProduct(int ingredientId, int productId);
    void RemoveFromProuct(int ingredientId, int productId);
}
