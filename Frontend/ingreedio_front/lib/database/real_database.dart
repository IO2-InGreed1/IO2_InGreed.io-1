import 'package:ingreedio_front/database/databse.dart';
import 'package:ingreedio_front/logic/filters.dart';
import 'package:ingreedio_front/logic/products.dart';
import 'package:ingreedio_front/logic/users.dart';

class RealUserDatabase extends UserDatabse
{
  @override
  bool addClient(Client client) {
    // TODO: implement addClient
    throw UnimplementedError();
  }

  @override
  bool addPreference(Preference preference) {
    // TODO: implement addPreference
    throw UnimplementedError();
  }

  @override
  bool editPreference(Preference oldPreference, Preference editedPreference) {
    // TODO: implement editPreference
    throw UnimplementedError();
  }

  @override
  List<Client> getAllClients() {
    // TODO: implement getAllClients
    throw UnimplementedError();
  }

  @override
  List<Preference> getUserPreferences(Client client) {
    // TODO: implement getUserPreferences
    throw UnimplementedError();
  }

  @override
  bool removeClient(Client client) {
    // TODO: implement removeClient
    throw UnimplementedError();
  }

  @override
  bool removePreference(Preference preference) {
    // TODO: implement removePreference
    throw UnimplementedError();
  }

  @override
  bool setFavoutiteProduct(Client client, Product product, bool state) {
    // TODO: implement setFavoutiteProduct
    throw UnimplementedError();
  }

}
class RealIngredientDatabase extends IngredientDatabase
{
  @override
  List<Ingredient> getAllIngredients() {
    // TODO: implement getAllIngredients
    throw UnimplementedError();
  }

}
class RealProductDatabase extends ProductDatabse
{
  @override
  bool addProducer(Producer producer) {
    // TODO: implement addProducer
    throw UnimplementedError();
  }

  @override
  bool addProduct(Product product) {
    // TODO: implement addProduct
    throw UnimplementedError();
  }

  @override
  bool editProduct(Product product, Product editedProduct) {
    // TODO: implement editProduct
    throw UnimplementedError();
  }

  @override
  List<Product> filterProducts(int from, int to, ProductFilter filter) {
    // TODO: implement filterProducts
    throw UnimplementedError();
  }

  @override
  List<Producer> getAllProducers() {
    // TODO: implement getAllProducers
    throw UnimplementedError();
  }

  @override
  List<Product> getAllProducts() {
    // TODO: implement getAllProducts
    throw UnimplementedError();
  }

  @override
  bool removeProducer(Producer producer) {
    // TODO: implement removeProducer
    throw UnimplementedError();
  }

  @override
  bool removeProduct(Product product) {
    // TODO: implement removeProduct
    throw UnimplementedError();
  }

}
class RealOpinionDatabase extends OpinionDatabase
{
  @override
  bool addOpinion(Opinion opinion) {
    // TODO: implement addOpinion
    throw UnimplementedError();
  }

  @override
  List<Opinion> getAllOpinions() {
    // TODO: implement getAllOpinions
    throw UnimplementedError();
  }

  @override
  List<Opinion> getClientOpinions(Client client) {
    // TODO: implement getClientOpinions
    throw UnimplementedError();
  }

  @override
  List<Opinion> getOpinionsFiltered(int from, int to, Product product, OpinionFilter filter) {
    // TODO: implement getOpinionsFiltered
    throw UnimplementedError();
  }

  @override
  List<Opinion> getProductOpinions(Product product) {
    // TODO: implement getProductOpinions
    throw UnimplementedError();
  }

  @override
  List<Opinion> getReportedOpinions() {
    // TODO: implement getReportedOpinions
    throw UnimplementedError();
  }

  @override
  List<Opinion> getReportedProductOpinions(Product product) {
    // TODO: implement getReportedProductOpinions
    throw UnimplementedError();
  }

  @override
  bool removeOpinion(Opinion opinion) {
    // TODO: implement removeOpinion
    throw UnimplementedError();
  }
  
}