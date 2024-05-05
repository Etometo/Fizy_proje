import 'package:example/example_candidate_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:external_path/external_path.dart';
import 'dart:io';
import 'API.dart';
import 'dart:convert';
var file_path='D:\\androidstudioprojeler\\olmayan\\example\\';
var host="http://192.168.1.143:";
var url =Uri.parse(host+"5002/resim_analizi?df_and_path");
var loadedd_data;
var loaded_data;
var Data;
Future<Map<String,dynamic>> get_data() async{
  Data = await Getdata(url);

  loadedd_data = jsonDecode(Data);

  return loadedd_data;

}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //var pathh = (await ExternalPath.getExternalStorageDirectories());


  runApp(MyApp());
}
class ASDASDA extends StatelessWidget {
  String? metin;
  ASDASDA(metin){
    debugPrint(this.metin);
    loaded_data= jsonDecode(metin);
    main();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
      ),
      home: Home(),
    );
  }
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? selectedImagePath;
  final List<String> assetImages = [
    'assets/image1.png',
    'assets/image2.png',
    'assets/image3.png',
    'assets/image4.png',
  ];
  late List<dynamic> newData;
  bool showList = false; // Bu değişken kayar yerin görünürlüğünü kontrol eder

  void choosePhoto(BuildContext context) {
    setState(() {
      showList = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selectedImagePath != null)
              SizedBox(
                height: 250,
                width: 250,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      selectedImagePath!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            else
              Icon(
                Icons.account_circle,
                size: 250,
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Choose Profile Photo'),
                      content: SingleChildScrollView(
                        child: Column(
                          children: List.generate(assetImages.length, (index) {
                            return GestureDetector(
                              onTap: () async{
                                debugPrint(assetImages[index]);
                                url=Uri.parse(host+"5002/resim_analizi?df_and_path="+"["+jsonEncode(loaded_data["İhtimaller dataframe:"])+","+jsonEncode(loaded_data["Columnlar:"])+","+jsonEncode(file_path+assetImages[index])+"]");
                                var got_data=await get_data();
                                newData=got_data["Liste:"];
                                setState(() {


                                  selectedImagePath = assetImages[
                                      index]; // Seçilen resmin yolunu saklayalım
                                  showList = true;

                                });
                                Navigator.of(context).pop();
                              },
                              child: ListTile(
                                leading: Image.asset(
                                  assetImages[index],
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(assetImages[index].split('/').last),
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text('Choose Profile Photo'),
            ),
            SizedBox(height: 20),
            if (showList)
              Expanded(
                child: ListView.builder(
                  itemCount: newData.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(newData[index][0]),
                      onTap: () {
                        print('Seçilen isim: ${newData[index][0]}');
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
