/// Weather Error Message
class WeatherException implements Exception {
  String message;
  WeatherException([this.message = 'Something went wrong ']) {
    message = 'weather Exception: $message}';
  }

  @override
  String toString() {
    return message;
  }
}