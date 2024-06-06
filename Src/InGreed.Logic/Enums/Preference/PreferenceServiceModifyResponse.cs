namespace InGreed.Logic.Enums.Preference;

[Flags]
public enum PreferenceServiceModifyResponse
{
    Success = 0,
    InvalidOwnerId = 1,
    ContradictoryPreference = 2,
    NonexistentPreference = 4
}
