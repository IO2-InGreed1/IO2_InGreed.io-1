using InGreed.DataAccess.FakeDA;
using InGreed.DataAccess.Interfaces;
using Microsoft.Extensions.DependencyInjection;

namespace InGreed.DataAccess;

public static class DependencyInjection
{
    public static IServiceCollection AddDataAccess(this IServiceCollection services)
    {
        return services.AddScoped<IUserDA, FakeUserDA>()
                       .AddScoped<IIngredientDA, FakeIngredientDA>()
                       .AddScoped<IProductDA, FakeProductDA>();
    }
}
