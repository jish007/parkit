import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 150),
            const HeaderSection(),
            const SizedBox(height: 50),
            const EdgeImagesSection(),
            const SizedBox(height: 50),
            const AboutUsSection(),
            const SizedBox(height: 100),
            const ServicesCardsSection(),
            const SizedBox(height: 50),
            const EmbeddedYouTubeVideo(),
            const SizedBox(height: 50),
          ],
        ),
      );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0), // Adds space to the left
      child: Column(
        crossAxisAlignment: CrossAxisAlignment
            .start, // Ensures content is aligned to the left inside the Column
        children: [
          const Text(
            'Find professional\nservices in your area',
            textAlign: TextAlign.left, // Left-aligns the text
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Autospace is one of the most finest group of\ncollaborative services you wish for',
            textAlign: TextAlign.left, // Aligns the text content to the left
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Roboto',
              color: Color.fromARGB(255, 255, 152, 0),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment
                .start, // Ensures row content is aligned to the left
            children: [
              Image.asset('assets/super_admin/icons/google_play.png', height: 20),
              const SizedBox(width: 10),
              Image.asset('assets/super_admin/icons/app_store.png', height: 20),
            ],
          ),
        ],
      ),
    );
  }
}

class EdgeImagesSection extends StatelessWidget {
  const EdgeImagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 200,
          width: 250,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/super_admin/icons/left.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Container(
          height: 390,
          width: 360,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/super_admin/icons/right.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}

class AboutUsSection extends StatelessWidget {
  const AboutUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height* 0.9,


          padding: const EdgeInsets.all(100), // Increased padding here
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'About us',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'We connect with reliable and skilled professionals\n'
                    'offering on-demand services in your local area. \n'
                    'Trusted expertise who get the job done quickly.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        Positioned(
          top: -250,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              height: 600,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(66, 251, 251, 251),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage('assets/super_admin/icons/2app.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ServicesCardsSection extends StatefulWidget {
  const ServicesCardsSection({super.key});

  @override
  _ServicesCardsSectionState createState() => _ServicesCardsSectionState();
}

class _ServicesCardsSectionState extends State<ServicesCardsSection> {
  // To store the hover state for each card
  List<bool> _isHovered = List.generate(8, (index) => false);

  @override
  Widget build(BuildContext context) {
    final services = [
      'Nearby Parking Search',
      'Navigation to Parking Lot',
      'Pre-booking of Parking Slots',
      'Slot Extension',
      'Real-time Parking Slot Availability',
      'Notifications for Parking Time Expiration',
      'Monthly/Yearly Subscription Plans',
      'Automatic Entry/Exit'
    ];

    final descriptions = [
      'Users can check the availability of parking slots in nearby parking plots.',
      'The app provides navigation assistance to the selected parking lot using Google Maps.',
      'Users can pre-book a parking slot for a specific time and select the duration for which they need the parking.',
      'Users can extend their parking time after pre-booking if needed.',
      'The app provides real-time information on the availability of parking slots in the parking plot.',
      'Users receive notifications when their parking time is about to end, prompting them to extend if necessary.',
      'Users can opt for a subscription plan (monthly or yearly) for continuous parking service.',
      'The app supports automatic entry and exit using license plate recognition for seamless gate operation without manual intervention.'
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 2 cards per row for better visual balance
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return MouseRegion(
          onEnter: (_) {
            setState(() {
              _isHovered[index] = true;
            });
          },
          onExit: (_) {
            setState(() {
              _isHovered[index] = false;
            });
          },
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: _isHovered[index]
                ? Colors.orange
                : Colors.white, // Hover color change
            child: SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.42, // Adjust card width dynamically
              height: 200, // Fixed height for consistency
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      services[index],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _isHovered[index]
                            ? Colors.white
                            : Colors.blueAccent, // Text color changes on hover
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                        height:
                        12), // More spacing between title and description
                    Text(
                      descriptions[index],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


class EmbeddedYouTubeVideo extends StatefulWidget {
  const EmbeddedYouTubeVideo({super.key});

  @override
  State<EmbeddedYouTubeVideo> createState() => _EmbeddedYouTubeVideoState();
}

class _EmbeddedYouTubeVideoState extends State<EmbeddedYouTubeVideo> {
  late YoutubePlayerController _controller;
  String selectedLanguage = 'English';

  final Map<String, String> videoIds = {
    'English': 'qaeHKoq_CLM',
    'Malayalam': 'rwrOBUwauT4',
  };

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoIds[selectedLanguage]!,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  void _changeVideo(String language) {
    setState(() {
      selectedLanguage = language;
      _controller.loadVideoById(videoId: videoIds[language]!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Watch Our Video',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 251, 251),
          ),
        ),
        const SizedBox(height: 20),
        DropdownButton<String>(
          value: selectedLanguage,
          items: videoIds.keys.map((String language) {
            return DropdownMenuItem<String>(
              value: language,
              child: Text(
                language,
                style: TextStyle(
                  color: Colors.red, // Set the text color to red
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              _changeVideo(newValue);
            }
          },
          dropdownColor: Colors.white,
        ),
        const SizedBox(height: 20),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 600,
            child: YoutubePlayer(
              controller: _controller,
              aspectRatio: 16 / 9,
            ),
          ),
        ),
        const SizedBox(height: 40),
        // Footer Section
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height* 0.5,
          // Footer background color

          decoration: BoxDecoration(
            color: Colors.blueAccent,  // Change to your desired color
            borderRadius: BorderRadius.circular(20),  // Rounded corners
          ),
          // Padding

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo or Company Name (optional)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),  // Adjust padding value as needed
                  child: const Text(
                    'MyParking App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),



              // Description or slogan (optional)
              const Text(
                'Smart Parking Solutions for a Better Tomorrow',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),

              // Footer Links (like Privacy Policy, Terms of Service)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Privacy Policy',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Terms of Service',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Help & Support',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Social Media Icons (example with 3 platforms)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.facebook, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.facebook, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.one_x_mobiledata, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Contact Information
              const Text(
                'Contact us: support@mparking.com',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 10),

              // Copyright Information
              const Text(
                '© 2025 MyParking App. All Rights Reserved.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}