import 'package:naraakom/core/utils/Models/User.dart';

class ReviewModel {
  User user;
  String reviewText;
  double ratingRate;
  DateTime reviewDateTime;
  ReviewModel(this.user, this.reviewText, this.ratingRate, this.reviewDateTime);
}
