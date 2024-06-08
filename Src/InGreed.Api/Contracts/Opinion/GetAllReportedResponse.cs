using InGreed.Domain.Helpers;

namespace InGreed.Api.Contracts.Opinion;

public record GetAllReportedResponse(List<OpinionWithAuthor> opinions);
