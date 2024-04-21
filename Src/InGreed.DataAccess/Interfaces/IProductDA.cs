using InGreed.Domain.Models;

namespace InGreed.DataAccess.Interfaces;

public interface IProductDA
{
    IEnumerable<Product> GetAll();
    Product GetById(int productId);
    IEnumerable<Product> GetByIngredient(int ingredientId);
    void Create(Product product);
    void Delete(int productId);
    void AddOpinion(int productId, int opinionId);
    void DeleteOpinion(int productId, int opinionId);
    void AddIngredient(int productId, int ingredientId);
    void DeleteIngredient(int productId, int ingredientId);
    void ChangePromotion(int productId, DateTime? until);
}
