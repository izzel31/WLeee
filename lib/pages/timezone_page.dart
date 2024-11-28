import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimezonePage extends StatefulWidget {
  const TimezonePage({super.key});

  @override
  _TimezonePageState createState() => _TimezonePageState();
}

class _TimezonePageState extends State<TimezonePage> {
  // Sample movie data
  final List<Map<String, dynamic>> movies = [
    {
      'title': 'The Shawshank Redemption',
      'release_date': '1994-09-10',
      'poster_path': '/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg',
      'show_time': DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 14, 30),
    },
    {
      'title': 'The Godfather',
      'release_date': '1972-03-24',
      'poster_path': '/3bhkrj58Vtu7enYsRolD1fZdja1.jpg',
      'show_time': DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 18, 45),
    },
    {
      'title': 'The Dark Knight',
      'release_date': '2008-07-18',
      'poster_path': '/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
      'show_time': DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 21, 0),
    },
  ];

  String _selectedTimezone = 'WIB';

  // untuk konversi waktu ke timezone yang dipilih, menambahkan jam sesuai timezone
  DateTime _convertToTimezone(DateTime dateTime, String timezone) {
    final utcDateTime = dateTime.toUtc();
    switch (timezone) {
      case 'WIB':
        return utcDateTime.add(const Duration(hours: 7));
      case 'WITA':
        return utcDateTime.add(const Duration(hours: 8));
      case 'WIT':
        return utcDateTime.add(const Duration(hours: 9));
      case 'London':
        return utcDateTime;
      default:
        return utcDateTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Select timezone: '),
              DropdownButton<String>(
                value: _selectedTimezone,
                items: const [
                  DropdownMenuItem(value: 'WIB', child: Text('WIB')),
                  DropdownMenuItem(value: 'WITA', child: Text('WITA')),
                  DropdownMenuItem(value: 'WIT', child: Text('WIT')),
                  DropdownMenuItem(value: 'London', child: Text('London')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedTimezone = value;
                    });
                  }
                },
              ),
            ],
          ),
        ),
        // List of movies
        Expanded(
          child: ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              final showTime =
                  _convertToTimezone(movie['show_time'], _selectedTimezone);
              final formattedTime =
                  DateFormat('yyyy-MM-dd HH:mm').format(showTime);

              return ListTile(
                title: Text(movie['title']),
                subtitle: Text('Time: $formattedTime'),
                leading: Image.network(
                  'https://image.tmdb.org/t/p/w500/${movie['poster_path']}',
                  width: 50,
                  height: 75,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
