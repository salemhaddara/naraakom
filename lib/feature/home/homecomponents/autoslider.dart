import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:naraakom/core/widgets/text700normal.dart';
import 'package:naraakom/feature/home/homecomponents/sliderbutton.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../config/theme/colors.dart';

class AutoSlider extends StatefulWidget {
  const AutoSlider({super.key});

  @override
  _AutoSliderState createState() => _AutoSliderState();
}

class _AutoSliderState extends State<AutoSlider> {
  List<ImageAd> images = [];
  var isvisible = true;
  int _currentIndex = 0;

  @override
  void initState() {
    fetchImageUrlsFromDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isvisible,
      child: AspectRatio(
        aspectRatio: 11 / 4,
        child: CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: false,
            viewportFraction: 0.90,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: images.map((image) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 0),
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                        child: Stack(
                          children: <Widget>[
                            // Background Image
                            Image.asset(
                              image.image,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),

                            Positioned(
                              top: 20,
                              left: 20,
                              child: SizedBox(
                                width: 200,
                                child: text700normal(
                                  text: 'The Best Consultant for your Life',
                                  fontsize: 18,
                                  color: white,
                                ),
                              ),
                            ),

                            Positioned(
                                bottom: 20, left: 20, child: sliderbutton()),

                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: AnimatedSmoothIndicator(
                                  activeIndex: _currentIndex,
                                  count: 3,
                                  effect: ExpandingDotsEffect(
                                    offset: 5,
                                    dotHeight: 8,
                                    dotWidth: 8,
                                    dotColor: lightcyan,
                                    activeDotColor: white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void fetchImageUrlsFromDatabase() async {
    images.add(ImageAd(
      'assets/images/sliderback.png',
      'assets/images/sliderback.png',
      'The Best Consultant for your Life',
      'Explore Now',
    ));
    images.add(ImageAd(
      'assets/images/sliderback.png',
      'assets/images/sliderback.png',
      'The Best Consultant for your Life',
      'Explore Now',
    ));
    images.add(ImageAd(
      'assets/images/sliderback.png',
      'assets/images/sliderback.png',
      'The Best Consultant for your Life',
      'Explore Now',
    ));
  }
}

Future<void> _launchUrl(String url) async {}

class ImageAd {
  String link;
  String image;
  String text;
  String buttontext;
  ImageAd(this.link, this.image, this.text, this.buttontext);
}
