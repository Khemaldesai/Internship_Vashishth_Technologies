import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          FaqItem(
            question: 'How do I add a new expense?',
            answer:
                'To add a new expense, go to the "Add Expense" section and fill in the details such as expense type, amount, and date. Then, click the submit button.',
          ),
          FaqItem(
            question: 'Can I categorize my expenses?',
            answer:
                'Yes, you can categorize your expenses. When adding a new expense, select the appropriate category or create a new one.',
          ),
          FaqItem(
            question: 'How can I view my monthly expenses?',
            answer:
                'Navigate to the "Monthly Summary" section to view a breakdown of your expenses for the selected month. You can see totals for each category and overall spending.',
          ),
          FaqItem(
            question: 'Is my data secure?',
            answer:
                'Yes, we take the security of your data seriously. All your expense data is stored securely, and we do not share it with third parties.',
          ),
          FaqItem(
            question: 'Can I export my expense data?',
            answer:
                'Certainly! You can export your expense data in various formats such as CSV or PDF. This feature is available in the "Settings" section.',
          ),
        ],
      ),
    );
  }
}

class FaqItem extends StatefulWidget {
  final String question;
  final String answer;

  const FaqItem({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  _FaqItemState createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(
          widget.question,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.answer,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
        onExpansionChanged: (value) {
          setState(() {
            isExpanded = value;
          });
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FaqPage(),
  ));
}
