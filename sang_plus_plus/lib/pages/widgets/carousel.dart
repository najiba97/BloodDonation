import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MyCaroussel extends StatelessWidget {
  const MyCaroussel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: [
          Container(
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage('assets/slider_one.jpg'),
                    fit: BoxFit.cover)),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage('assets/slider_two.jpg'),
                    fit: BoxFit.cover)),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage('assets/slider_three.jpg'),
                    fit: BoxFit.cover)),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage('assets/slider_four.jpg'),
                    fit: BoxFit.cover)),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage('assets/slider_five.jpg'),
                    fit: BoxFit.cover)),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage('assets/slider_six.gif'),
                    fit: BoxFit.cover)),
          ),
        ],
        options: CarouselOptions(
            height: 180,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8));
  }
}
