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

  @override
  void initState() {
    super.initState();
    _loadArtworks();
  }

  void _loadArtworks() async {
    _artworksFuture = _firestoreService.getArtworks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artworks'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          ),
        ],
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
                      artworks[index]
                          ['imagePath'], // Firestore'dan gelen resim yolu
                      fit: BoxFit.cover,
                    ),
                    footer: GridTileBar(
                      backgroundColor: Colors.black45,
                      title: Text(artworks[index]
                          ['title']), // Firestore'dan gelen eser başlığı
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
        title: Text(artwork['title']), // Firestore'dan gelen eser başlığı
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              artwork['imagePath'], // Firestore'dan gelen resim yolu
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              artwork['description'], // Firestore'dan gelen eser açıklaması
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
