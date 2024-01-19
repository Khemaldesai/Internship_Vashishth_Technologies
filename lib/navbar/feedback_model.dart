// feedback_model.dart
class FeedbackModel {
  final int id;
  final String userName;
  final String feedbackText;

  FeedbackModel({
    required this.id,
    required this.userName,
    required this.feedbackText,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'feedbackText': feedbackText,
    };
  }

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      id: map['id'],
      userName: map['userName'],
      feedbackText: map['feedbackText'],
    );
  }
}
