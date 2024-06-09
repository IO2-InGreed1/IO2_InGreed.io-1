using InGreed.DataAccess.Enums.Opinion;
using InGreed.Logic.Enums.Opinion;

namespace InGreed.Logic.Mappers;

public interface IOpinionDBtoServiceResponseMapper
{
    OpinionServiceAddResponse AddResponseMapper(OpinionDAAddResponse DAresponse);
    OpinionServiceRemoveResponse RemoveResponseMapper(OpinionDARemoveResponse DAresponse);
    OpinionServiceAddReportResponse AddReportResponseMapper(OpinionDAAddReportResponse DAresponse);
    OpinionServiceRemoveReportsResponse RemoveReportsResponseMapper(OpinionDARemoveReportsResponse DAresponse);
}
