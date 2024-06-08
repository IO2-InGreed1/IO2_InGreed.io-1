using InGreed.Domain.Models;

namespace InGreed.Domain.Helpers
{
    public class OpinionWithAuthor
    {
        public Opinion Opinion { get; set; }
        public string Owner { get; set; }
        public string IconURL { get; set; }
    }
}
