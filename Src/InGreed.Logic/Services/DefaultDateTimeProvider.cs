using InGreed.Logic.Interfaces;

namespace InGreed.Logic.Services;

public class DefaultDateTimeProvider : IDateTimeProvider
{
    public DateTime Now => DateTime.Now;
}
