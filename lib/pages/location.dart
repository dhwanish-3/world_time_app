import 'package:flutter/material.dart';
import 'package:world_app/classes/world_time.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final _searchFilter = TextEditingController();
  List<WorldTime> geoLocations = [
    WorldTime('London', 'uk.png', 'Europe/London'),
    WorldTime('Athens', 'greece.png', 'Europe/Berlin'),
    WorldTime('Cairo', 'egypt.png', 'Africa/Cairo'),
    WorldTime('Nairobi', 'kenya.png', 'Africa/Nairobi'),
    WorldTime('Chicago', 'usa.png', 'America/Chicago'),
    WorldTime('New York', 'usa.png', 'America/New_York'),
    WorldTime('Seoul', 'south_korea.png', 'Asia/Seoul'),
    WorldTime('Jakarta', 'indonasia.png', 'Asia/Jakarta'),
    WorldTime('Berlin', 'germany.png', 'Europe/Berlin'),
    WorldTime('Singapore', 'singapore.png', 'Asia/Singapore'),
    WorldTime('Vienna', 'vienna.png', 'Europe/Vienna'),
    WorldTime('Kolkata', 'india.png', 'Asia/Kolkata'),
    WorldTime('Qatar', 'qatar.png', 'Asia/Qatar'),
    WorldTime('Los Angeles', 'usa.png', 'America/Los_Angeles'),
  ];

  void updateTime(index) async {
    WorldTime instance = geoLocations[index];
    await instance.getTime();
    // ignore: use_build_context_synchronously
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
      'date': instance.date,
    });
  }

  @override
  void initState() {
    super.initState();
    geoLocations.sort((a, b) => a.location.compareTo(b.location));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Choose A Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _searchFilter,
              decoration: InputDecoration(
                hintText: 'Search',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: geoLocations.length,
                  itemBuilder: (context, index) {
                    if (_searchFilter.text.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 4.0),
                        child: Card(
                          child: ListTile(
                              onTap: () async {
                                updateTime(index);
                              },
                              title: Text(geoLocations[index].location),
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/${geoLocations[index].flag}'),
                              )),
                        ),
                      );
                    } else if (geoLocations[index]
                        .location
                        .toLowerCase()
                        .contains(_searchFilter.text.toLowerCase())) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 4.0),
                        child: Card(
                          child: ListTile(
                              onTap: () async {
                                updateTime(index);
                              },
                              title: Text(geoLocations[index].location),
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/${geoLocations[index].flag}'),
                              )),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
