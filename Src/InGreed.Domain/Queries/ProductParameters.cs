using InGreed.Domain.Enums;

namespace InGreed.Domain.Queries;

public class ProductParameters : PaginationParameters
{
    public Category? Category { get; set; } = null;
}
