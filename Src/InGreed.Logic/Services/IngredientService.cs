using InGreed.DataAccess.Enums;
using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;
using InGreed.Logic.Enums;
using InGreed.Logic.Interfaces;

namespace InGreed.Logic.Services;

public class IngredientService : IIngredientService
{
    private IIngredientDA _ingredientDA;

    public IngredientService(IIngredientDA ingredientDA)
    {
        _ingredientDA = ingredientDA;
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
        if (_ingredientDA.GetById(ingredient.Id) is null) ingredient.Id = _ingredientDA.Create(ingredient);
        var response = _ingredientDA.AddToProduct(ingredient.Id, productId);
        switch(response)
        {
            case IngredientDAAddResponse.Success:
                return IngredientServiceAddResponse.Success;
            case IngredientDAAddResponse.NonexistentProduct:
                return IngredientServiceAddResponse.NonexistentProduct;
            default:
                return IngredientServiceAddResponse.Unknown;
        }
    }

    public IngredientServiceRemoveResponse RemoveFromProduct(int ingredientId, int productId)
    {
        var response = _ingredientDA.RemoveFromProduct(ingredientId, productId);
        switch (response)
        {
            case IngredientDARemoveResponse.Success:
                return IngredientServiceRemoveResponse.Success;
            case IngredientDARemoveResponse.NonexistentProduct:
                return IngredientServiceRemoveResponse.NonexistentProduct;
            case IngredientDARemoveResponse.IngredientNotFromProduct:
                return IngredientServiceRemoveResponse.IngredientNotFromProduct;
            default:
                return IngredientServiceRemoveResponse.Unknown;
        }
    }
}
