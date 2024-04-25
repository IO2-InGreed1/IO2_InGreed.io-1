using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Enums;
using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;
using InGreed.Logic.Services;
using Moq;

namespace InGreed.Logic.Tests
{
    public class OpinionServiceTests
    {
        OpinionService mockOpinionService { get; set; } = null!;
        IOpinionDA opinionMockDA { get; set; } = null!;
        Mock<IOpinionDA> mockOpinionDA;
        Mock<IProductService> mockProductService;

        public OpinionServiceTests()
        {
            mockOpinionDA = new Mock<IOpinionDA>();
            mockProductService = new Mock<IProductService>(); 
        }
    }
}
