import 'package:flutter/material.dart';
import 'package:flutter_application_1/firestore_service.dart';
import 'package:flutter_application_1/artists_screen.dart';
import 'package:flutter_application_1/artworks_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: FirestoreService()
          .getFavoriteItems(), // Firestore'dan favori öğeleri almak için kullanılan metodu çağır
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Map<String, dynamic>> favoriteItems = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text('Favorites'),
            ),
            body: ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                if (favoriteItems[index]['type'] == 'artist') {
                  return ListTile(
                    leading: Image.network(
                      favoriteItems[index]['imagePath'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(favoriteItems[index]['title']),
                    subtitle: Text(favoriteItems[index]['description']),
                    onTap: () {
                      // Navigate to artist detail page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArtistDetailPage(
                            artist: favoriteItems[index],
                          ),
                        ),
                      );
                    },
                  );
                } else if (favoriteItems[index]['type'] == 'artwork') {
                  return ListTile(
                    leading: Image.network(
                      favoriteItems[index]['imagePath'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(favoriteItems[index]['title']),
                    subtitle: Text(favoriteItems[index]['description']),
                    onTap: () {
                      // Navigate to artwork detail page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArtworkDetailPage(
                            artwork: favoriteItems[index],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          );
        }
      },
    );
  }
}
