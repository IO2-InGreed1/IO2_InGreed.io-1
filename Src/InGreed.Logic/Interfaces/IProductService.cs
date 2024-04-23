using InGreed.Domain.Models;

namespace InGreed.Logic.Interfaces;

public interface IProductService
{
    IEnumerable<Product> GetAllProducts();
    Product GetProductById(int productId);

    // returns created product id
    int CreateProduct(Product product);
    // later void DeleteProduct(int productId);

    // later void UpdateProduct(int productId);
    //OpinionService
    //IngredientService
    //PromotionService
}
