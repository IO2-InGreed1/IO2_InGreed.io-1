using InGreed.Domain.Models;

namespace InGreed.Application.Interfaces;

public interface IProductService
{
    IEnumerable<Product> GetAll();
    Product GetProductById(int productId);
    void Add(Product product);
    void Delete(Product product);
    void Promote(int productId, DateTime until);
    void CancelPromotion(int productId);
    void AddOpinion(Product product, Opinion opinion);
    void DeleteOpinion(Product product, Opinion opinion);
    void AddIngredient(Product product, Ingredient ingredient);
    void RemoveIngredient(Product product, Ingredient ingredient);
}
