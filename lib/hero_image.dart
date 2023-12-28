import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeroImage extends StatefulWidget {
  const HeroImage({Key? key}) : super(key: key);

  @override
  State<HeroImage> createState() => _HeroImageState();
}

class _HeroImageState extends State<HeroImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HeroImageFull(),
              )),
          child: Hero(
            tag: 'hero',
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://bs-uploads.toptal.io/blackfish-uploads/components/seo/content/og_image_file/og_image/1096555/0408-FlutterMessangerDemo-Luke_Social-e8a0e8ddab86b503a125ebcad823c583.png'))),
            ),
          ),
        ),
      ),
    );
  }
}

class HeroImageFull extends StatefulWidget {
  const HeroImageFull({Key? key}) : super(key: key);

  @override
  State<HeroImageFull> createState() => _HeroImageFullState();
}

class _HeroImageFullState extends State<HeroImageFull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
          tag: 'hero',
          child: Image.network(
              'https://bs-uploads.toptal.io/blackfish-uploads/components/seo/content/og_image_file/og_image/1096555/0408-FlutterMessangerDemo-Luke_Social-e8a0e8ddab86b503a125ebcad823c583.png')),
    );
  }
}
