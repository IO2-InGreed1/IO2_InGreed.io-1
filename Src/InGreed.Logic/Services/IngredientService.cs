using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;
using InGreed.Logic.Enums.Ingredient;
using InGreed.Logic.Interfaces;
using InGreed.Logic.Mappers;

namespace InGreed.Logic.Services;

public class IngredientService : IIngredientService
{
    private IIngredientDA _ingredientDA;
    private IIngredientDBtoServiceResponseMapper _dbtoServiceResponseMapper;

    public IngredientService(IIngredientDA ingredientDA, IIngredientDBtoServiceResponseMapper mapper)
    {
        _ingredientDA = ingredientDA;
        _dbtoServiceResponseMapper = mapper;
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
        return _dbtoServiceResponseMapper.AddResponseMapper(response);
    }

    public IngredientServiceRemoveResponse RemoveFromProduct(int ingredientId, int productId)
    {
        var response = _ingredientDA.RemoveFromProduct(ingredientId, productId);
        return _dbtoServiceResponseMapper.RemoveResponseMapper(response);
    }
}
