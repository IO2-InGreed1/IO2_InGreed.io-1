using InGreed.Domain.Models;

namespace InGreed.Domain.Queries;

public class OpinionParameters : PaginationParameters
{
    public int ReportCountGreaterThan { get; set; } = -1;
}
