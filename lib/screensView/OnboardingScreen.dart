import 'package:flutter/material.dart';
import '../Utility/Constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: GestureDetector(
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              OnboardingPage(
                  image: 'lib/images/onboarding1.png',
                  title: Constants.titleOne,
                  description: Constants.descriptionOne),
              OnboardingPage(
                  image: 'lib/images/onboarding2.png',
                  title: Constants.titleTwo,
                  description: Constants.descriptionTwo),
              OnboardingPage(
                  image: 'lib/images/onboarding3.png',
                  title: Constants.titleThree,
                  description: Constants.descriptionThree),
            ],
          ),
          Positioned(
            bottom: 80,
            left: 30,
            child: Row(children: _buildIndicators()),
          ),
          Positioned(
            bottom: 60,
            right: 30,
            child: FloatingActionButton(
              backgroundColor: Constants.primaryColor,
              onPressed: () {
                if (_currentPage < 2) {
                  _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                }
              },
              child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildIndicators() {
    return List.generate(3, (index) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 10,
        width: _currentPage == index ? 20 : 8,
        decoration: BoxDecoration(
          color: Constants.primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
      );
    });
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 300),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Constants.primaryColor,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
