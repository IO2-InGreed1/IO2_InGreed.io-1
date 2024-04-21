using InGreed.DataAccess.Interfaces;
using InGreed.Application.Interfaces;
using InGreed.Domain.Models;

namespace InGreed.Application.Services;

public class ProductService : IProductService
{
    IProductDA _productDA;
    public ProductService(IProductDA productDA)
    {
        _productDA = productDA;
    }
    public void Create(Product product)
    {
        throw new NotImplementedException();
    }

    public void AddIngredient(Product product, Ingredient ingredient)
    {
        throw new NotImplementedException();
    }

    public void AddOpinion(Product product, Opinion opinion)
    {
        throw new NotImplementedException();
    }

    public void CancelPromotion(int productId)
    {
        throw new NotImplementedException();
    }

    public void Delete(int productId)
    {
        throw new NotImplementedException();
    }

    public void DeleteOpinion(Product product, Opinion opinion)
    {
        throw new NotImplementedException();
    }

    public IEnumerable<Product> GetAll()
    {
        throw new NotImplementedException();
    }

    public Product GetProductById(int productId)
    {
        throw new NotImplementedException();
    }

    public IEnumerable<Opinion> GetOpinions(Product product)
    {
        throw new NotImplementedException();
    }

    public IEnumerable<Ingredient> GetIngredients(Product product)
    {
        throw new NotImplementedException();
    }

    public void Promote(int productId, DateTime until)
    {
        throw new NotImplementedException();
    }

    public void RemoveIngredient(Product product, Ingredient ingredient)
    {
        throw new NotImplementedException();
    }
}
