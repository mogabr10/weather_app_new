import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'glass_container.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: weatherCards.map((card) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: _buildWeatherCard(card),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildWeatherCard(WeatherCard card) {
    return WeatherCardWidget(card: card);
  }
}

class WeatherCardWidget extends StatefulWidget {
  final WeatherCard card;

  const WeatherCardWidget({super.key, required this.card});

  @override
  State<WeatherCardWidget> createState() => _WeatherCardWidgetState();
}

class _WeatherCardWidgetState extends State<WeatherCardWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onPointerUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          boxShadow: _isPressed
              ? [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.8),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ],
        ),
        child: GlassContainer(
          width: 60,
          height: 146,
          borderRadius: BorderRadiusGeometry.circular(40),
          noiseAsset: 'images/noise2.png',
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _isPressed
                ? [
                    const Color(0xFFFFD700).withOpacity(0.4),
                    const Color(0xFFDAA520).withOpacity(0.4),
                  ]
                : [const Color(0x802E335A), const Color(0x801C1B33)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.card.time,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              if (widget.card.percentage != null)
                Column(
                  children: [
                    Image.asset(
                      widget.card.iconPath,
                      width: 32,
                      height: 32,
                    ),
                    Text(
                      widget.card.percentage!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              else
                Image.asset(
                  widget.card.iconPath,
                  width: 32,
                  height: 32,
                ),

              const SizedBox(height: 12),

              Text(
                widget.card.temperature,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(),
            ],
          ),
        ),
      ),
    );
  }
}

class WeeklyForecastScreen extends StatelessWidget {
  const WeeklyForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Generate weekly data using index to get day names
    List<WeeklyForecast> weeklyData = List.generate(7, (index) {
      // Calculate date for each day of the week
      DateTime now = DateTime.now();
      int currentWeekday = now.weekday; // 1=Mon, 2=Tue, ..., 7=Sun
      DateTime startDate = now.subtract(
        Duration(days: currentWeekday - 1),
      ); // Start from Monday
      DateTime targetDate = startDate.add(Duration(days: index));

      // Format day name (e.g., Mon, Tue)
      String dayName = DateFormat.E().format(targetDate);

      return WeeklyForecast(
        dayName: dayName,
        iconPath: _getIconForIndex(index),
        highTemp: '${18 + index}',
        lowTemp: '${12 + index}',
      );
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: weeklyData.map((forecast) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: _buildWeeklyCard(forecast),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildWeeklyCard(WeeklyForecast forecast) {
    return WeeklyCardWidget(forecast: forecast);
  }

  // Assign different icons based on index
  String _getIconForIndex(int index) {
    switch (index % 4) {
      case 0:
        return 'images/icons/Moon cloud fast wind.png';
      case 1:
        return 'images/icons/Sun cloud angled rain.png';
      case 2:
        return 'images/icons/Sun cloud mid rain.png';
      default:
        return 'images/icons/Moon cloud mid rain.png';
    }
  }
}

class WeeklyCardWidget extends StatefulWidget {
  final WeeklyForecast forecast;

  const WeeklyCardWidget({super.key, required this.forecast});

  @override
  State<WeeklyCardWidget> createState() => _WeeklyCardWidgetState();
}

class _WeeklyCardWidgetState extends State<WeeklyCardWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onPointerUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          boxShadow: _isPressed
              ? [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.8),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ],
        ),
        child: GlassContainer(
          width: 60,
          height: 146,
          borderRadius: BorderRadiusGeometry.circular(40),
          noiseAsset: 'images/noise2.png',
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _isPressed
                ? [
                    const Color(0xFFFFD700).withOpacity(0.4),
                    const Color(0xFFDAA520).withOpacity(0.4),
                  ]
                : [const Color(0x802E335A), const Color(0x801C1B33)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.forecast.dayName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Image.asset(
                widget.forecast.iconPath,
                width: 32,
                height: 32,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.forecast.highTemp}/${widget.forecast.lowTemp}°',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Data Models
class WeatherCard {
  final String time;
  final String iconPath;
  final String temperature;
  final String? percentage;

  WeatherCard({
    required this.time,
    required this.iconPath,
    required this.temperature,
    this.percentage,
  });
}

class WeeklyForecast {
  final String dayName;
  final String iconPath;
  final String highTemp;
  final String lowTemp;

  WeeklyForecast({
    required this.dayName,
    required this.iconPath,
    required this.highTemp,
    required this.lowTemp,
  });
}

// Sample data for hourly forecast
final List<WeatherCard> weatherCards = [
  WeatherCard(
    time: '12 AM',
    iconPath: 'images/icons/Moon cloud mid rain.png',
    temperature: '19°',
    percentage: '30%',
  ),
  WeatherCard(
    time: 'Now',
    iconPath: 'images/icons/Moon cloud fast wind.png',
    temperature: '19°',
  ),
  WeatherCard(
    time: '2 AM',
    iconPath: 'images/icons/Sun cloud angled rain.png',
    temperature: '18°',
  ),
  WeatherCard(
    time: '3 AM',
    iconPath: 'images/icons/Sun cloud mid rain.png',
    temperature: '19°',
  ),
  WeatherCard(
    time: '4 AM',
    iconPath: 'images/icons/Moon cloud fast wind.png',
    temperature: '19°',
  ),
];
