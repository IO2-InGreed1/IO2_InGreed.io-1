using InGreed.Domain.Enums;

namespace InGreed.Domain.Queries;

public class ProductParameters : PaginationParameters
{
    public Category? Category { get; set; } = null;
    public List<int> usedIngredientsId { get; set; } = new List<int>();
    public List<int> bannedIngredientsId { get; set;} = new List<int>();
}
