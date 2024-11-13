import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class VideoDetect extends StatefulWidget {
  const VideoDetect({Key? key}) : super(key: key);

  @override
  _VideoDetectState createState() => _VideoDetectState();
}

class _VideoDetectState extends State<VideoDetect> {
  CameraController? _cameraController;
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    _cameraController = CameraController(
      camera,
      ResolutionPreset.high,
    );

    await _cameraController?.initialize();
    setState(() {});
  }

  Future<void> captureImage() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      _imageFile = await _cameraController?.takePicture();
      setState(() {});
    }
  }

  Future<void> detectAnimals() async {
    if (_imageFile != null) {
      final imageFile = File(_imageFile!.path);
      final result = await detectAnimalsInImage(imageFile);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Detection Result'),
          content: Text(result),
        ),
      );
    }
  }

  Future<String> detectAnimalsInImage(File imageFile) async {
    final url = 'https://api.florence-2.com/v1/animal-detection';
    final apiKey = 'YOUR_API_KEY'; // Replace with your actual API key

    final request = http.MultipartRequest('POST', Uri.parse(url))
      ..headers['Authorization'] = 'Bearer $apiKey'
      ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      return responseBody;
    } else {
      return 'Detection failed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartFarmApp'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_cameraController != null && _cameraController!.value.isInitialized)
              AspectRatio(
                aspectRatio: _cameraController!.value.aspectRatio,
                child: CameraPreview(_cameraController!),
              ),
            if (_imageFile != null) Image.file(File(_imageFile!.path)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 102, 170, 134), // Same color as before
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0), // Rounded corners
                      ),
                    ),
                  ),
                  onPressed: captureImage,
                  child: const Text(
                    'Capture Image',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 102, 170, 134),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  onPressed: detectAnimals,
                  child: const Text(
                    'Detect Animals',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
