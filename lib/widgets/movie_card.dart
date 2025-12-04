import 'package:flutter/material.dart';
import 'package:cine_hub/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final double width;
  final double height;

  const MovieCard({
    Key? key,
    required this.movie,
    this.width = 120,
    this.height = 180,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showMovieDetails(context),
      child: Container(
        width: width,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: width,
                height: height,
                color: const Color(0xFF2A2A3C),
                child: movie.posterPath != null
                    ? Image.network(
                        movie.posterUrl,
                        width: width,
                        height: height,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.movie, size: 40, color: Colors.grey),
                          );
                        },
                      )
                    : const Center(
                        child: Icon(Icons.movie, size: 40, color: Colors.grey),
                      ),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: width,
              child: Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, color: Color(0xFFF5C518), size: 12),
                const SizedBox(width: 4),
                Text(
                  movie.voteAverage.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMovieDetails(BuildContext context) {
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
