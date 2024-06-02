import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_application_1/models.dart';
import 'package:flutter_application_1/favorites_screen.dart'
    as fav_screen; // Favoriler ekranı dosya yolu
import 'log_out_screen.dart'; // Çıkış yap ekranı dosya yolu
import 'package:flutter_application_1/artworks_screen.dart'; // Sanat eserleri ekranı dosya yolu
import 'package:flutter_application_1/artists_screen.dart'; // Sanatçılar ekranı dosya yolu

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  final _controller = PageController();

  int currentIndex = 0;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: isSelected
            ? FloatingActionButton(
                backgroundColor: Colors.deepPurple,
                onPressed: () {},
                child: const Icon(Icons.arrow_forward),
              )
            : null,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "HELLO",
            style: TextStyle(
                color: Color(0xfffdfdfd),
                fontSize: 24,
                fontWeight: FontWeight.w600,
                letterSpacing: 1),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  child: const Text('Favorites'),
                  onTap: () {
                    Future.delayed(
                      const Duration(milliseconds: 1),
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => fav_screen.FavoritesScreen(),
                        ),
                      ),
                    );
                  },
                ),
                PopupMenuItem(
                  child: const Text('Log Out'),
                  onTap: () {
                    Future.delayed(
                      const Duration(milliseconds: 1),
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LogOutScreen(
                            controller: _controller,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                PopupMenuItem(
                  child: const Text('Artworks'),
                  onTap: () {
                    Future.delayed(
                      const Duration(milliseconds: 1),
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArtworksScreen(),
                        ),
                      ),
                    );
                  },
                ),
                PopupMenuItem(
                  child: const Text('Artists'),
                  onTap: () {
                    Future.delayed(
                      const Duration(milliseconds: 1),
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ArtistsScreen(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(models[currentIndex].imgAssetAddress),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.darken),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.zero,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 500,
                    child: PageView.builder(
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      controller: _controller,
                      itemCount: models.length,
                      itemBuilder: (BuildContext context, int index) {
                        currentIndex = index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected == false) {
                                isSelected = true;
                              } else {
                                isSelected = false;
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 30, right: 30, bottom: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white,
                                  border: isSelected
                                      ? Border.all(
                                          width: 4, color: Colors.deepPurple)
                                      : null),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              models[index].imgAssetAddress),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    margin: const EdgeInsets.all(10),
                                    height: MediaQuery.of(context).size.height /
                                        2.4,
                                  ),
                                  Text(
                                    models[index].city,
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      models[index].description,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: models.length,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
