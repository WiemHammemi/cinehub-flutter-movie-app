
import 'package:flutter/material.dart';
import 'package:cine_hub/models/movie.dart';
import 'package:cine_hub/services/api_service.dart';
import 'package:cine_hub/widgets/carousel.dart';
import 'package:cine_hub/widgets/movie_card.dart';
import 'package:cine_hub/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  
  List<Movie> nowPlayingMovies = [];
  List<Movie> upcomingMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];
  
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadAllMovies();
  }

  Future<void> _loadAllMovies() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final results = await Future.wait([
        _apiService.getNowPlayingMovies(),
        _apiService.getUpcomingMovies(),
        _apiService.getPopularMovies(),
        _apiService.getTopRatedMovies(),
      ]);

      setState(() {
        nowPlayingMovies = results[0];
        upcomingMovies = results[1];
        popularMovies = results[2];
        topRatedMovies = results[3];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  void _openSearchScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E2C),
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/icons/logo.png',
              height: 30, 
              width: 30,
            ),
            const SizedBox(width: 8), 
            const Text(
              'CinéHub',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE50914),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: _openSearchScreen,
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadAllMovies,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFE50914)))
          : errorMessage.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 60, color: Color(0xFFE50914)),
                      const SizedBox(height: 16),
                      const Text(
                        'Erreur de chargement',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          errorMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _loadAllMovies,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE50914),
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        ),
                        child: const Text('Réessayer'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  color: const Color(0xFFE50914),
                  onRefresh: _loadAllMovies,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icons/stars.png",
                                  height: 35,
                                  width: 35,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "En vedette",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Carousel(movies: nowPlayingMovies),
                        const SizedBox(height: 24),

                        _buildMovieSection(
                          'Au cinéma',
                          nowPlayingMovies,
                          iconPath: 'assets/icons/cinema.png',
                        ),

                        _buildMovieSection(
                          'Prochainement',
                          upcomingMovies,
                          iconPath: 'assets/icons/calender.png'
                        ),

                        _buildMovieSection(
                          'Populaires',
                          popularMovies,
                          iconPath: 'assets/icons/fire.png'
                        ),

                        _buildMovieSection(
                          'Les mieux notés',
                          topRatedMovies,
                          iconPath: 'assets/icons/rate.png'
                        ),
                        
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildMovieSection(String title, List<Movie> movies, {String? iconPath}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              if (iconPath != null) ...[
                Image.asset(
                  iconPath,
                  height: 24,
                  width: 24,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return MovieCard(movie: movies[index]);
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}