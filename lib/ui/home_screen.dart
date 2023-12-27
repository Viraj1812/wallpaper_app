import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/constants/list_of_images.dart';
import 'package:wallpaper_app/ui/set_wallpaper.dart';
import 'package:wallpaper_app/widgets/cat_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String cat = "Nature";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
            'Wallpaper App',
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          backgroundColor: Colors.white),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: category.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                    categoryName: category[index],
                    isSelected: cat == category[index],
                    onTap: () {
                      setState(() {
                        cat = category[index];
                      });
                    });
              },
            ),
          ),
          const Divider(
            height: 0.5,
            color: Colors.grey,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.5,
                ),
                itemCount: wallpapers[cat]?.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SetWallpaper(
                          imageUrl: wallpapers[cat]?[index] ?? '',
                          cat: cat,
                          images: wallpapers[cat],
                        ),
                      )),
                  child: Hero(
                    tag: wallpapers[cat]?[index] ?? 0,
                    child: Container(
                      color: Colors.white30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        // child: Image.network(
                        //   wallpapers[cat]?[index] ?? '',
                        //   fit: BoxFit.cover,
                        // ),
                        child: CachedNetworkImage(
                          imageUrl: wallpapers[cat]?[index] ?? '',
                          placeholder: (context, url) => const SizedBox(
                            height: 10.0,
                            width: 10.0,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
