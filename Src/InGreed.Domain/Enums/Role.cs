namespace InGreed.Domain.Enums;

[Flags]
public enum Role
{
    User = 1,
    Producent = 2,
    Moderator = 4,
    Administrator = 8
}
