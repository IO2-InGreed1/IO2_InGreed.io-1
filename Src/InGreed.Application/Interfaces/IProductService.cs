using InGreed.Domain.Models;

namespace InGreed.Application.Interfaces;

public interface IProductService
{
    IEnumerable<Product> GetAll();
    Product GetProductById(int productId);
    void Create(Product product);
    void Delete(int productId);
    void Promote(int productId, DateTime until);
    void CancelPromotion(int productId);
    void AddOpinion(Product product, Opinion opinion);
    void DeleteOpinion(Product product, Opinion opinion);
    IEnumerable<Opinion> GetOpinions(Product product);
    void AddIngredient(Product product, Ingredient ingredient);
    void RemoveIngredient(Product product, Ingredient ingredient);
    IEnumerable<Ingredient> GetIngredients(Product product);
}
