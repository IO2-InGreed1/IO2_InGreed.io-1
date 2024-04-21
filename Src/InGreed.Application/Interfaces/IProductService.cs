using InGreed.Domain.Models;

namespace InGreed.Logic.Interfaces;

public interface IProductService
{
    IEnumerable<Product> GetAllProducts();
    Product GetProductById(int productId);
    void PromoteProduct(int productId);

    // TODO: Check if it should be there
    // TODO: Change product to id, as well as opinion?
    void AddOpinion(Product product, Opinion opinion);
    void DeleteOpinion(Product product, Opinion opinion);

    // TODO: Check if it should be there
    // TODO: Change product to id, as well as ingredient?
    void AddIngredient(Product product, Ingredient ingredient);
    void RemoveIngredient(Product product, Ingredient ingredient);
}
