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
        new() { Id = 3, productId = 1, authorId = 3, Content = "Amazing value for money.", Score = 5.0f, reportCount = 0 },
        new() { Id = 4, productId = 1, authorId = 1, Content = "Great product!", Score = 4.5f, reportCount = 0 },
        new() { Id = 5, productId = 2, authorId = 2, Content = "Not what I expected.", Score = 2.0f, reportCount = 1 },
        new() { Id = 6, productId = 1, authorId = 3, Content = "Amazing value for money.", Score = 5.0f, reportCount = 0 },
        new() { Id = 7, productId = 4, authorId = 1, Content = "Great product!", Score = 4.5f, reportCount = 0 },
        new() { Id = 8, productId = 5, authorId = 2, Content = "Not what I expected.", Score = 2.0f, reportCount = 1 },
        new() { Id = 9, productId = 6, authorId = 3, Content = "Amazing value for money.", Score = 5.0f, reportCount = 0 },
        new() { Id = 10, productId = 6, authorId = 5, Content = "Red is sus.", Score = 4.5f, reportCount = 10 },
        new() { Id = 11, productId = 6, authorId = 2, Content = "Amongus, hu hu hu.", Score = 2.0f, reportCount = 1 },
        new() { Id = 12, productId = 6, authorId = 1, Content = "SUS OwO", Score = 4.0f, reportCount = 3 },
        new() { Id = 13, productId = 7, authorId = 2, Content = "It didn't work...", Score = 1.0f, reportCount = 1 },
        new() { Id = 14, productId = 8, authorId = 2, Content = "Useless, I'm colourblind.", Score = 2.0f, reportCount = 1 },
        new() { Id = 15, productId = 8, authorId = 1, Content = "It's smurfing time, babe.", Score = 5.0f, reportCount = 0 },
        new() { Id = 16, productId = 9, authorId = 4, Content = "Decent quality.", Score = 3.5f, reportCount = 0 },
        new() { Id = 17, productId = 10, authorId = 5, Content = "Exceeded my expectations!", Score = 5.0f, reportCount = 0 },
        new() { Id = 18, productId = 11, authorId = 6, Content = "Wouldn't recommend.", Score = 1.5f, reportCount = 2 },
        new() { Id = 19, productId = 1, authorId = 7, Content = "Good, but could be better.", Score = 3.0f, reportCount = 1 },
        new() { Id = 20, productId = 1, authorId = 1, Content = "Terrible product, avoid!", Score = 0.5f, reportCount = 3 },
        new() { Id = 21, productId = 1, authorId = 1, Content = "I'm very satisfied.", Score = 4.5f, reportCount = 0 },
        new() { Id = 22, productId = 1, authorId = 1, Content = "Just okay.", Score = 3.0f, reportCount = 0 },
        new() { Id = 23, productId = 1, authorId = 1, Content = "Highly recommended!", Score = 5.0f, reportCount = 0 },
        new() { Id = 24, productId = 1, authorId = 1, Content = "Not worth the money.", Score = 1.0f, reportCount = 2 },
        new() { Id = 25, productId = 1, authorId = 1, Content = "HOT CHICKS PICS HERE >>>>>> http://website.com", Score = 2.5f, reportCount = 0 },
        new() { Id = 26, productId = 1, authorId = 1, Content = "Loved it!", Score = 4.5f, reportCount = 0 },
        new() { Id = 27, productId = 2, authorId = 1, Content = "Could be improved.", Score = 3.0f, reportCount = 1 },
        new() { Id = 28, productId = 2, authorId = 1, Content = "Fantastic product!", Score = 5.0f, reportCount = 0 },
        new() { Id = 29, productId = 2, authorId = 1, Content = "Disappointing.", Score = 2.0f, reportCount = 1 },
        new() { Id = 30, productId = 2, authorId = 1, Content = "Solid purchase.", Score = 4.0f, reportCount = 0 },
    };
    private static int currentId = 30;

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
            .Where(o => (o.reportCount > parameters.ReportCountGreaterThan && o.productId == productId))
            .Skip((parameters.PageNumber - 1) * parameters.PageSize)
            .Take(parameters.PageSize);

        var count = _opinions.Where(o => (o.reportCount > parameters.ReportCountGreaterThan && o.productId == productId)).Count();
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
