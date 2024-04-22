class Weather {
  final String description;
  final String icon;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String name;
  final String country;
  final String lastUpdated;

  const Weather({
    required this.description,
    required this.icon,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.name,
    required this.country,
    required this.lastUpdated,
  });

  factory Weather.initial() => Weather(
    description: '',
    icon: '',
    temp: 0.0,
    tempMin: 0.0,
    tempMax: 0.0,
    name: '',
    country: '',
    lastUpdated: DateTime(2000).toString()
  );

  factory Weather.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];

    return Weather(
      description: weather['description'],
      icon: weather['icon'],
      temp: main['temp'],
      tempMin: weather['tempMin'],
      tempMax: weather['tempMax'],
      name: '',
      country: '',
      lastUpdated: DateTime.now().toString(),
    );
  }

  @override
  String toString() {
    return 'Weather{description: $description, icon: $icon, temp: $temp, tempMin: $tempMin, tempMax: $tempMax, name: $name, country: $country, lastUpdated: $lastUpdated}';
  }

  @override
  List<Object> get props =>
      [description, icon, temp, tempMin, tempMax, name, country, lastUpdated,];

  Weather copyWith({
    String? description,
    String? icon,
    double? temp,
    double? tempMin,
    double? tempMax,
    String? name,
    String? country,
    String? lastUpdated,
  }) {
    return Weather(
      description: description ?? this.description,
      icon: icon ?? this.icon,
      temp: temp ?? this.temp,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      name: name ?? this.name,
      country: country ?? this.country,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}