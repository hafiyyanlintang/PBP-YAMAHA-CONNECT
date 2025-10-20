
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Dealer {
  final String name;
  final String address;
  final LatLng location;

  Dealer({required this.name, required this.address, required this.location});
}

class DealerPage extends StatefulWidget {
  @override
  _DealerPageState createState() => _DealerPageState();
}

class _DealerPageState extends State<DealerPage> {
  final List<Dealer> dealers = [
    Dealer(name: "Dealer Yamaha 1", address: "Jl. Pahlawan No. 1, Jakarta", location: LatLng(-6.2088, 106.8456)),
    Dealer(name: "Dealer Yamaha 2", address: "Jl. Sudirman No. 2, Bandung", location: LatLng(-6.9175, 107.6191)),
    Dealer(name: "Dealer Yamaha 3", address: "Jl. Diponegoro No. 3, Surabaya", location: LatLng(-7.2575, 112.7521)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dealer Locations"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(-6.9175, 107.6191),
                zoom: 7.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: dealers.map((dealer) {
                    return Marker(
                      width: 80.0,
                      height: 80.0,
                      point: dealer.location,
                      builder: (ctx) => GestureDetector(
                        onTap: () {
                          _showDealerInfo(context, dealer);
                        },
                        child: Icon(Icons.location_on, color: Colors.red, size: 40.0),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: dealers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(dealers[index].name),
                  subtitle: Text(dealers[index].address),
                  onTap: () {
                    _showDealerInfo(context, dealers[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDealerInfo(BuildContext context, Dealer dealer) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(dealer.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Text(dealer.address),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to detail page or do something else
                  Navigator.pop(context);
                },
                child: Text("View Details"),
              )
            ],
          ),
        );
      },
    );
  }
}
