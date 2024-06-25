class Environment {
  //production
  //development
  static String get envMode => 'development';
    static String get apiUrl => envMode == 'development' 
    ? cropUrl('https://reqres.in/api/') 
    : cropUrl('https://reqres.in/api/');

  static String cropUrl(String originalUrl) {
    Uri uri = Uri.parse(originalUrl);
    Uri croppedUri = Uri(
      scheme: uri.scheme,
      host: uri.host,
      path: '/api/',
    );
    return croppedUri.toString();
  }
}