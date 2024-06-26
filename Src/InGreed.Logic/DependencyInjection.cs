﻿using InGreed.Logic.Interfaces;
using InGreed.Logic.Mappers;
using InGreed.Logic.Services;
using Microsoft.Extensions.DependencyInjection;

namespace InGreed.Logic;

public static class DependencyInjection
{
    public static IServiceCollection AddLogic(this IServiceCollection services)
    {
        return services
            .AddScoped<IAccountService, AccountService>()
            .AddScoped<ITokenService, JwtTokenService>()
            .AddScoped<IDateTimeProvider, DefaultDateTimeProvider>()
            .AddScoped<IIngredientService, IngredientService>()
            .AddScoped<IProductService, ProductService>()
            .AddScoped<IPreferenceService, PreferenceService>()
            .AddScoped<IIngredientDBtoServiceResponseMapper, IngredientDBtoServiceResponseMapper>()
            .AddScoped<IFavouritesService, FavouritesService>()
            .AddScoped<IPreferenceCreateToModifyResponseMapper, PreferenceCreateToModifyResponseMapper>()
            .AddScoped<IOpinionService, OpinionService>()
            .AddScoped<IOpinionDBtoServiceResponseMapper, OpinionDBtoServiceResponseMapper>();
    }
}
