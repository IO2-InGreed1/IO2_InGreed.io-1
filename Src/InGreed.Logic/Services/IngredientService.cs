using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;

namespace InGreed.Logic.Services;

public class IngredientService : IIngredientService
{
    private IIngredientDA _ingredientDA;
    private IProductDA _productDA;

    public IngredientService(IIngredientDA ingredientDA, IProductDA productDA)
    {
        _ingredientDA = ingredientDA;
        _productDA = productDA;
    }

    public void AddToProduct(Ingredient ingredient, int productId)
    {
        throw new NotImplementedException();
    }

    public IEnumerable<Ingredient> GetAll()
    {
        return _ingredientDA.GetAll();
    }

    public Ingredient? GetById(int ingredientId)
    {
        return _ingredientDA.GetById(ingredientId);
    }

    public void RemoveFromProuct(int ingredientId, int productId)
    {
        throw new NotImplementedException();
    }
}
