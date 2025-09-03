import 'package:flutter/material.dart';
import 'glass_bottom_sheet.dart';
import 'forecast_cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // Animation controller for text movement
  late AnimationController _textAnimationController;
  late Animation<double> _textMoveAnimation;

  // Track the bottom sheet position
  double _sheetPosition = 0.35;

  // Threshold at which the text should start moving (when sheet touches text)
  final double _textMoveThreshold = 0.5;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _textAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Create animation curve for smooth movement
    _textMoveAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textAnimationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _textAnimationController.dispose();
    super.dispose();
  }

  // Called when bottom sheet position changes
  void _onSheetPositionChanged(double position) {
    setState(() {
      _sheetPosition = position;

      // If sheet position exceeds threshold, animate text up
      if (position >= _textMoveThreshold &&
          !_textAnimationController.isCompleted) {
        _textAnimationController.forward();
      }
      // If sheet position goes below threshold, animate text back down
      else if (position < _textMoveThreshold &&
          _textAnimationController.isCompleted) {
        _textAnimationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            // background image
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            width: double.infinity,
            height: double.infinity,
          ),
          // Stack with animated text and static image
          Stack(
            children: [
              // Static image at the bottom
              Positioned(
                bottom: 80,
                left: 0,
                right: 0,
                child: Image(
                  image: AssetImage('images/house.png'),
                  width: 390,
                  alignment: Alignment.center,
                ),
              ),

              // Animated weather text
              AnimatedBuilder(
                animation: _textMoveAnimation,
                builder: (context, child) {
                  // Calculate vertical offset based on animation value
                  final double verticalOffset =
                      -80.0 * _textMoveAnimation.value;

                  return Transform.translate(
                    offset: Offset(0, verticalOffset),
                    child: Column(
                      //Tempreature and weather info
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 100.0 - (30.0 * _textMoveAnimation.value),
                          ),
                          child: Text(
                            'Montreal',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '19°C',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 96,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Mostly Sunny',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 156, 155, 155),
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'High: 24°C',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 217, 217, 217),
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 1,
                              endIndent: 10,
                              indent: 10,
                            ),
                            Text(
                              'Low: 12°C',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 217, 217, 217),
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        // Add empty space to make room for the image
                        SizedBox(height: 300),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          GlassBottomSheet(
            initialChildSize: 0.35,
            maxChildSize: 0.8,
            blurSigma: 10,
            noiseAsset: "images/noise2.png",
            // add noise overlay
            gradient: const LinearGradient(
              // custom gradient
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0x802E335A), Color(0xFF1C1B33)],
              stops: [0.0, 1.0],
            ),
            noiseOpacity: 0.04, // tweak intensity
            onPositionChanged: _onSheetPositionChanged,
            tabs: ['Hourly Forecast', 'Weekly Forecast'],
            tabViews: [HourlyForecast(), WeeklyForecastScreen()],
          ),
        ],
      ),
    );
  }
}
