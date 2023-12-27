import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/ui/full_image.dart';

class SetWallpaper extends StatelessWidget {
  const SetWallpaper({
    required this.imageUrl,
    required this.images,
    required this.cat,
    super.key,
  });
  final String imageUrl;
  final List<String>? images;
  final String cat;
  @override
  Widget build(BuildContext context) {
    CarouselController controller = CarouselController();
    int curIndex = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          cat,
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            carouselController: controller,
            items: images?.map((item) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullImage(imageUrl: item),
                    ),
                  ),
                  child: Hero(
                    tag: item,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(item),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 400.0,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              viewportFraction: 0.8,
              onPageChanged: (index, reason) => curIndex = index,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {
              setWallpaper(images![curIndex]);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            child: Text(
              'Set Wallpaper',
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Future<void> setWallpaper(String imageurl) async {
    try {
      int location = WallpaperManager.BOTH_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(imageurl);
      bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
      if (result) {
        ScaffoldMessenger(
            child: SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            'Wallpaper Set SuccessFully',
            style: GoogleFonts.montserrat(color: Colors.white),
          ),
        ));
      }
    } catch (e) {
      ScaffoldMessenger(
          child: SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          e.toString(),
          style: GoogleFonts.montserrat(color: Colors.white),
        ),
      ));
    }
  }
}
