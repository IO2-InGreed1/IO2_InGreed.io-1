using InGreed.Domain.Models;

namespace InGreed.DataAccess.Interfaces;

public interface IProductDA
{
    Product GetById(int productId);
    IEnumerable<Ingredient> ListIngredients(int productId);
    IEnumerable<Product> GetByIngredient(int ingredientId);
    void Create(Product product);
    void Delete(int productId);
    void AddOpinion(int productId, int opinionId);
    void DeleteOpinion(int productId, int opinionId);
    void AddIngredient(int productId, int ingredientId);
    void DeleteIngredient(int productId, int ingredientId);
    void CancelPromotion(int productId);
    void Promote(DateTime until);
}
