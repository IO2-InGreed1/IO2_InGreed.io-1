using InGreed.DataAccess.Enums.Opinion;
using InGreed.Domain.Models;

namespace InGreed.DataAccess.Interfaces
{
    public interface IOpinionDA
    {
        IEnumerable<Opinion> GetAll();
        Opinion? GetById(int ingredientId);
        int Create(Opinion opinion);
        OpinionDAAddResponse AddToProduct(int opinionId, int productId);
        OpinionDARemoveResponse RemoveFromProduct(int opinionId, int productId);
        OpinionDAAddReportResponse AddReport(int opinionId);
    }
}
