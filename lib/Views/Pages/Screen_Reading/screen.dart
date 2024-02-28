import '../../../Model/random_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarrot_app/ViewModel/dashboard_viewmodel.dart';

class TarotCardPage extends StatefulWidget {
  @override
  _TarotCardPageState createState() => _TarotCardPageState();
}

class _TarotCardPageState extends State<TarotCardPage> {
  List<Widget> images = [];
  late Future<RandomCard> todayCard;

  @override
  void initState() {
    super.initState();
    images.add(_imageContainer()); // Initial empty container for adding new images
  }

  @override
  Widget build(BuildContext context) {
    final dashboardViewModel = Provider.of<DashboardViewModel>(context);
    todayCard = dashboardViewModel.fetchSingleCard();

    return Scaffold(
      appBar: AppBar(title: const Text('Image Adder')),
      body: SingleChildScrollView( // Use SingleChildScrollView for vertical scrolling
        child: Wrap( // Use Wrap to organize images in rows
          alignment: WrapAlignment.spaceEvenly, // Distribute space evenly
          children: images.map((image) => image).toList(),
        ),
      ),
    );
  }

  Widget _imageContainer({String? imagePath}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 100, // Adjust the width to fit three in a row
          height: 200, // Adjusted height for uniformity
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            image: imagePath != null
                ? DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover)
                : null,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        if (imagePath == null)
          IconButton(
            icon: const Icon(Icons.add, size: 30, color: Colors.white), // Adjusted icon size for space
            onPressed: () {
              todayCard.then((card) {
                debugPrint(card.name);
                setState(() {
                  images[images.length - 1] = _imageContainer(
                      imagePath: 'asset/images/${card.nameShort}.jpg'); // Ensure path is correct
                  images.add(_imageContainer()); // Add a new container for the next image
                });
              });
            },
          ),
      ],
    );
  }
}
