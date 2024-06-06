using InGreed.Logic.Enums;
using InGreed.Logic.Interfaces;
using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;

namespace InGreed.Logic.Services;

public class FavouritesService : IFavouritesService
{
    private IUserDA _userDA;
    private IProductDA _productDA;

    public FavouritesService(IUserDA userDA, IProductDA productDA)
    {
        _userDA = userDA;
        _productDA = productDA;
    }

    public FavouritesServiceAddResponse Add(int productId, int userId)
    {
        if (_productDA.GetProductById(productId) is null) return FavouritesServiceAddResponse.InvalidProductId;
        User? user = _userDA.GetUserById(userId);
        if (user is null) return FavouritesServiceAddResponse.InvalidUserId;
        if (user.Favourites.Any(f => f.Id == productId)) return FavouritesServiceAddResponse.AlreadyInFavourites;
        if (_userDA.AddToFavourites(productId, userId)) return FavouritesServiceAddResponse.Success;
        return FavouritesServiceAddResponse.Unknown;
    }

    public FavouritesServiceDeleteResponse Delete(int productId, int userId)
    {
        if (_productDA.GetProductById(productId) is null) return FavouritesServiceDeleteResponse.InvalidProductId;
        User? user = _userDA.GetUserById(userId);
        if (user is null) return FavouritesServiceDeleteResponse.InvalidUserId;
        if (!user.Favourites.Any(f => f.Id == productId)) return FavouritesServiceDeleteResponse.NotFavourited;
        if (_userDA.RemoveFavourites(productId, userId)) return FavouritesServiceDeleteResponse.Success;
        return FavouritesServiceDeleteResponse.Unknown;
    }
}
