import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class ProfileItem {
  final int id;
  final String fullName;
  final String phone;
  final String address;
  final DateTime birthdate;

  ProfileItem({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.address,
    required this.birthdate,
  });
}

class EditProfileBody extends StatefulWidget {
  final String userId;
  final String accountId;
  EditProfileBody({Key? key, required this.userId, required this.accountId})
      : super(key: key);

  @override
  _EditProfileBodyState createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<EditProfileBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  String phoneError = ''; // New
  String? accountId;
  String? _selectedGenderString;
  File? _profileImage;
  final ImagePicker imagePicker = ImagePicker();
  DateTime? _selectedBirthday; // New
  AuthService authService = AuthService();
  DateTime _birthday = DateTime(2000, 1, 1);
  @override
  void initState() {
    super.initState();
    _loadUserProfileData(widget.userId);
  }

  Future<void> _loadUserProfileData(String userId) async {
    Map<String, dynamic>? userProfile =
        await authService.fetchTechProfile(userId);

    if (userProfile != null) {
      final Map<String, dynamic> data = userProfile['data'];
      setState(() {
        _nameController.text = data['fullname'] ?? '';
        _phoneController.text = data['phone'] ?? '';
        _addressController.text = data['address'] ?? '';

        // Retrieve and set the gender from the profile data
        final String? genderString = data['sex'];
        if (genderString != null) {
          _selectedGenderString = genderString;
        }
        String? birthdateString = data['birthdate'];
        if (birthdateString != null) {
          _birthday = DateTime.parse(birthdateString);
          _birthdayController.text = DateFormat('dd/MM/yyyy').format(_birthday);
        }
      });
    }
  }

  Future<void> updateProfile(
    String userId,
    String accountId,
    String name,
    String phone,
    String address,
    String birthdate,
    // Change the parameter type to DateTime
    String sex,
  ) async {
    final requestBody = {
      'id': userId,
      'accountId': accountId,
      'fullname': name,
      'phone': phone,
      'address': address,
      'sex': sex,
      'birthdate': birthdate,

      // Use the formatted birthdate string
    };

    final response = await http.put(
      Uri.parse(
          'https://rescuecapstoneapi.azurewebsites.net/api/Technician/Update'),
      headers: {
        'Content-Type': 'application/json-patch+json',
      },
      body: jsonEncode(requestBody),
    );

    print(response.statusCode);
    final List userData = [userId, accountId, name, phone, address, sex];
    print(userData);

    if (response.statusCode == 200) {
      // Update the state with the updated profile data
      setState(() {
        _nameController.text = name;
        _phoneController.text = phone;
        _addressController.text = address;
        _selectedGenderString = sex;
      });

      // Display a success message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    } else {
      // The profile update failed
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

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

  // Future<void> uploadAndSaveProfile() async {
  //   String selectedGender = _selectedGenderString ?? '';
  //   String formattedBirthdate = DateFormat('yyyy-MM-dd').format(_birthday);
  //   if (_profileImage != null) {
  //     String downloadURL =
  //         await authService.uploadImageToFirebase(_profileImage!);
  //     if (downloadURL != null) {
  //       // Update the profile with the download URL
  //       await updateProfile(
  //         widget.userId,
  //         widget.accountId,
  //         _nameController.text,
  //         _phoneController.text,
  //         _addressController.text,
  //         formattedBirthdate,
  //         selectedGender,
  //         // Pass the download URL to updateProfile
  //       );
  //     }
  //   } else {
  //     // Handle the case where no image was selected
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
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
                  'Thông tin cá nhân',
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
                    labelText: 'Tên đầy đủ',
                    prefixIcon: Icon(Icons.person),
                  ),
                  style: TextStyle(fontFamily: 'Montserrat'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hãy nhập họ tên đầy đủ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Số điện thoại',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  style: TextStyle(fontFamily: 'Montserrat'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hãy nhập số điện thoại.';
                    }
                    if (value.length != 10) {
                      return 'Số điện thoại phải bao gồm 10 số.';
                    }
                    // You can add more phone number validation here if needed.
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Địa chỉ',
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  style: TextStyle(fontFamily: 'Montserrat'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hãy nhập địa chỉ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Giới tính',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
                Row(
                  children: [
                    Radio(
                      activeColor: FrontendConfigs.kIconColor,
                      value: 'Nam',
                      groupValue: _selectedGenderString,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedGenderString = value;
                        });
                      },
                    ),
                    Text('Nam', style: TextStyle(fontFamily: 'Montserrat')),
                    Radio(
                      activeColor: FrontendConfigs.kIconColor,
                      value: 'Nữ',
                      groupValue: _selectedGenderString,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedGenderString = value;
                        });
                      },
                    ),
                    Text('Nữ', style: TextStyle(fontFamily: 'Montserrat')),
                  ],
                ),
                Text(
                  'Ngày sinh',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: _birthday,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (selectedDate != null && selectedDate != _birthday) {
                        setState(() {
                          _birthday = selectedDate;
                          _birthdayController.text =
                              DateFormat('dd-MM-yyyy').format(_birthday);
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('dd-MM-yyyy').format(_birthday),
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            FrontendConfigs.kPrimaryColor)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String selectedGender = _selectedGenderString ?? '';
                        String formattedBirthdate =
                            DateFormat('yyyy-MM-dd').format(_birthday);
                        await updateProfile(
                          widget.userId,
                          widget.accountId,
                          _nameController.text,
                          _phoneController.text,
                          _addressController.text,
                          formattedBirthdate,
                          selectedGender,
                        );
                        Navigator.pop(context, 'Profile updated successfully');
                      }
                    },
                    child: Text('Save Profile'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedBirthday ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedBirthday) {
      setState(() {
        _selectedBirthday = pickedDate;
        _birthdayController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }
}
