namespace InGreed.Test;

[TestClass]
public class ProductServiceTests
{
    [TestMethod]
    public void GetAllProducts_ShouldReturnListOfAllProducts()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void GetProductByID_ExistingProduct_ShouldReturnTheRightProduct()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void GetProductByID_NonexistentProduct_ShouldThrowArgumentException()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void PromoteProduct_ExistingNotPromotedProduct_ShouldChangeProductStateToPromoted()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void PromoteProduct_ExistingPromotedProduct_ShouldKeepProductPromotedState()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void PromoteProduct_NonexistentProduct_ShouldThrowArgumentException()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void AddOpinion_ExistingProductExistingOpinion_ShouldAddOpinionToProductOpinions()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void AddOpinion_NonexistentProductExistingOpinion_ShouldThrowArgumentException()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void AddOpinion_ExistingProductNonexistantOpinion_ShouldThrowArgumentException()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void AddOpinion_NonexistentProductNonexistantOpinion_ShouldThrowArgumentException()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void DeleteOpinion_ExistingProductExistingOpinion_ShouldDeleteOpinionFromProductopinions()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void DeleteOpinion_ExistingProductNonexistentOpinion_ShouldThrowArgumentException()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void DeleteOpinion_NonexistentProductExistingOpinion_ShouldThrowArgumentException()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void DeleteOpinion_NonexistentProductNonexistentOpinion_ShouldThrowArgumentException()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void AddIngredient_ExistingProductExistingIngredient_ShouldAddIngredientToProductIngredients()
    {
        // Arrange
        // Act
        // Assert
    }

    [TestMethod]
    public void AddIngredient_ExistingProductNonexistantIngredient_ShouldThrowArgumentException()
    {
        // Arrange
        // Act
        // Assert
}

    [TestMethod]
        public void AddIngredient_NonexistantProductExistingIngredient_ShouldThrowArgumentException()
        {
            // Arrange
            // Act
            // Assert
    }
    
    [TestMethod]
        public void AddIngredient_NonexistantProductNonexistantIngredient_ShouldThrowArgumentException()
        {
        // Arrange
        // Act
        // Assert
    }
    
    [TestMethod]
        public void RemoveIngredient_ExistingProductExistingIngredient_ShouldRemoveIngredientFromProductIngredients()
        {
        // Arrange
        // Act
        // Assert
    }
    
    [TestMethod]
        public void RemoveIngredient_ExistingProductNonexistantIngredient_ShouldThrowArgumentException()
        {
        // Arrange
        // Act
        // Assert
    }
    
    [TestMethod]
        public void RemoveIngredient_NonexistantProductExistingIngredient_ShouldThrowArgumentException()
        {
        // Arrange
        // Act
        // Assert
    }
    
    [TestMethod]
        public void RemoveIngredient_NonexistantProductNonexistantIngredient_ShouldThrowArgumentException()
        {
        // Arrange
        // Act
        // Assert
    }
}