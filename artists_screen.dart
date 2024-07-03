import 'package:flutter/material.dart';
import 'package:flutter_application_1/firestore_service.dart';

class ArtistsScreen extends StatefulWidget {
  const ArtistsScreen({Key? key}) : super(key: key);

  @override
  _ArtistsScreenState createState() => _ArtistsScreenState();
}

class _ArtistsScreenState extends State<ArtistsScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  late Future<List<Map<String, dynamic>>> _artistsFuture;
  List<Map<String, dynamic>> favoriteArtists = [];

  @override
  void initState() {
    super.initState();
    _loadArtists();
  }

  void _loadArtists() async {
    _artistsFuture = _firestoreService.getArtists();
  }

  bool isFavorite(Map<String, dynamic> artist) {
    return favoriteArtists.contains(artist);
  }

  void toggleFavorite(Map<String, dynamic> artist) {
    setState(() {
      if (isFavorite(artist)) {
        favoriteArtists.remove(artist);
      } else {
        favoriteArtists.add(artist);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artists'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _artistsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> artists = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: artists.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArtistDetailPage(
                          artist: artists[index],
                        ),
                      ),
                    );
                  },
                  child: GridTile(
                    child: Image.network(
                      artists[index]['imagePath'],
                      fit: BoxFit.cover,
                    ),
                    footer: GridTileBar(
                      backgroundColor: Colors.black45,
                      title: Text(artists[index]['name']),
                      trailing: IconButton(
                        icon: Icon(
                          isFavorite(artists[index])
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFavorite(artists[index])
                              ? Colors.red
                              : Colors.white,
                        ),
                        onPressed: () {
                          toggleFavorite(artists[index]);
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

class ArtistDetailPage extends StatelessWidget {
  final Map<String, dynamic> artist;

  const ArtistDetailPage({required this.artist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(artist['name']),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                artist['imagePath'],
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text(
                artist['description'],
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
