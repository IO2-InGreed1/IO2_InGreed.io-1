using InGreed.DataAccess.Enums.Opinion;
using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Helpers;
using InGreed.Domain.Models;
using InGreed.Domain.Queries;

namespace InGreed.DataAccess.FakeDA;

public class FakeOpinionDA : IOpinionDA
{
    private static List<Opinion> _opinions = new()
    {
        new() { Id = 1, productId = 1, authorId = 1, Content = "Great product!", Score = 4.5f, reportCount = 0 },
        new() { Id = 2, productId = 2, authorId = 2, Content = "Not what I expected.", Score = 2.0f, reportCount = 1 },
        new() { Id = 3, productId = 1, authorId = 3, Content = "Amazing value for money.", Score = 5.0f, reportCount = 0 }
    };
    private static int currentId = 3;

    public int Create(Opinion opinion)
    {
        opinion.Id = ++currentId;
        _opinions.Add(opinion);
        return currentId;
    }

    public PaginatedList<OpinionWithAuthor> GetAll(OpinionParameters parameters)
    {
        var opinions = _opinions
            .Where(o => o.reportCount > parameters.ReportCountGreaterThan)
            .Skip((parameters.PageNumber - 1) * parameters.PageSize)
            .Take(parameters.PageSize);

        var count = _opinions.Where(o => o.reportCount > parameters.ReportCountGreaterThan).Count();
        var totalPages = (int)Math.Ceiling(count / (double)parameters.PageSize);

        List<OpinionWithAuthor> opinionsWithAuthor = new List<OpinionWithAuthor>(opinions.Count());
        User author;
        FakeUserDA uda = new();
        foreach (Opinion o in opinions) 
        {
            author = uda.GetUserById(o.authorId);
            opinionsWithAuthor.Add(new() { Opinion = o, Owner = author.Username, IconURL = author.IconURL });
        }

        return new PaginatedList<OpinionWithAuthor>(opinionsWithAuthor, parameters.PageNumber, totalPages, parameters.PageSize);
    }

    public Opinion? GetById(int opinionId)
    {
        return _opinions.Find(o => o.Id == opinionId);
    }

    public OpinionDAAddResponse AddToProduct(int opinionId, int productId)
    {
        if (new FakeProductDA().GetProductById(productId) is null) return OpinionDAAddResponse.NonexistentProduct;
        Opinion? opinion = GetById(opinionId);
        if (opinion is not null) opinion.productId = productId;
        return OpinionDAAddResponse.Success;
    }

    public OpinionDARemoveResponse RemoveFromProduct(int opinionId, int productId)
    {
        if (new FakeProductDA().GetProductById(productId) is null) return OpinionDARemoveResponse.NonexistentProduct;
        Opinion? opinion = GetById(opinionId);
        if (opinion is null || opinion.productId != productId) return OpinionDARemoveResponse.OpinionNotFromProduct;
        _opinions.Remove(opinion);
        return OpinionDARemoveResponse.Success;
    }

    public OpinionDAAddReportResponse AddReport(int opinionId)
    {
        Opinion? opinion;
        if ((opinion = GetById(opinionId)) is null) return OpinionDAAddReportResponse.NonexistentOpinion;
        opinion.reportCount++;
        return OpinionDAAddReportResponse.Success;
    }

    public OpinionDARemoveReportsResponse RemoveReports(int opinionId)
    {
        Opinion? opinion;
        if ((opinion = GetById(opinionId)) is null) return OpinionDARemoveReportsResponse.NonexistentOpinion;
        opinion.reportCount = 0;
        return OpinionDARemoveReportsResponse.Success;
    }

    public PaginatedList<OpinionWithAuthor> GetByProduct(OpinionParameters parameters, int productId)
    {
        var opinions = _opinions
            .Where(o => o.productId == productId)
            .Skip((parameters.PageNumber - 1) * parameters.PageSize)
            .Take(parameters.PageSize);

        var count = _opinions.Where(o => o.reportCount > parameters.ReportCountGreaterThan).Count();
        var totalPages = (int)Math.Ceiling(count / (double)parameters.PageSize);

        List<OpinionWithAuthor> opinionsWithAuthor = new List<OpinionWithAuthor>(opinions.Count());
        User author;
        FakeUserDA uda = new();
        foreach (Opinion o in opinions)
        {
            author = uda.GetUserById(o.authorId);
            opinionsWithAuthor.Add(new() { Opinion = o, Owner = author.Username, IconURL = author.IconURL });
        }

        return new PaginatedList<OpinionWithAuthor>(opinionsWithAuthor, parameters.PageNumber, totalPages, parameters.PageSize);
    }
}
