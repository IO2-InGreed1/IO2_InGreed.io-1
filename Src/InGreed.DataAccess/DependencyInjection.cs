using Microsoft.Extensions.DependencyInjection;

namespace InGreed.DataAccess;

public static class DependencyInjection
{
    public static IServiceCollection AddDataAccess(this IServiceCollection services)
    {
        return services;
    }
}
