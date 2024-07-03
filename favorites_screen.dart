import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteItems;

  const FavoritesScreen({Key? key, required this.favoriteItems})
      : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late List<Map<String, dynamic>> _favoriteItems;

  @override
  void initState() {
    super.initState();
    _favoriteItems = widget.favoriteItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: _favoriteItems.length,
        itemBuilder: (context, index) {
          final item = _favoriteItems[index];
          return ListTile(
            leading: Image.network(
              item['imagePath'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(item['title']),
            subtitle: Text(item['description']),
            onTap: () {
              // Favori öğeye tıklandığında işlenecek işlemler buraya yazılabilir
            },
          );
        },
      ),
    );
  }
}
