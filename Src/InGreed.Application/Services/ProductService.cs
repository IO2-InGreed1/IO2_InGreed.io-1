using InGreed.Application.Interfaces;
using InGreed.Domain.Models;

namespace InGreed.Application.Services;

public class ProductService : IProductService
{
    public void AddIngredient(Product product, Ingredient ingredient)
    {
        throw new NotImplementedException();
    }

    public void AddOpinion(Product product, Opinion opinion)
    {
        throw new NotImplementedException();
    }

    public void DeleteOpinion(Product product, Opinion opinion)
    {
        throw new NotImplementedException();
    }

    public IEnumerable<Product> GetAllProducts()
    {
        throw new NotImplementedException();
    }

    public Product GetProductById(int productId)
    {
        throw new NotImplementedException();
    }

    public void PromoteProduct(int productId)
    {
        throw new NotImplementedException();
    }

    public void RemoveIngredient(Product product, Ingredient ingredient)
    {
        throw new NotImplementedException();
    }
}
