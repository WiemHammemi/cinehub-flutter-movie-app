import 'package:flutter/material.dart';
import 'package:cine_hub/models/movie.dart';

class Carousel extends StatelessWidget {
  final List<Movie> movies;

  const Carousel({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const SizedBox(height: 280);
    }

    return SizedBox(
      height: 280,
      child: PageView.builder(
        itemCount: movies.length > 5 ? 5 : movies.length,
        padEnds: false,
        controller: PageController(viewportFraction: 0.9),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () => _showDetails(context, movie),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (movie.backdropPath != null)
                      Image.network(
                        movie.backdropUrl,
                        fit: BoxFit.cover,
                      )
                    else
                      Container(
                        color: const Color(0xFF2A2A3C),
                        child: const Center(
                          child: Icon(Icons.movie, size: 60, color: Colors.grey),
                        ),
                      ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Color(0xFFF5C518), size: 18),
                              const SizedBox(width: 6),
                              Text(
                                movie.voteAverage.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDetails(BuildContext context, Movie movie) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF1E1E2C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (movie.backdropPath != null)
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    movie.backdropUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Color(0xFFF5C518), size: 20),
                        const SizedBox(width: 6),
                        Text(
                          '${movie.voteAverage.toStringAsFixed(1)}/10',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.calendar_today, size: 16, color: Colors.white70),
                        const SizedBox(width: 6),
                        Text(
                          movie.year,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Synopsis',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      movie.overview,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE50914),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Fermer',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

