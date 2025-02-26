import 'dart:io';

// Server URLs
const emulatorIp = '10.0.2.2:8080';
const simulatorIp = '127.0.0.1:8080';

String get baseUrl {
  if (Platform.isAndroid) {
    return 'http://$emulatorIp';
  }
  if (Platform.isIOS) {
    return 'http://$simulatorIp';
  }
  return 'http://$simulatorIp';
}

// Token Keys
const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';
