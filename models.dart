import 'package:flutter/material.dart';

class Models {
  String imgAssetAddress;
  String city;

  Models({
    required this.city,
    required this.imgAssetAddress,
  });
}

List<Models> models = [
  Models(
    city: "Paris",
    imgAssetAddress: "assets/images/paris.webp",
  ),
  Models(
    city: "London",
    imgAssetAddress: "assets/images/london.jpg",
  ),
  Models(
    city: "Thailand",
    imgAssetAddress: "assets/images/thailand.jpg",
  ),
  Models(
    city: "Brazil",
    imgAssetAddress: "assets/images/brazil.webp",
  ),
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cities'),
        ),
        body: ListView.builder(
          itemCount: models.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 100, // Görüntü yüksekliğini istediğiniz boyuta ayarlayın
              child: Card(
                margin: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9, // İstediğiniz en boy oranı
                      child: Image.asset(
                        models[index].imgAssetAddress,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        models[index].city,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
