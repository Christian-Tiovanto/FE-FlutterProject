import 'package:flutter/material.dart';
import 'package:project/hadron/login_screen.dart';

class WalkthroughSlider extends StatefulWidget {
  const WalkthroughSlider({super.key});

  @override
  _WalkthroughSliderState createState() => _WalkthroughSliderState();
}

class _WalkthroughSliderState extends State<WalkthroughSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = [
    const WalkthroughPage(
      title: 'About Application',
      description:
          'Welcome to KM Disposition, a sophisticated solution for managing your mail disposals. This application is designed to simplify and speed up the mail disposal process in your organization or institution environment. With the innovative features we offer, you can manage, track, and dispose of incoming and outgoing mail more efficiently.',
      image: 'assets/logo.png',
    ),
    WalkthroughPage(
      title: 'How to Use',
      description: RichText(
        text: const TextSpan(
          style: TextStyle(fontSize: 18, color: Colors.black),
          children: <TextSpan>[
            TextSpan(
                text:
                    '1. This application can only register employee accounts or users using super admin.\n'),
            TextSpan(
                text:
                    '2. On the Dashboard page, you can filter to see urgent or regular letters, and you can apply for a letter. \n'),
            TextSpan(
                text:
                    '3. On the Submission page, you can apply for a letter, choose the type of letter, and select the letter priority. \n'),
            TextSpan(
                text:
                    '4. On the Letter Content page, you can see the contents of the letter we sent, or you can add files. \n'),
            TextSpan(
                text:
                    '5. On the History page, you can see letters that are Pending, Finished, and Cancelled. \n'),
            TextSpan(
                text:
                    '6. On the Super Admin page, you can create users and see the user list that has been registered.'),
          ],
        ),
      ),
      image: 'assets/logo.png',
    ),
    const WalkthroughPage(
      title: 'Get Started',
      description: 'Get started and enjoy our app!',
      image: 'assets/logo.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return _pages[index];
            },
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage != 0)
                  ElevatedButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text('Previous'),
                  ),
                if (_currentPage != _pages.length - 1)
                  ElevatedButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text('Next'),
                  ),
                if (_currentPage == _pages.length - 1)
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to HomePage when "Get Started" button is pressed
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login_screen(),
                        ),
                      );
                    },
                    child: const Text('Get Started'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WalkthroughPage extends StatelessWidget {
  final String title;
  final dynamic
      description; // Change this to dynamic to allow both String and RichText
  final String image;

  const WalkthroughPage({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Spacer(flex: 1),
          Image.asset(
            image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          description is String
              ? Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                )
              : description,
          const Spacer(
              flex: 3), // Adjust this value to position the text higher
        ],
      ),
    );
  }
}
