class OnboardingPage extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final String title;
  final String description;
  final String imageAsset;

  const OnboardingPage({
    required this.fadeAnimation,
    required this.title,
    required this.description,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imageAsset),
          Text(title),
          Text(description),
        ],
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  final AnimationController _controller;

  OnboardingScreen({Key? key, required AnimationController controller})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    return PageView(
      children: [
        OnboardingPage(
          fadeAnimation: fadeAnimation, // Pass fadeAnimation here
          title: 'Welcome',
          description: 'Your app description',
          imageAsset: 'assets/images/onboarding_1.png',
        ),
        OnboardingPage(
          fadeAnimation: fadeAnimation, // Pass fadeAnimation here
          title: 'Get Started',
          description: 'How to use the app',
          imageAsset: 'assets/images/onboarding_2.png',
        ),
        // Add other onboarding pages here
      ],
    );
  }
}
