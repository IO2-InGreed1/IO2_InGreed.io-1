using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;

namespace InGreed.DataAccess.FakeDA;

public class FakeIngredientDA : IIngredientDA
{
    public void AddToProduct(int ingredientId, int productId)
    {
        throw new NotImplementedException();
    }

    public int Create(Ingredient ingredient)
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
