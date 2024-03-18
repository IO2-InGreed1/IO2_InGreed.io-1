import 'package:ingreedio_front/products.dart';
import 'package:ingreedio_front/users.dart';

abstract class Database
{

}
class MockupDatabase extends Database
{
  MockupDatabase():opinions=[],users=[],producers=[],products=[];
  List<User> users;
  List<Product> products;
  List<Producer> producers;
  List<Opinion> opinions;
}