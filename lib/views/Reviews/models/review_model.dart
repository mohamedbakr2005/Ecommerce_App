class ReviewModel {
  final String id;
  final String reviewerName;
  final double rating;
  final String comment;
  final String timeAgo;
  final String? reviewerImage;

  ReviewModel({
    required this.id,
    required this.reviewerName,
    required this.rating,
    required this.comment,
    required this.timeAgo,
    this.reviewerImage,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      reviewerName: json['reviewerName'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      comment: json['comment'] ?? '',
      timeAgo: json['timeAgo'] ?? '',
      reviewerImage: json['reviewerImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reviewerName': reviewerName,
      'rating': rating,
      'comment': comment,
      'timeAgo': timeAgo,
      'reviewerImage': reviewerImage,
    };
  }
}

class RatingBreakdown {
  final int fiveStar;
  final int fourStar;
  final int threeStar;
  final int twoStar;
  final int oneStar;

  RatingBreakdown({
    required this.fiveStar,
    required this.fourStar,
    required this.threeStar,
    required this.twoStar,
    required this.oneStar,
  });

  int get totalRatings => fiveStar + fourStar + threeStar + twoStar + oneStar;

  double get averageRating {
    if (totalRatings == 0) return 0;
    return (fiveStar * 5 +
            fourStar * 4 +
            threeStar * 3 +
            twoStar * 2 +
            oneStar * 1) /
        totalRatings;
  }

  double getPercentage(int starCount) {
    if (totalRatings == 0) return 0;
    switch (starCount) {
      case 5:
        return fiveStar / totalRatings;
      case 4:
        return fourStar / totalRatings;
      case 3:
        return threeStar / totalRatings;
      case 2:
        return twoStar / totalRatings;
      case 1:
        return oneStar / totalRatings;
      default:
        return 0;
    }
  }
}
