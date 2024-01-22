import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location = '';
  String date = '';
  String time = '';
  String flag = '';
  String url = '';
  bool isDayTime = false;
  WorldTime(String l, String f, String u) {
    location = l;
    flag = f;
    url = u;
  }

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      // debugPrint(data['datetime']);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);
      String offsetMinute = data['utc_offset'].substring(4, 6);
      // debugPrint(offset);
      // debugPrint(offset_minute);

      DateTime now = DateTime.parse(datetime);
      date = DateFormat('dd-MM-yyyy').format(now);
      now = now.add(Duration(hours: int.parse(offset)));

      now = now.add(Duration(minutes: int.parse(offsetMinute)));
      isDayTime = (now.hour > 6 && now.hour < 20) ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      time = 'Could not get time data';
    }
  }
}
