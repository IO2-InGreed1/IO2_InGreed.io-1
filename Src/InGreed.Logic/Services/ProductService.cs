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
}