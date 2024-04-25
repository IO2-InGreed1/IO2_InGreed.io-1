using InGreed.Domain.Models;

namespace InGreed.DataAccess.Interfaces
{
    public interface IOpinionDA
    {
        IEnumerable<Opinion> GetAll();
        IEnumerable<Opinion>? GetByProduct(int productId);
        Opinion? GetById(int ingredientId);
        int Create(Opinion opinion);
        void AddToProduct(int opinionId, int productId);
        void RemoveFromProduct(int opinionId, int productId);
    }
}
