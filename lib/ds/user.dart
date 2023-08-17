import 'rating.dart';

class KabUser{
  final String handle;
  final String name;
  final bool isDev;
  Map<String, KabRating> rating = {};

  KabUser({required this.handle, required this.name, this.isDev = false});
}
