import 'entry.dart';
import 'rating.dart';
import 'user.dart';

class KabComment{
  String title;
  String comment;
  final KabUser byUser;
  Map<String,List<KabRating>> rating;

  KabComment({required this.title, required this.comment,required this.byUser, this.rating = const {}});
}