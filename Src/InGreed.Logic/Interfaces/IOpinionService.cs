using InGreed.Domain.Models;
using InGreed.Logic.Enums.Opinion;

namespace InGreed.Logic.Interfaces
{
    public interface IOpinionService
    { 
        Opinion? GetById(int opinionId);
        OpinionServiceAddResponse AddToProduct(Opinion opinion, int productId);
        OpinionServiceRemoveResponse RemoveFromProduct(int opinionId, int productId);
        OpinionServiceAddReportResponse AddReport(int opinionId);
        OpinionServiceRemoveReportsResponse RemoveReports(int opinionId);
        List<Opinion> GetAllReported();
    }
}
