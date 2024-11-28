import 'package:flutter/material.dart';

class TicketPricePage extends StatefulWidget {
  const TicketPricePage({super.key});

  @override
  _TicketPricePageState createState() => _TicketPricePageState();
}

class _TicketPricePageState extends State<TicketPricePage> {
  // Sample movie data
  final List<Map<String, dynamic>> _movies = [
    {
      'title': 'The Shawshank Redemption',
      'release_date': '1994-09-10',
      'poster_path':
          'https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg',
      'price': 10.0,
    },
    {
      'title': 'The Dark Knight',
      'release_date': '2008-07-18',
      'poster_path':
          'https://image.tmdb.org/t/p/w500/1hRoyzDtpgMU7Dz4JF22RANzQO7.jpg',
      'price': 12.0, // Harga dalam USD
    },
    {
      'title': 'Interstellar',
      'release_date': '2014-11-07',
      'poster_path':
          'https://image.tmdb.org/t/p/w500/rAiYTfKGqDCRIIqo664sY9XZIvQ.jpg',
      'price': 15.0, // Harga dalam USD
    },
  ];

  String _selectedCurrency = 'USD';
  final Map<String, double> _exchangeRates = {
    'USD': 1.0,
    'IDR': 15350.0,
    'EUR': 0.93,
    'GBP': 0.82,
    'JPY': 145.0,
    'AUD': 1.47,
  };

  // Fungsi untuk mengonversi harga
  double _convertPrice(double price, String currency) {
    return price * (_exchangeRates[currency] ?? 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Convert to:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: _selectedCurrency,
                  items: _exchangeRates.keys.map((String currency) {
                    return DropdownMenuItem<String>(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCurrency = newValue ?? 'USD';
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final movie = _movies[index];
                final convertedPrice =
                    _convertPrice(movie['price'], _selectedCurrency);
                return ListTile(
                  title: Text(movie['title']),
                  subtitle: Text(
                      'Release Date: ${movie['release_date']}\nPrice: ${convertedPrice.toStringAsFixed(2)} $_selectedCurrency'),
                  leading: Image.network(
                    movie['poster_path'],
                    width: 50,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
