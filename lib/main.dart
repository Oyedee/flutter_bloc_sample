import 'package:bloc_sample/bloc/weather_bloc.dart';
import 'package:bloc_sample/model/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          create: (context) => WeatherBloc(),
          child: const MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is WeatherInitial) {
              return buildInitialInput(context);
            } else if (state is WeatherLoading) {
              return buildLoading();
            } else if (state is WeatherLoaded) {
              return buildColumnWithData(context, state.weather);
            } else {
              return buildInitialInput(context);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  dispose() {
    WeatherBloc().close();
    super.dispose();
  }

  Column buildColumnWithData(BuildContext context, Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          weather.cityName,
          style: const TextStyle(fontSize: 30, color: Colors.black),
        ),
        Text(
          '${weather.temperatureCelsius.toStringAsFixed(1)} °C',
          style: Theme.of(context).textTheme.headline4,
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: cityInputField(context),
        ),
      ],
    );
  }

  TextField cityInputField(BuildContext context) {
    return TextField(
      onSubmitted: (String cityName) {
        final weatherBloc = BlocProvider.of<WeatherBloc>(context);
        weatherBloc.add(GetWeather(cityName: cityName));
      },
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        suffixIcon: Icon(Icons.search),
        hintText: 'Enter City Name',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget buildInitialInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: cityInputField(context),
      ),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
