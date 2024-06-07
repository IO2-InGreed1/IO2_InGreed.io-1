using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;
using InGreed.Domain.Queries;
using InGreed.Logic.Enums.Opinion;
using InGreed.Logic.Interfaces;
using InGreed.Logic.Mappers;

namespace InGreed.Logic.Services
{
    public class OpinionService : IOpinionService
    {
        private IOpinionDA _opinionDA;
        private IOpinionDBtoServiceResponseMapper _dbtoServiceResponseMapper;

        public OpinionService(IOpinionDA opinionDA, IOpinionDBtoServiceResponseMapper mapper)
        {
            _opinionDA = opinionDA;
            _dbtoServiceResponseMapper = mapper;
        }

        public Opinion? GetById(int opinionId)
        {
            return _opinionDA.GetById(opinionId);
        }

        public (OpinionServiceAddResponse, int) AddToProduct(Opinion opinion, int productId)
        {
            opinion.Id = _opinionDA.Create(opinion);
            var response = _opinionDA.AddToProduct(opinion.Id, productId);
            return (_dbtoServiceResponseMapper.AddResponseMapper(response), opinion.Id);
        }

        public OpinionServiceRemoveResponse RemoveFromProduct(int opinionId, int productId)
        {
            var response = _opinionDA.RemoveFromProduct(opinionId, productId);
            return _dbtoServiceResponseMapper.RemoveResponseMapper(response);
        }

        public List<Opinion> GetAllReported(PaginationParameters paginationParameters)
        {
            IEnumerable<Opinion> allOpinions = _opinionDA.GetAll(paginationParameters);
            List<Opinion> allReportedOpinions = new List<Opinion>();
            foreach (Opinion opinion in allOpinions)
            {
                if(opinion.reportCount > 0)
                {
                    allReportedOpinions.Add(opinion);
                }
            }
            return allReportedOpinions;
        }

        public OpinionServiceAddReportResponse AddReport(int opinionId)
        {
            var response = _opinionDA.AddReport(opinionId);
            return _dbtoServiceResponseMapper.AddReportResponseMapper(response);
        }

        public OpinionServiceRemoveReportsResponse RemoveReports(int opinionId)
        {
            var response = _opinionDA.RemoveReports(opinionId);
            return _dbtoServiceResponseMapper.RemoveReportsResponseMapper(response);
        }
    }
}
