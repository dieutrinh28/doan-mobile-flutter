import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:url_launcher/url_launcher.dart';


class CalendarAuth {
  static Future<AutoRefreshingAuthClient> obtainAuthenticatedClient() async {
    final clientID = ClientId(
      '516240176290-0c89d7g32p3c4mso1mpefa8j3dgn0idv.apps.googleusercontent.com',
      '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',
    );

    final scopes = [CalendarApi.calendarScope];

    final client = await clientViaUserConsent(clientID, scopes, prompt);

    return client;
  }

  static Future<void> prompt(String url) async {
    // url = 'http://auth.com';
    url = 'https://www.googleapis.com/auth/calendar';

    print("Please go to the following URL and grant access:");
    print("  => $url");
    print("");

    final Uri uri = Uri.file(url);

    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }

  }
}
