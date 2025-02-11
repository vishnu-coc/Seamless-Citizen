import 'dart:io';
import 'dart:convert'; // Import this for JSON decoding
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class IssueForm extends StatefulWidget {
  const IssueForm({super.key});

  @override
  State<IssueForm> createState() => _IssueFormState();
}

class _IssueFormState extends State<IssueForm> {
  LatLng? currentLocation;
  XFile? issuePhoto;
  XFile? panoramaPhoto;
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  late GoogleMapController googleMapController;
  final ImagePicker _picker = ImagePicker();
  bool isIssuePhotoTaken = false;
  bool isPanoramaPhotoTaken = false;
  bool isLocationSet = false;
  bool isAboutFilled = false;
  bool isPhoneFilled = false;
  bool isSubmitting = false;

  final Set<Marker> markers = {};

  Future<void> _pickIssuePhoto() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        issuePhoto = pickedImage;
        isIssuePhotoTaken = true;
      });
    }
  }

  Future<void> _pickPanoramaPhoto() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        panoramaPhoto = pickedImage;
        isPanoramaPhotoTaken = true;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        markers.clear();
        markers.add(Marker(
          markerId: const MarkerId('currentLocation'),
          position: currentLocation!,
        ));
        isLocationSet = true;
      });

      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: currentLocation!, zoom: 14),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get location: $e')),
      );
    }
  }

  bool _areAllFieldsFilled() {
    return isIssuePhotoTaken &&
        isPanoramaPhotoTaken &&
        isLocationSet &&
        isAboutFilled &&
        isPhoneFilled;
  }

  void _resetForm() {
    setState(() {
      issuePhoto = null;
      panoramaPhoto = null;
      currentLocation = null;
      aboutController.clear();
      phoneController.clear();
      isIssuePhotoTaken = false;
      isPanoramaPhotoTaken = false;
      isLocationSet = false;
      isAboutFilled = false;
      isPhoneFilled = false;
      markers.clear();
      isSubmitting = false;
    });
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(target: LatLng(0, 0), zoom: 1),
      ),
    );
  }

  Future<void> submitIssueData({
    required BuildContext context,
    required String aboutIssues,
    required String phone,
    required LatLng lat,
    required File images,
    required File images_360,
  }) async {
    setState(() {
      isSubmitting = true;
    });

    final uploadUrl = Uri.parse(
        'https://seamless-backend-382y.onrender.com/api/uploads/single/reports');

    Future<String?> uploadImage(File imageFile) async {
      var request = http.MultipartRequest('POST', uploadUrl);
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
      ));

      try {
        final response = await request.send();
        if (response.statusCode == 200) {
          final responseBody = await response.stream.bytesToString();
          final jsonResponse = json.decode(responseBody);
          return jsonResponse['imageUrl'];
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Failed to upload image: ${response.statusCode}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading image: $e')),
        );
      }
      return null;
    }

    final imageUrl = await uploadImage(images);
    final image360Url = await uploadImage(images_360);

    if (imageUrl != null && image360Url != null) {
      final reportUrl =
          Uri.parse('https://seamless-backend-382y.onrender.com/api/report');
      final prefs = await SharedPreferences.getInstance();
      final userToken = prefs.getString('user_token') ?? '';

      final requestBody = {
        'about_issues': aboutIssues,
        'phone': phone,
        'lat': lat.latitude.toString(),
        'lng': lat.longitude.toString(),
        'issue_type': "",
        'images': imageUrl,
        'images_360': image360Url,
      };

      try {
        final response = await http.post(
          reportUrl,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $userToken',
          },
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Issue submitted successfully!')),
          );
          _resetForm();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to submit issue: ${response.body}'),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting issue: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to upload images.')),
      );
    }

    setState(() {
      isSubmitting = false;
    });
  }

  @override
  void initState() {
    super.initState();
    aboutController.addListener(() {
      setState(() {
        isAboutFilled = aboutController.text.isNotEmpty;
      });
    });

    phoneController.addListener(() {
      setState(() {
        isPhoneFilled = phoneController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: _pickIssuePhoto,
                    child: const Text("Upload Issue Photo"),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                if (isIssuePhotoTaken)
                  const Icon(Icons.check_circle, color: Colors.green),
              ],
            ),
            if (issuePhoto != null)
              Image.file(File(issuePhoto!.path), height: 100),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: _pickPanoramaPhoto,
                    child: const Text("Capture 360° Photo"),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                if (isPanoramaPhotoTaken)
                  const Icon(Icons.check_circle, color: Colors.green),
              ],
            ),
            if (panoramaPhoto != null)
              Image.file(File(panoramaPhoto!.path), height: 100),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: _getCurrentLocation,
                        child: const Text("Get Current Location"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      if (isLocationSet)
                        const Icon(Icons.check_circle, color: Colors.green),
                      const SizedBox(height: 20),
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: currentLocation == null
                            ? const Center(child: Text("No Location"))
                            : GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: currentLocation!,
                                  zoom: 14,
                                ),
                                markers: markers,
                                onMapCreated: (controller) {
                                  googleMapController = controller;
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: aboutController,
                    decoration: const InputDecoration(
                      labelText: "About the Issue",
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                ),
                if (isAboutFilled)
                  const Icon(Icons.check_circle, color: Colors.green),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                if (isPhoneFilled)
                  const Icon(Icons.check_circle, color: Colors.green),
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _areAllFieldsFilled() && !isSubmitting
                    ? () {
                        submitIssueData(
                          context: context,
                          aboutIssues: aboutController.text,
                          phone: phoneController.text,
                          lat: currentLocation!,
                          images: File(issuePhoto!.path),
                          images_360: File(panoramaPhoto!.path),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _areAllFieldsFilled() && !isSubmitting
                      ? Colors.blue
                      : Colors.grey,
                  foregroundColor: Colors.white,
                ),
                child: isSubmitting
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text("Submit Issue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
