namespace InGreed.Domain.Helpers;

public class PaginatedList<T> : List<T>
{
    public int PageSize { get; } = 0;
    public int PageIndex { get; } = 0;
    public int TotalPages { get; } = 0;
    public bool HasPreviousPage => PageIndex > 1;
    public bool HasNextPage => PageIndex < TotalPages;

    public PaginatedList(IEnumerable<T> items, int pageIndex, int totalPages, int pageSize)
    {
        PageSize = pageSize;
        PageIndex = pageIndex;
        TotalPages = totalPages;
        AddRange(items);
    }
}