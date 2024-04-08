namespace InGreed.Domain.Enums;

[Flags]
public enum NotificationType
{
    Other = 1,
    Info = 2,
    Warning = 4,
    Error = 8
}
