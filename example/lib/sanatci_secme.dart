import 'package:flutter/material.dart';
import 'main.dart' as oneri_begenme;
import 'API.dart';
import 'dart:convert';

final List<List<String>> newData = [
  ['2Pac'], // Added music file names
  ['Eminem'],
  ['Kiss'],
  ['Selena Gomez'],
  ['2Pac'], // Added music file names
  ['Eminem'],
  ['Kiss'],
  ['Selena Gomez']
];
var host="http://192.168.1.143:5001";
var loadedd_data;
var loadeddd_data;
var loaded_data;
var Data;
var secilenler;
var url=Uri.parse(host+"/oneri_al?sanatcilar="+secilenler);
Future<Map<String,dynamic>> get_data() async{
  url=Uri.parse(host+"/oneri_al?sanatcilar="+secilenler);
  Data = await Getdata(url);


  Data=Data.toString();
  loaded_data=Data;


  return jsonDecode(Data);
}
void main() => runApp(const AppBarApp());

class AppBarApp extends StatelessWidget {
  const AppBarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xff6750a4)),
        useMaterial3: true,
      ),
      home: const AppBarExample()
    );
  }
}

class AppBarExample extends StatefulWidget {
  const AppBarExample({Key? key}) : super(key: key);

  @override
  State<AppBarExample> createState() => _AppBarExampleState();
}

class _AppBarExampleState extends State<AppBarExample> {
  bool shadowColor = false;
  double? scrolledUnderElevation;
  List<int> selectedIndexes = [];
  List<String> selectedImageNames = []; // Store the selected image names

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar Demo'),
        scrolledUnderElevation: scrolledUnderElevation,
        shadowColor: shadowColor ? Theme.of(context).colorScheme.shadow : null,
      ),
      body: GridView.builder(
        itemCount: newData.length,
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0, // Changed to make it square
          mainAxisSpacing: 10.0, // Spacing between items vertically
          crossAxisSpacing: 10.0, // Spacing between items horizontally
        ),
        itemBuilder: (BuildContext context, int index) {
          final String imageName = newData[index][0];
          final bool isSelected = selectedIndexes.contains(index);
          return GestureDetector(
            onTap: () {
              setState(() {
                if (selectedIndexes.contains(index)) {
                  selectedIndexes.remove(index);
                  selectedImageNames
                      .remove(imageName); // Remove the deselected image name
                } else {
                  selectedIndexes.add(index);
                  selectedImageNames
                      .add(imageName); // Add the selected image name
                  if (selectedIndexes.length >= 3) {
                    shadowColor =
                        true; // Activate shadow color if at least 3 items are selected
                  }
                }
              });
              if (selectedImageNames.isNotEmpty) {
                print(
                    selectedImageNames); // Print the list of selected image names
              }
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Colors.yellow : Colors.transparent,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ClipRRect(
                // Clip the image to make it circular
                borderRadius: BorderRadius.circular(10.0), // make it square
                child: Image.asset(
                  'assets/$imageName.png',
                  width: isSelected ? 200 : 160, // Updated width
                  height: isSelected ? 200 : 160, // Updated height
                  fit: BoxFit.cover, // fill the square
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,
            alignment: MainAxisAlignment.center,
            overflowSpacing: 5.0,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: selectedIndexes.length < 3
                    ? null
                    : () async{
                  secilenler=selectedImageNames.toString();
                  secilenler=secilenler.replaceAll('[','');
                  secilenler=secilenler.replaceAll(']','');
                  secilenler=secilenler.replaceAll(', ',',');

                  loadedd_data=await get_data();

                  Navigator.push(context, MaterialPageRoute(builder: (context) => oneri_begenme.ASDASD(loaded_data)));
                      },
                icon: Icon(
                  Icons.visibility,
                ),
                label: const Text('shadow color'),
              ),
              const SizedBox(width: 5),
              ElevatedButton(
                onPressed: () {
                  if (scrolledUnderElevation == null) {
                    setState(() {
                      // Default elevation is 3.0, increment by 1.0.
                      scrolledUnderElevation = 4.0;
                    });
                  } else {
                    setState(() {
                      scrolledUnderElevation = scrolledUnderElevation! + 1.0;
                    });
                  }
                },
                child: Text(
                  'scrolledUnderElevation: ${scrolledUnderElevation ?? 'default'}',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final List<String> selectedImageNames;

  SecondPage(this.selectedImageNames);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Images'),
      ),
      body: ListView.builder(
        itemCount: selectedImageNames.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(selectedImageNames[index]),
          );
        },
      ),
    );
  }
}
