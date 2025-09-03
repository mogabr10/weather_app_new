import 'package:flutter/material.dart';
import 'glass_bottom_sheet.dart';
import 'forecast_cards.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          Column(
            //Tempreature and weather info
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Text(
                  'Montreal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                  // alignment: Alignment.center,
                ),
              ),
              Text(
                '19°C',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 96,
                  fontWeight: FontWeight.bold,
                ),
                // alignment: Alignment.center,
              ),
              Text(
                'Mostly Sunny',
                style: TextStyle(
                  color: const Color.fromARGB(255, 156, 155, 155),
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
                // alignment: Alignment.center,
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

              Image(
                image: AssetImage('images/house.png'),
                width: 390,
                alignment: Alignment.center,
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
            tabs: ['Hourly Forecast', 'Weekly Forecast'],
            tabViews: [HourlyForecast(), WeeklyForecastScreen()],
          ),
        ],
      ),
    );
  }
}
