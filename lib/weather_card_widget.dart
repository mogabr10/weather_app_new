import 'package:flutter/material.dart';
import 'glass_container.dart';

enum WeatherCardType { hourly, weekly }

class WeatherCardData {
  final String title; // time for hourly, dayName for weekly
  final String iconPath;
  final String? temperature; // for hourly
  final String? percentage; // for hourly
  final String? highTemp; // for weekly
  final String? lowTemp; // for weekly
  WeatherCardData.hourly({
    required this.title,
    required this.iconPath,
    required this.temperature,
    this.percentage,
  }) : highTemp = null,
       lowTemp = null;

  WeatherCardData.weekly({
    required this.title,
    required this.iconPath,
    required this.highTemp,
    required this.lowTemp,
  }) : temperature = null,
       percentage = null;
}

class WeatherCard extends StatefulWidget {
  final WeatherCardData data;
  final WeatherCardType type;

  const WeatherCard({super.key, required this.data, required this.type});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
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
                    blurRadius: widget.type == WeatherCardType.hourly ? 12 : 10,
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
                    const Color.fromARGB(255, 83, 1, 176).withOpacity(0.4),
                    const Color(0xFFDAA520).withOpacity(0.4),
                  ]
                : [const Color(0x802E335A), const Color(0x801C1B33)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.data.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: widget.type == WeatherCardType.hourly ? 12 : 16),
              if (widget.type == WeatherCardType.hourly &&
                  widget.data.percentage != null)
                Column(
                  children: [
                    Image.asset(widget.data.iconPath, width: 32, height: 32),
                    Text(
                      widget.data.percentage!,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 2, 204, 255),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              else
                Image.asset(widget.data.iconPath, width: 32, height: 32),
              SizedBox(height: widget.type == WeatherCardType.hourly ? 12 : 16),
              if (widget.type == WeatherCardType.hourly)
                Text(
                  widget.data.temperature!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.data.highTemp}/${widget.data.lowTemp}°',
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
