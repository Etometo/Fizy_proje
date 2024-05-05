
class ExampleCandidateModel {
  final String name;
  final String job;
  final String imagePath;
  final String musicPath; // New field for storing the path to the music file

  ExampleCandidateModel({
    required this.name,
    required this.job,
    required this.imagePath,
    required this.musicPath, // Updated constructor to include musicPath
  });
}
class candidate_transform{
  late Map<String,dynamic> data;
  List<ExampleCandidateModel> transform(data){

    return data.map((data) {
      return ExampleCandidateModel(
        name: data[0],
        job: data[1],
        imagePath: 'assets/${data[0]}/${data[0]}.png',
        musicPath:
        "assets/${data[0]}/${data[1]}.wav", // Adjusted to include music path
      );
    }).toList();
  }
}
final List<List<String>> newData = [
  ['Eminem', 'Without Me'], // Added music file names
  ['Selena Gomez', 'Wolver'],
  ['Kiss', "I Was Made For Lovin' You"],
  ['2Pac', 'Hit Em Up']
];

/*final List<ExampleCandidateModel> newCandidates = newData.map((data) {
  return ExampleCandidateModel(
    name: data[0],
    job: data[1],
    imagePath: 'assets/${data[0]}/${data[0]}.png',
    musicPath:
        "assets/${data[0]}/${data[1]}.wav", // Adjusted to include music path
  );
}).toList();*/

// Function to play music
void playMusic(String musicPath) {
  // Code to play music from the given path
}

// Example usage:
/*void main() {
  // Play music for each candidate
  for (var candidate in newCandidates) {
    playMusic(candidate.musicPath);
  }
}*/
