import 'package:expense/login_singup/database_helper_feedback.dart';
import 'package:expense/navbar/feedback_model.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: feedbackController,
              decoration: InputDecoration(
                labelText: 'Write your feedback...',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _submitFeedback();
              },
              child: Text('Submit Feedback'),
            ),
            SizedBox(height: 20),
            Text(
              'Feedback from other users:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: FutureBuilder<List<FeedbackModel>>(
                future: _fetchFeedbacks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final feedbacks = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: feedbacks.length,
                      itemBuilder: (context, index) {
                        final feedback = feedbacks[index];
                        return ListTile(
                          title: Text(feedback.feedbackText),
                          subtitle: Text('By: ${feedback.userName}'),
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<FeedbackModel>> _fetchFeedbacks() async {
    return await DatabaseHelperFeedback.instance.getAllFeedbacks();
  }

  void _submitFeedback() async {
    final userName = 'User123'; // Replace with actual user authentication logic
    final feedbackText = feedbackController.text.trim();

    if (feedbackText.isNotEmpty) {
      final feedback = FeedbackModel(
        id: 0,
        userName: userName,
        feedbackText: feedbackText,
      );

      await DatabaseHelperFeedback.instance.insertFeedback(feedback);
      feedbackController.clear();

      // Update the feedback list by calling setState
      setState(() {});
    }
  }
}
