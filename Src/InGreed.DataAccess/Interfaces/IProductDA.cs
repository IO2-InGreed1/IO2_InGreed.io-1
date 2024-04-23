using InGreed.Domain.Models;

namespace InGreed.DataAccess.Interfaces;

public interface IProductDA
{
    Product GetProductById(int productId);

    // TODO: Check if there can only be ingredient id
    IEnumerable<Product> GetProductsByIngredient(Ingredient ingredient);

    void CreateProduct(Product product);
    void DeleteProduct(int productId);

    // TODO: change to more functions, like change promotion, add to list etc..
    void ModifyProduct(int productIdToModify, Product product);
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
