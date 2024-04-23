using InGreed.Domain.Models;

namespace InGreed.DataAccess.Interfaces;

public interface IProductDA
{
    Product GetProductById(int productId);
    // returns created product id
    int CreateProduct(Product product);
    // later void DeleteProduct(int productId);
    void ModifyProduct(int productIdToModify, Product product);
    IEnumerable<Product> GetAll();
}
