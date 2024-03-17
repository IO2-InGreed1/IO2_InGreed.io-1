import 'users.dart';
abstract class IModerator
{

}
class Moderator extends IModerator
{

}
class Admin extends IModerator with IProducer
{

}
class ControlPanel
{

}