using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;
using InGreed.Logic.Enums;
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

    public IEnumerable<Ingredient> GetAll()
    {
        return _ingredientDA.GetAll();
    }

    public Ingredient? GetById(int ingredientId)
    {
        return _ingredientDA.GetById(ingredientId);
    }

    public IngredientServiceAddResponse AddToProduct(Ingredient ingredient, int productId)
    {
        throw new NotImplementedException();
    }

    public IngredientServiceRemoveResponse RemoveFromProduct(int ingredientId, int productId)
    {
        throw new NotImplementedException();
    }
}
