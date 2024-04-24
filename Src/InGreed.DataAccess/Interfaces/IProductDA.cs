using InGreed.Domain.Models;

namespace InGreed.DataAccess.Interfaces;

public interface IProductDA
{
    Product? GetProductById(int productId);
    int? CreateProduct(Product product);
    void ModifyProduct(int productIdToModify, Product product);
    IEnumerable<Product> GetAllProducts();
}
