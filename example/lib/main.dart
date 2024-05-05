import 'package:example/example_candidate_model.dart';
import 'package:example/example_card.dart'; // Assuming this is your card widget
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:audioplayers/audioplayers.dart';
import 'API.dart';
import 'dart:convert';
import 'package:process_run/shell.dart';
import 'dart:io';
import 'package:integration_test/integration_test_driver.dart';
import 'sanatci_secme.dart' as sanatci_sec;
import 'choose_photo.dart' as foto_yukle;
var host="http://192.168.1.143:";
var shell=Shell(workingDirectory: '/home');
var loadedd_data;
var loadeddd_data;
var loaded_data;
var Data;
var sanatcilar="2pac,Eminem";
var url=Uri.parse(host+"5001/oneri_al?sanatcilar=2Pac,Eminem");
var candidates="";
var atlanacak=false;
Future<Map<String,dynamic>> get_data() async{
  Data = await Getdata(url);

  loadedd_data = jsonDecode(Data);

  return loadedd_data;

}

Future<Map<String,dynamic>> get_and_give_data() async{

  Data = await Getdata(url);

  loadedd_data = jsonDecode(Data);

  return loadedd_data;
}

void oneriye_gec()async{
  loadeddd_data= await get_data();
  debugPrint("ADS"+[1,2,3].toString());


}

void main() async{

  //await integrationDriver();
  //await Process.run('sudo', ['python','-version']);


  //var result=await Process.start('asd.exe',[]);
  debugPrint("AAFSASF");
  loaded_data= await get_data();

  runApp(MyApp());


}
class ASDASD extends StatelessWidget {
  late String ham_metin;
  //ASDASD({ham_metin});
  //sanatcilar=ham_metin;
  ASDASD(ham_metin){

    //await integrationDriver();
    //await Process.run('sudo', ['python','-version']);

    debugPrint(ham_metin);
    sanatcilar=ham_metin;
    main();
    //var result=await Process.start('asd.exe',[]);
    /*debugPrint("AAFSASF");
    loadeddd_data= await get_data();

    runApp(MyApp());*/


  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      home: Example(),
    );
  }
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(


        home: Example(),
    );
  }
}

class AppBarExample extends StatefulWidget {
  const AppBarExample({Key? key}) : super(key: key);

  @override
  State<AppBarExample> createState() => _AppBarExampleState();
}
class Example extends StatefulWidget {
  //String? ham_metin;
  //Example({ham_metin});



  @override
  State<Example> createState() => _ExamplePageState();
}
var loaded_real_data;
class ExampleApp extends StatelessWidget{
  //String? ham_metin;
  //ExampleApp({String? ham_metin});

  

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Example(),
    );
  }
}
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
      home: const AppBarExample(),
    );
  }
}


class _ExamplePageState extends State<Example> {
  //String? ham_metin;

  //_ExamplePageState({String? ham_metin});
  
  final CardSwiperController controller = CardSwiperController();

  //late var loaded_real_data=jsonDecode(ham_metin.toString());
  var cevaplar=[];

  // Use the `newCandidates` list from example_candidate_model.dart

  late List<ExampleCandidateModel> newCandidatess=loaded_data["Onerilen"].map<ExampleCandidateModel>((data) {
    return ExampleCandidateModel(
      name: data[0],
      job: data[1],
      imagePath: 'assets/${data[0]}/${data[0]}.png',
      musicPath:
      "assets/${data[0]}/${data[1]}.wav", // Adjusted to include music path
    );
  }).toList();

  late final cards = newCandidatess.map(ExampleCard.new).toList();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }



  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: CardSwiper(
                controller: controller,
                cardsCount: cards.length,
                onSwipe: _onSwipe,
                onUndo: _onUndo,
                numberOfCardsDisplayed: 3,
                backCardOffset: const Offset(40, 40),
                padding: const EdgeInsets.all(24.0),
                cardBuilder: (
                  context,
                  index,
                  horizontalThresholdPercentage,
                  verticalThresholdPercentage,
                ) =>
                    cards[index],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: () => controller.swipe(CardSwiperDirection.left),
                    child: const Icon(Icons.heart_broken),
                  ),
                  FloatingActionButton(
                    onPressed: controller.undo,
                    child: const Icon(Icons.rotate_left),
                  ),
                  /*FloatingActionButton(
                    onPressed: () => controller.swipe(CardSwiperDirection.top),
                    child: const Icon(Icons.keyboard_arrow_up),
                  ),
                  FloatingActionButton(
                    onPressed: () =>
                        controller.swipe(CardSwiperDirection.bottom),
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),*/
                  FloatingActionButton(
                    onPressed: () =>
                        controller.swipe(CardSwiperDirection.right),
                    child: const Icon(Icons.favorite),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) async{
    cevaplar.add(direction.name=="right" ? 1 : -1);
    if(currentIndex==0){
      //url=Uri.parse(host+"/oneri_analiz?listeler=["+loaded_data['Onerilen'].toString()+","+ loaded_data['Tum sarkilar'].toString()+","+cevaplar.toString()+"]");
      atlanacak=true;
      host="http://192.168.1.143:5000";

      var asd='['+jsonEncode(loaded_data['Onerilen'])+','+jsonEncode(loaded_data['Tum sarkilar'])+','+jsonEncode(cevaplar)+']';

      url=Uri.parse(host+"/oneri_analiz?listeler="+asd);

      var asdd=await get_data();
      var aabb=jsonEncode(asdd);
      Navigator.push(context, MaterialPageRoute(builder: (context) => foto_yukle.ASDASDA(aabb)));


    }

    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    debugPrint('${cevaplar}');
    //var data=get_data();


    debugPrint('${cards[previousIndex].candidate.name}');

    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    cevaplar.removeAt(cevaplar.length-1);
    debugPrint('${cevaplar}');
    return true;
  }
}

  class _AppBarExampleState extends State<AppBarExample> {
  bool shadowColor = false;
  double? scrolledUnderElevation;
  List<int> selectedIndexes = [];
  List<String> selectedImageNames = []; // Store the selected image names
  void oneri_gec(){
    final route=MaterialPageRoute(builder: (context) => ExampleApp());
    Navigator.pushAndRemoveUntil(context, route, (route) => false);

  }
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
                    : () {

                  setState(() {
                    if (shadowColor){
                      setState(() {
                        print("asd");
                      });


                    }
                  });
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