using InGreed.Domain.Models;

namespace InGreed.Logic.Interfaces
{
    public interface IOpinionService
    {
        IEnumerable<Opinion> GetAll();
        IEnumerable<Opinion>? GetByProduct(int productId);
        Opinion? GetById(int opinionId);
        void AddToProduct(int opinionId, int productId);
        void RemoveFromProduct(int opinionId, int productId);
    }
}
