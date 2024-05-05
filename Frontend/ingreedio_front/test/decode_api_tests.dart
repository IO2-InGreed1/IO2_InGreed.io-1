import 'package:ingreedio_front/database/real_database.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:test/test.dart';

void main() {
  test('Decode Ingredient list', () {
    //Arrange
    String response="{\"ingredients\": [{\"id\": 1,\"name\": \"Ender Pearl\",\"iconURL\": \"\"},{\"id\": 2,\"name\": \"Nether Wart\",\"iconURL\": \"\"},{\"id\": 3,\"name\": \"Bone Meal\",\"iconURL\": \"\"}]}";
    //Act
    var parsedData=RealIngredientDatabase.parseIngredientList(response);
    //Assert
    expect(parsedData, equals([
      Ingredient.fromAllData(iconURL: "", id: 1, name: "Ender Pearl"),
      Ingredient.fromAllData(iconURL: "", id: 2, name: "Nether Wart"),
      Ingredient.fromAllData(iconURL: "", id: 3, name: "Bone Meal"),
    ]));
  });
}