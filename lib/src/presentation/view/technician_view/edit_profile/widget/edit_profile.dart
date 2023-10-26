import 'package:CarRescue/src/presentation/elements/app_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileItem {
  final int id;
  final String fullName;
  final String phone;
  final String address;

  ProfileItem({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.address,
  });
}

enum Gender { male, female, other }

class EditProfileBody extends StatefulWidget {
  @override
  _EditProfileBodyState createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<EditProfileBody> {
  final List<ProfileItem> profileInfo = [
    ProfileItem(
      id: 1,
      fullName: 'Hieu Phan',
      phone: '0363235421',
      address: 'FPT',
    ),
    // Add more profile items if needed
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  Gender? _selectedGender; // Store the selected gender

  File? _profileImage; // Store the selected profile image

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        // Update the profile picture with the selected image
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Find the selected profile item by ID (you can replace this logic with your own)
    final selectedProfileItem = profileInfo.firstWhere((item) => item.id == 1);

    // Set the initial values for the text fields
    _nameController.text = selectedProfileItem.fullName;
    _phoneController.text = selectedProfileItem.phone;
    _addressController.text = selectedProfileItem.address;

    // Set the initial value for the gender
    _selectedGender =
        Gender.male; // You can change this to the desired initial value
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 120),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFE0AC69),
                            Color(0xFF8D5524),
                          ],
                        ),
                      ),
                      height: 120,
                    ),
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _profileImage != null
                        ? FileImage(
                            _profileImage!) // Use FileImage for the selected image
                        : AssetImage('assets/images/profile.png')
                            as ImageProvider, // Explicitly cast to ImageProvider
                  ),
                  Positioned(
                    bottom: 60,
                    right: 120,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 20,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        color: Colors.white,
                        onPressed: _pickImage, // Open image picker
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                ),
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  prefixIcon: Icon(Icons.phone),
                ),
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  prefixIcon: Icon(Icons.location_on),
                ),
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
              SizedBox(height: 20),
              Text(
                'Gender',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              Row(
                children: [
                  Radio(
                    value: Gender.male,
                    groupValue: _selectedGender,
                    onChanged: (Gender? value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  Text('Male', style: TextStyle(fontFamily: 'Montserrat')),
                  Radio(
                    value: Gender.female,
                    groupValue: _selectedGender,
                    onChanged: (Gender? value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  Text('Female', style: TextStyle(fontFamily: 'Montserrat')),
                  Radio(
                    value: Gender.other,
                    groupValue: _selectedGender,
                    onChanged: (Gender? value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  Text('Other', style: TextStyle(fontFamily: 'Montserrat')),
                ],
              ),
              Container(
                width: double.infinity,
                child: AppButton(onPressed: () {
                  
                }, btnLabel: "Lưu thông tin"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
