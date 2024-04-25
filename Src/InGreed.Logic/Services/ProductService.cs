using InGreed.DataAccess.Interfaces;
using InGreed.Logic.Interfaces;
using InGreed.Domain.Models;

namespace InGreed.Logic.Services;

public class ProductService : IProductService
{
    IProductDA _productDA;
    public ProductService(IProductDA productDA)
    {
        _productDA = productDA;
    }

    public int CreateProduct(Product product)
    {
        try { return _productDA.CreateProduct(product); }
        catch (Exception ex) { throw new ArgumentException(ex.Message); }
    }

    public void ModifyProduct(int productIdToModify, Product product)
    {
        _productDA.ModifyProduct(productIdToModify, product);
    }

    public IEnumerable<Product> GetAllProducts()
    {
        return _productDA.GetAll();
    }

    public Product GetProductById(int productId)
    {
        try { return _productDA.GetProductById(productId); }
        catch(Exception ex) { throw new ArgumentException(ex.Message); }
    }
}