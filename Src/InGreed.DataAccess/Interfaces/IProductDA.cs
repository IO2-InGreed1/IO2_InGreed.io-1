using InGreed.Domain.Models;
using InGreed.Domain.Queries;

namespace InGreed.DataAccess.Interfaces;

public interface IProductDA
{
    Product GetProductById(int productId);
    int CreateProduct(Product product);
    void ModifyProduct(int productIdToModify, Product product);
    IEnumerable<Product> GetAll(PaginationParameters paginationParameters);
}