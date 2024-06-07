using InGreed.DataAccess.Enums.Opinion;
using InGreed.Domain.Helpers;
using InGreed.Domain.Models;
using InGreed.Domain.Queries;

namespace InGreed.DataAccess.Interfaces
{
    public interface IOpinionDA
    {
        PaginatedList<Opinion> GetAll(OpinionParameters parameters);
        Opinion? GetById(int ingredientId);
        int Create(Opinion opinion);
        OpinionDAAddResponse AddToProduct(int opinionId, int productId);
        OpinionDARemoveResponse RemoveFromProduct(int opinionId, int productId);
        OpinionDAAddReportResponse AddReport(int opinionId);
        OpinionDARemoveReportsResponse RemoveReports(int opinionId);
    }
}
