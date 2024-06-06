using InGreed.Logic.Enums;

namespace InGreed.Logic.Interfaces;

public interface IFavouritesService
{
    FavouritesServiceAddResponse Add(int productId, int userId);
    FavouritesServiceDeleteResponse Delete(int productId, int userId);
}
