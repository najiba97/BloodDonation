import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';

class MyLocation extends StatefulWidget {
  @override
  _MyLocationState createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('localiser hopitale'),
        centerTitle: true,
        backgroundColor: Colors.teal[400],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: GoogleMap(
          initialPosition: GeoCoord(33.8869, 9.5375),
          initialZoom: 7,
          markers: {
            Marker(
              GeoCoord(
                36.80501937915626,
                10.157490721668403,
              ),
            ),
            Marker(
              GeoCoord(
                34.74181293757634,
                10.752195633504154,
              ),
            ),
            Marker(
              GeoCoord(
                35.83045969399997,
                10.628166714502356,
              ),
            ),
            Marker(
              GeoCoord(
                36.51422371675938,
                8.759794927644274,
              ),
            ),
            Marker(
              GeoCoord(
                34.42040996066232,
                8.79729720606624,
              ),
            ),
            Marker(
              GeoCoord(
                36.81552388613758,
                10.153516634913396,
              ),
            ),
            Marker(
              GeoCoord(
                36.80239339678542,
                10.161458039659376,
              ),
            ),
            Marker(
              GeoCoord(
                36.802084295508685,
                10.15460620024096,
              ),
            ),
            Marker(
              GeoCoord(
                36.78614087339193,
                10.176757951363342,
              ),
            ),
            Marker(
              GeoCoord(
                36.81472855293355,
                10.101551895732388,
              ),
            ),
            Marker(
              GeoCoord(
                35.77047103137735,
                10.8342374750093,
              ),
            ),
            Marker(
              GeoCoord(
                35.8372312329297,
                10.590598720223202,
              ),
            ),
            Marker(
              GeoCoord(
                35.51024119150173,
                11.03285728226919,
              ),
            ),
            Marker(
              GeoCoord(
                33.33196552161042,
                10.489169228050162,
              ),
            ),
            Marker(
              GeoCoord(
                36.76279220618794,
                9.162467586448722,
              ),
            ),
            Marker(
              GeoCoord(
                37.29619263388031,
                9.876348304768968,
              ),
            ),
            Marker(
              GeoCoord(
                36.59531436397224,
                10.495509044596277,
              ),
            ),
            Marker(
              GeoCoord(
                33.81607119684458,
                11.004028662031361,
              ),
            ),
            Marker(
              GeoCoord(
                35.1750513914527,
                8.794668182500091,
              ),
            ),
            Marker(
              GeoCoord(
                33.718578332035484,
                8.974278827486684,
              ),
            ),
            Marker(
              GeoCoord(
                36.1781483084847,
                8.705299858340288,
              ),
            ),
          },
        ),
      ),
    );
  }
}
