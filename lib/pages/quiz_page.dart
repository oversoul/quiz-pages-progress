import 'package:flutter/material.dart';
import 'package:quiz/pages/pages.dart';
import 'package:quiz/pages/percent_progress.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  double progressValue = 0;
  double currentProgress = 0;
  final PageController _controller = PageController(initialPage: 0);

  @override
  void initState() {
    progressValue = 1.0 / 4;
    currentProgress = 0;
    super.initState();
  }

  void nextPage() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
  }

  void addProgress() {
    setState(() {
      currentProgress += progressValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Page1(onSuccess: () {
            nextPage();
            addProgress();
          }),
          PercentProgress(
            initialValue: 0.0,
            endValue: 25.0,
            onSubmit: () {
              nextPage();
            },
          ),
          SamplePage(index: 2, onSuccess: () {
            nextPage();
            addProgress();
          }),
          PercentProgress(
            initialValue: 25.0,
            endValue: 50.0,
            onSubmit: () {
              nextPage();
            },
          ),
          SamplePage(index: 3, onSuccess: () {
            nextPage();
            addProgress();
          }),
          PercentProgress(
            initialValue: 50.0,
            endValue: 75.0,
            onSubmit: () {
              nextPage();
            },
          ),
          SamplePage(index: 4, onSuccess: () {
            nextPage();
            addProgress();
          }),
          PercentProgress(
            initialValue: 75.0,
            endValue: 100.0,
            onSubmit: () {
              _controller.animateToPage(
                0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeIn,
              );
            },
          ),
        ],
      ),
    );
  }
}
