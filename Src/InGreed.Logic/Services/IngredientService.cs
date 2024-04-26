using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;

namespace InGreed.Logic.Services;

public class IngredientService : IIngredientService
{
    private IIngredientDA _ingredientDA;
    public IngredientService(IIngredientDA ingredientDA)
    {
        _ingredientDA = ingredientDA;
    }

    public void AddToProduct(Ingredient ingredient, int productId)
    {
        throw new NotImplementedException();
    }

    public IEnumerable<Ingredient> GetAll()
    {
        throw new NotImplementedException();
    }

    public Ingredient? GetById(int ingredientId)
    {
        throw new NotImplementedException();
    }

    public void RemoveFromProuct(int ingredientId, int productId)
    {
        throw new NotImplementedException();
    }
}
