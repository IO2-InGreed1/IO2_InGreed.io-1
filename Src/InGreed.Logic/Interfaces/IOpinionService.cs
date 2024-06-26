﻿using InGreed.Domain.Helpers;
using InGreed.Domain.Models;
using InGreed.Domain.Queries;
using InGreed.Logic.Enums.Opinion;

namespace InGreed.Logic.Interfaces
{
    public interface IOpinionService
    { 
        Opinion? GetById(int opinionId);
        (OpinionServiceAddResponse, int) AddToProduct(Opinion opinion, int productId);
        OpinionServiceRemoveResponse RemoveFromProduct(int opinionId, int productId);
        OpinionServiceAddReportResponse AddReport(int opinionId);
        OpinionServiceRemoveReportsResponse RemoveReports(int opinionId);
        PaginatedList<OpinionWithAuthor> GetAllReported(OpinionParameters parameters);
        PaginatedList<OpinionWithAuthor> GetByProduct(OpinionParameters parameters, int productId);
    }
}
