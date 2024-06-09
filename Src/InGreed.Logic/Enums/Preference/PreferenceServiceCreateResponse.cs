namespace InGreed.Logic.Enums.Preference;

[Flags]
public enum PreferenceServiceCreateResponse
{
    Success = 0,
    InvalidOwnerId = 1,
    ContradictoryPreference = 2
}
