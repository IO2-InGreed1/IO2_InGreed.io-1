using InGreed.DataAccess.Enums.Opinion;
using InGreed.Logic.Enums.Opinion;
using Riok.Mapperly.Abstractions;

namespace InGreed.Logic.Mappers;

[Mapper(EnumMappingStrategy = EnumMappingStrategy.ByName, EnumMappingIgnoreCase = true)]
public partial class OpinionDBtoServiceResponseMapper : IOpinionDBtoServiceResponseMapper
{
    public partial OpinionServiceAddResponse AddResponseMapper(OpinionDAAddResponse DAresponse);
    public partial OpinionServiceRemoveResponse RemoveResponseMapper(OpinionDARemoveResponse DAresponse);
    public partial OpinionServiceAddReportResponse AddReportResponseMapper(OpinionDAAddReportResponse DAresponse);
    public partial OpinionServiceRemoveReportsResponse RemoveReportsResponseMapper(OpinionDARemoveReportsResponse DAresponse);
}
