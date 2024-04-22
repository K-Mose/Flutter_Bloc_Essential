import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/cubits/weather/weather_cubit.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/widgets/error_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _city;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather"),
        actions: [
          IconButton(
            onPressed: () async {
              _city = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const SearchPage();
              },));
              print("city:: $_city");
              if (_city != null && context.mounted) {
                context.read<WeatherCubit>().fetchWeather(_city!);
              }
            },
            icon: const Icon(Icons.search)
          ),
        ],
      ),
      body: _showWeather()
    );
  }

  Widget _showWeather() {
    return BlocConsumer<WeatherCubit, WeatherState>(
        listener: (context, state) {
          if (state.status == WeatherStatus.error) {
            errorDialog(context, state.error.errMsg);
          }
        },
        builder: (context, state) {
          if (state.status == WeatherStatus.initial ||
              (state.status == WeatherStatus.error && state.weather.name == '')) {
            return const Center(
              child: Text(
                'Select a city',
                style: TextStyle(fontSize: 20.0),
              ),
            );
          } else if (state.status == WeatherStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Text(
              state.weather.name,
              style: const TextStyle(fontSize: 22.0),
            ),
          );
        },
    );
  }
}
