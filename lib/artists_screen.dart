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

  @override
  void initState() {
    super.initState();
    _loadArtists();
  }

  void _loadArtists() async {
    _artistsFuture = _firestoreService.getArtists();
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
                      artists[index]
                          ['imagePath'], // Firestore'dan gelen resim yolu
                      fit: BoxFit.cover,
                    ),
                    footer: GridTileBar(
                      backgroundColor: Colors.black45,
                      title: Text(artists[index]
                          ['name']), // Firestore'dan gelen sanatçı adı
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
        title: Text(artist['name']), // Firestore'dan gelen sanatçı adı
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              artist['imagePath'], // Firestore'dan gelen resim yolu
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              artist['description'], // Firestore'dan gelen sanatçı açıklaması
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
