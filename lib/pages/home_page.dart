import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/pages/feedback_page.dart';
import 'package:movie_app/pages/profile_page.dart';
import 'package:movie_app/pages/ticket_price_page.dart';
import 'package:movie_app/pages/timezone_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<dynamic> _movies = [];

  @override
  void initState() {
    super.initState();
    _getNowPlayingMovies();
  }

  // Fungsi untuk mengambil data now playing movies dari API
  Future<void> _getNowPlayingMovies() async {
    final token = dotenv.env['API_TOKEN']; // Mengambil token dari .env
    if (token == null) {
      throw Exception('Token is not available!');
    }

    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&with_release_type=2|3&release_date.gte={min_date}&release_date.lte={max_date}'),
      headers: {'Authorization': 'Bearer $token', 'accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _movies = data['results'];
      });
    } else {
      throw Exception('Failed to load movies');
    }
  }

  // Fungsi untuk mengganti halaman berdasarkan BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // list pages
  final List<Widget> _pages = [
    HomePage(),
    TicketPricePage(),
    TimezonePage(),
    FeedbackPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: _currentIndex == 0 ? _buildHomePage() : _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Ticket'),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule), label: 'Schedule'),
          BottomNavigationBarItem(
              icon: Icon(Icons.feedback), label: 'Feedback'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // Menampilkan movie yang sedang tayang
  Widget _buildHomePage() {
    if (_movies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: _movies.length,
      itemBuilder: (context, index) {
        final movie = _movies[index];
        return ListTile(
          title: Text(movie['title']),
          subtitle: Text(movie['release_date']),
          leading: Image.network(
            'https://image.tmdb.org/t/p/w500/${movie['poster_path']}',
            width: 50,
            height: 75,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
