import 'comment.dart';
import 'user.dart';

class KabEntry{
  final String title;
  final String text;
  final KabUser byUser;
   Map<String, List<KabComment>> comments;

  KabEntry({required this.title,required this.text,required this.byUser, this.comments = const {}});

  List<KabComment> get proComments => comments["pro"]??[];
  List<KabComment> get conComments => comments["con"]??[];

  get hasComments => proComments.length > 0 || conComments.length > 0;

  hasCommentsBy(KabUser user) => proComments.any((e) => e.byUser == user) || conComments.any((e) => e.byUser == user);
}