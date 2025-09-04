import 'dart:ui';
import 'package:flutter/material.dart';
import 'glass_bottom_sheet.dart';
import 'forecast_cards.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background (just an example)
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

          /// Weather Header that animates
          AnimatedBuilder(
            animation: Listenable.merge([ValueNotifier(_progress)]),
            builder: (context, _) {
              // interpolate vertical offset
              final topPadding = lerpDouble(
                120,
                0,
                _progress,
              )!; // stick to top at full expand

              return Positioned(
                top: topPadding,
                left: 0,
                right: 0,
                child: Center(child: WeatherHeader(progress: _progress)),
              );
            },
          ),

          /// Draggable Bottom Sheet
          NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              final min = 0.3;
              final max = 0.9;

              final newProgress = ((notification.extent - min) / (max - min))
                  .clamp(0.0, 1.0);

              setState(() {
                _progress = newProgress;
              });
              return true;
            },
            child: GlassBottomSheet(
              initialChildSize: 0.3,
              minChildSize: 0.3,
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
              tabs: ['Hourly Forecast', 'Weekly Forecast'],
              tabViews: [HourlyForecast(), WeeklyForecastScreen()],
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherHeader extends StatelessWidget {
  final double progress; // 0.0 = big layout, 1.0 = compact layout

  const WeatherHeader({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180, // enough space for both states
      child: Stack(
        children: [
          // City name
          _animatedText(
            text: "Montreal",
            fontSizeStart: 32,
            fontSizeEnd: 32,
            start: const Offset(0.0, 0.0), // top of column
            end: const Offset(0.0, -0.4), // shift left when compact
            progress: progress,
            fontWeight: FontWeight.bold,
          ),

          // Temperature
          _animatedText(
            text: "19°",
            fontSizeStart: 80,
            fontSizeEnd: 20,
            start: const Offset(0.0, 2.0), // below city
            end: const Offset(-0.45, -0.3), // next to city in row
            progress: progress,
            fontWeight: FontWeight.w300,
          ),

          // Description
          _animatedText(
            text: "Mostly Clear",
            fontSizeStart: 22,
            fontSizeEnd: 22,
            start: const Offset(0.0, 1.6),
            end: const Offset(0.25, -0.25),
            progress: progress,
            color: Colors.white70,
          ),

          // High / Low
          Opacity(
            opacity: 0.9 - progress, // hide when compact
            child: _animatedText(
              text: "H:24°  L:18°",
              fontSizeStart: 22,
              fontSizeEnd: 16,
              start: const Offset(0.0, 2.0),
              end: const Offset(0.0, 0.0),
              progress: progress,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _animatedText({
    required String text,
    required double fontSizeStart,
    required double fontSizeEnd,
    required Offset start,
    required Offset end,
    required double progress,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.white,
  }) {
    final fontSize = lerpDouble(fontSizeStart, fontSizeEnd, progress)!;
    final dx = lerpDouble(start.dx, end.dx, progress)!;
    final dy = lerpDouble(start.dy, end.dy, progress)!;

    return Align(
      alignment: Alignment(dx, dy),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}
