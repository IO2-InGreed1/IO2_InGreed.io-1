using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;

namespace InGreed.Logic.Services
{
    public class OpinionService : IOpinionService
    {
        IOpinionDA _opinionDA;
        IProductService _productService;

        public OpinionService(IOpinionDA opinionDA, IProductService productService)
        {
            _opinionDA = opinionDA;
            _productService = productService;
        }

        public void AddToProduct(int opinionId, int productId)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Opinion> GetAll()
        {
            throw new NotImplementedException();
        }

        public Opinion? GetById(int opinionId)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Opinion>? GetByProduct(int productId)
        {
            throw new NotImplementedException();
        }

        public void RemoveFromProduct(int opinionId, int productId)
        {
            throw new NotImplementedException();
        }
    }
}
