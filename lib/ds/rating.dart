
import 'user.dart';

class KabRating{
  String ofFlavor;
  double baseRating;
  Map<String, List<KabRating>> modifiers;

  KabRating({this.ofFlavor = '', this.baseRating = 0, this.modifiers = const {}});

  double modRatingsSum([String flavor = ''])   => (modifiers[flavor]?.fold<double>(0.0, (s,v) => s + v.value(flavor))) ?? 0.0;
  double value([String flavor = '']) => baseRating + modRatingsSum(flavor);
}

class KarmaVoteRating extends KabRating{
  final KabUser byUser;
  final double? weight;
  @override double get baseRating => 5; //here we need the EigenKarma API to get the user Karma
  @override set baseRating(double value) {} //here we need the EigenKarma API to get the user Karma
  KarmaVoteRating({super.ofFlavor = '', super.baseRating = 0, super.modifiers = const {}, required this.byUser, this.weight});
}

class AdminVoteRating extends KabRating{
  final KabUser byAdminUser;
  final double? weight;
  final KabRating rating;
  AdminVoteRating({super.ofFlavor = '', super.baseRating = 0, super.modifiers = const {}, required this.byAdminUser, this.weight, required this.rating});
}
