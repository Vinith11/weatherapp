import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/pages/const.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? _weather; //stores the information of weather of specific location
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _wf.currentWeatherByCityName("belagavi").then((w){   // request to get weather info
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: _buildUI(),
    );
  }

  Widget _buildUI(){
    if(_weather == null){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _locationheader(),
          SizedBox(height: MediaQuery.sizeOf(context).height*0.06,),
          _datetime(),
          SizedBox(height: MediaQuery.sizeOf(context).height*0.04,),
          _weathericon(),
          SizedBox(height: MediaQuery.sizeOf(context).height*0.04,),
          _currenttemp(),
          SizedBox(height: MediaQuery.sizeOf(context).height*0.04,),
          _extrainfo(),
        ],
      ),
    );
  }

  Widget _locationheader(){
     return Text(_weather?.areaName??"",style: const TextStyle(
       fontSize: 25,
       fontWeight: FontWeight.w500,
     )
     );
  }

  Widget _datetime(){
     DateTime now = _weather!.date!;
     return Column(children: [
       Text(
         DateFormat("h:mm a").format(now),
         style: const TextStyle(fontSize: 35),
       ),
       const SizedBox( height: 10,),
       Row(
         mainAxisSize: MainAxisSize.max,
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Text(
             DateFormat("EEEE").format(now),
             style: const TextStyle(fontSize: 15,
               fontWeight: FontWeight.w600
             ),
           ),
           Text(
             "    ${DateFormat("d.m.y").format(now)}",
             style: const TextStyle(fontSize: 15,
                 fontWeight: FontWeight.w400
             ),
           ),
         ],
       )
     ],
     );
  }

  Widget _weathericon(){
     return Column(
       mainAxisSize: MainAxisSize.min,
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Container(
           height: MediaQuery.sizeOf(context).height*0.2,
                decoration:BoxDecoration(image: DecorationImage(
                image: NetworkImage("https://openweathermap.org/img/wn/${_weather!.weatherIcon}@4x.png"),
            ),
           ),
         ),
         Text(_weather?.weatherDescription??"",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
         ),
       ],
     );
  }

  Widget _currenttemp(){
     return Text("${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
         style: const TextStyle(
           color: Colors.black,
           fontSize: 40,
        ),
     );
  }

    Widget _extrainfo(){
        return Container(
          height: MediaQuery.sizeOf(context).height*0.15,
          width: MediaQuery.sizeOf(context).width*0.90,
          decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(8.0),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",style: const TextStyle(color: Colors.black),),
                  Text("  Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",style: const TextStyle(color: Colors.black),),
                  //Text("  Sunset: ${_weather?.sunset?.timeZoneOffset??""} " , style: const TextStyle(color: Colors.black),),

                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",style: const TextStyle(color: Colors.black),),
                  Text("Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",style: const TextStyle(color: Colors.black),),
                  //Text("Sunrise: ${_weather?.sunrise?.timeZoneOffset??""} " , style: const TextStyle(color: Colors.black),),
                ],
              )
            ],
          ),
        );
    }
}
