import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'डिजिटल युगात, डिजिटल जाहिरात ...',
      'description': 'जाहिरात बनवा आता आपल्या मराठी मातृभाषेमध्ये',
      'image': 'assets/onboarding1.png',
      'background': '#FFDEE9'
    },
    {
      'title': 'Get Started',
      'description': 'Learn how to make the most of our app.',
      'image': 'assets/onboarding1.png',
      'background': '#B5FFFC'
    },
    {
      'title': 'Enjoy',
      'description': 'Experience the best features we offer.',
      'image': 'assets/onboarding1.png',
      'background': '#FFEEB3'
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: _onboardingData.length,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, index) {
          final item = _onboardingData[index];
          return OnboardingPage(
            title: item['title']!,
            description: item['description']!,
            imageAsset: item['image']!,
            backgroundColor: item['background']!,
            fadeAnimation: _fadeAnimation,
            scaleAnimation: _scaleAnimation,
          );
        },
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageAsset;
  final String backgroundColor;
  final Animation<double> fadeAnimation;
  final Animation<double> scaleAnimation;

  const OnboardingPage({
    Key? key,
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.backgroundColor,
    required this.fadeAnimation,
    required this.scaleAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(int.parse(backgroundColor.replaceFirst('#', '0xFF'))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: fadeAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: Image.asset(imageAsset, height: 300),
              ),
            ),
            const SizedBox(height: 30),
            FadeTransition(
              opacity: fadeAnimation,
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Required for ShaderMask
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            FadeTransition(
              opacity: fadeAnimation,
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

