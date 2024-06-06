using InGreed.DataAccess.Enums.Opinion;
using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;

namespace InGreed.DataAccess.FakeDA;

public class FakeOpinionDA : IOpinionDA
{
    private static List<Opinion> _opinions = new()
    {
        new() { Id = 1, productId = 1, authorId = 1, Content = "Great product!", Score = 4.5f, reportCount = 0 },
        new() { Id = 2, productId = 2, authorId = 2, Content = "Not what I expected.", Score = 2.0f, reportCount = 1 },
        new() { Id = 3, productId = 1, authorId = 3, Content = "Amazing value for money.", Score = 5.0f, reportCount = 0 }
    };
    private int currentId = 3;

    public int Create(Opinion opinion)
    {
        if (GetById(opinion.Id) is not null) return 0;
        opinion.Id = ++currentId;
        _opinions.Add(opinion);
        return currentId;
    }

    public IEnumerable<Opinion> GetAll()
    {
        return _opinions;
    }

    public Opinion? GetById(int opinionId)
    {
        return _opinions.Find(o => o.Id == opinionId);
    }

    public OpinionDAAddResponse AddToProduct(int opinionId, int productId)
    {
        return OpinionDAAddResponse.Success;
    }

    public OpinionDARemoveResponse RemoveFromProduct(int opinionId, int productId)
    {
        return OpinionDARemoveResponse.Success;
    }

    public OpinionDAAddReportResponse AddReport(int opinionId)
    {
        Opinion? opinion;
        if ((opinion = GetById(opinionId)) is null) return OpinionDAAddReportResponse.NonexistentOpinion;
        opinion.reportCount++;
        return OpinionDAAddReportResponse.Success;
    }
}
