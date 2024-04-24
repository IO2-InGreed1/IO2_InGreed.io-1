using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;

namespace InGreed.Logic.Services;

public class IngredientService : IIngredientService
{
    public void AddToProduct(int ingredientId, int productId)
    {
        throw new NotImplementedException();
    }

    public int Create(Ingredient ingredient)
    {
        throw new NotImplementedException();
    }

    public void Delete(int ingredientId)
    {
        throw new NotImplementedException();
    }

    public IEnumerable<Ingredient> GetAll()
    {
        throw new NotImplementedException();
    }

    public Ingredient GetById(int ingredientId)
    {
        throw new NotImplementedException();
    }

    public IEnumerable<Ingredient> GetByProduct(int productId)
    {
        throw new NotImplementedException();
    }

    public void RemoveFromProuct(int ingredientId, int productId)
    {
        throw new NotImplementedException();
    }
}
