using InGreed.Domain.Models;

namespace InGreed.Logic.Interfaces;

public interface IProductService
{
    IEnumerable<Product> GetAllProducts();
    Product GetProductById(int productId);
    int CreateProduct(Product product);
}
