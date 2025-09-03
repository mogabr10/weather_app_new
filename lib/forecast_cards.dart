import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'weather_card_widget.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: hourlyWeatherData.map((card) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: WeatherCard(data: card, type: WeatherCardType.hourly),
            );
          }).toList(),
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
    List<WeatherCardData> weeklyData = List.generate(7, (index) {
      // Calculate date for each day of the week
      DateTime now = DateTime.now();
      int currentWeekday = now.weekday; // 1=Mon, 2=Tue, ..., 7=Sun
      DateTime startDate = now.subtract(
        Duration(days: currentWeekday - 1),
      ); // Start from Monday
      DateTime targetDate = startDate.add(Duration(days: index));

      // Format day name (e.g., Mon, Tue)
      String dayName = DateFormat.E().format(targetDate);

      return WeatherCardData.weekly(
        title: dayName,
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
              child: WeatherCard(data: forecast, type: WeatherCardType.weekly),
            );
          }).toList(),
        ),
      ),
    );
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

// Sample data for hourly forecast
final List<WeatherCardData> hourlyWeatherData = [
  WeatherCardData.hourly(
    title: '12 AM',
    iconPath: 'images/icons/Moon cloud mid rain.png',
    temperature: '19°',
    percentage: '30%',
  ),
  WeatherCardData.hourly(
    title: 'Now',
    iconPath: 'images/icons/Moon cloud fast wind.png',
    temperature: '19°',
  ),
  WeatherCardData.hourly(
    title: '2 AM',
    iconPath: 'images/icons/Sun cloud angled rain.png',
    temperature: '18°',
  ),
  WeatherCardData.hourly(
    title: '3 AM',
    iconPath: 'images/icons/Sun cloud mid rain.png',
    temperature: '19°',
  ),
  WeatherCardData.hourly(
    title: '4 AM',
    iconPath: 'images/icons/Moon cloud fast wind.png',
    temperature: '19°',
  ),
];

// Sample data for hourly forecast
final List<WeatherCardData> weatherCards = [
  WeatherCardData.hourly(
    title: '12 AM',
    iconPath: 'images/icons/Moon cloud mid rain.png',
    temperature: '19°',
    percentage: '30%',
  ),
  WeatherCardData.hourly(
    title: 'Now',
    iconPath: 'images/icons/Moon cloud fast wind.png',
    temperature: '19°',
  ),
  WeatherCardData.hourly(
    title: '2 AM',
    iconPath: 'images/icons/Sun cloud angled rain.png',
    temperature: '18°',
  ),
  WeatherCardData.hourly(
    title: '3 AM',
    iconPath: 'images/icons/Sun cloud mid rain.png',
    temperature: '19°',
  ),
  WeatherCardData.hourly(
    title: '4 AM',
    iconPath: 'images/icons/Moon cloud fast wind.png',
    temperature: '19°',
  ),
];
