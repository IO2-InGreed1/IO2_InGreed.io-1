namespace InGreed.Domain.Models
{
    public class Preference : Base
    {
        public string Name { get; set; } = string.Empty;
        private List<Ingredient> _forbidden = new();
        public List<Ingredient> Forbidden 
        {
            get
            {
                throw new NotImplementedException();
            }
            set
            {
                throw new NotFiniteNumberException();
            }
        }
        private List<Ingredient> _preferred = new();
        public List<Ingredient> Preferred
        {
            get
            {
                throw new NotImplementedException();
            }
            set
            {
                throw new NotImplementedException();
            }
        }
        public bool Active { get; set; } = new();

        public void ChangeActivity()
        {
            throw new NotImplementedException();
        }
    }
}
