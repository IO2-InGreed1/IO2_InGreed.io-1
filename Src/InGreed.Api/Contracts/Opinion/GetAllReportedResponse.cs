namespace InGreed.Api.Contracts.Opinion;

public record GetAllReportedResponse(List<(Domain.Models.Opinion, string, string)> opinions);
