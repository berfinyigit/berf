import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_application_1/models.dart';
import 'package:flutter_application_1/favorites_screen.dart' as fav_screen;
import 'package:flutter_application_1/artworks_screen.dart';
import 'package:flutter_application_1/artists_screen.dart';
import 'package:flutter_application_1/profile_screen.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback onProfileTap;
  final VoidCallback onFavoritesTap;
  final VoidCallback onArtworksTap;
  final VoidCallback onArtistsTap;

  const CustomDrawer({
    required this.onProfileTap,
    required this.onFavoritesTap,
    required this.onArtworksTap,
    required this.onArtistsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 139, 159, 201),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: onProfileTap,
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: onFavoritesTap,
          ),
          ListTile(
            leading: const Icon(Icons.art_track),
            title: const Text('Artworks'),
            onTap: onArtworksTap,
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Artists'),
            onTap: onArtistsTap,
          ),
        ],
      ),
    );
  }
}

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
        drawer: CustomDrawer(
          onProfileTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          },
          onFavoritesTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const fav_screen.FavoritesScreen(
                  favoriteItems: [],
                ),
              ),
            );
          },
          onArtworksTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ArtworksScreen()),
            );
          },
          onArtistsTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ArtistsScreen()),
            );
          },
        ),
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
            "WELCOME TO OUR APP",
            style: TextStyle(
              color: Color.fromARGB(255, 222, 204, 204),
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          centerTitle: true,
          elevation: 0,
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
                                          width: 4,
                                          color: Colors.deepPurple,
                                        )
                                      : null),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            models[index].imgAssetAddress),
                                        fit: BoxFit.cover,
                                      ),
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
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
