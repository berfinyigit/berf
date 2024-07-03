import 'package:flutter/material.dart';
import 'package:flutter_application_1/firestore_service.dart';

class ArtworksScreen extends StatefulWidget {
  const ArtworksScreen({Key? key}) : super(key: key);

  @override
  _ArtworksScreenState createState() => _ArtworksScreenState();
}

class _ArtworksScreenState extends State<ArtworksScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  late Future<List<Map<String, dynamic>>> _artworksFuture;
  List<Map<String, dynamic>> favoriteArtworks = [];

  @override
  void initState() {
    super.initState();
    _loadArtworks();
  }

  void _loadArtworks() async {
    _artworksFuture = _firestoreService.getArtworks();
  }

  bool isFavorite(Map<String, dynamic> artwork) {
    return favoriteArtworks.contains(artwork);
  }

  void toggleFavorite(Map<String, dynamic> artwork) {
    setState(() {
      if (isFavorite(artwork)) {
        favoriteArtworks.remove(artwork);
      } else {
        favoriteArtworks.add(artwork);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artworks'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _artworksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> artworks = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: artworks.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArtworkDetailPage(
                          artwork: artworks[index],
                        ),
                      ),
                    );
                  },
                  child: GridTile(
                    child: Image.network(
                      artworks[index]['imagePath'],
                      fit: BoxFit.cover,
                    ),
                    footer: GridTileBar(
                      backgroundColor: Colors.black45,
                      title: Text(artworks[index]['title']),
                      trailing: IconButton(
                        icon: Icon(
                          isFavorite(artworks[index])
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFavorite(artworks[index])
                              ? Colors.red
                              : Colors.white,
                        ),
                        onPressed: () {
                          toggleFavorite(artworks[index]);
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ArtworkDetailPage extends StatelessWidget {
  final Map<String, dynamic> artwork;

  const ArtworkDetailPage({required this.artwork});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(artwork['title']),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                artwork['imagePath'],
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text(
                artwork['description'],
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
