import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:transparent_image/transparent_image.dart';
import 'kite_theme.dart';

class ImageView extends StatefulWidget {
  final List<String> images;
  final String location;

  const ImageView({super.key, required this.images, required this.location});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);
        final decorations = Theme.of(context).extension<AppDecorations>();

    final decorator = DotsDecorator(
      size: const Size.square(10.0),
      activeSize: const Size.square(10.0),
      activeColor: Colors.grey.shade300,
      color: Colors.grey.shade800,
      spacing: const EdgeInsets.all(4.0),
    );
    return Container(decoration: decorations?.quoteBox,
      width: double.infinity,
      height: 300,
      child: ClipRRect(borderRadius: BorderRadius.circular(16),child: 
      Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  fit: BoxFit.contain,
                  image: widget.images[index]);
            },
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
          Positioned(
            bottom: screenSize.size.height * 0.01,
            width: screenSize.size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DotsIndicator(
                  dotsCount: widget.images.length,
                  position: _currentPage,
                  axis: Axis.horizontal,
                  decorator: decorator,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.place_outlined,
                      color: Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.location,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
