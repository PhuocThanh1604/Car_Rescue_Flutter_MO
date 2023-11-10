import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/models/vehicle_item.dart';
import 'package:CarRescue/src/presentation/elements/custom_appbar.dart';
import 'package:CarRescue/src/presentation/elements/loading_state.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/car_view/car_view.dart';
import 'package:CarRescue/src/utils/api.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ... other necessary imports ...

class UpdateCarScreen extends StatefulWidget {
  final String userId;
  Vehicle? vehicle;
  UpdateCarScreen({super.key, required this.userId, required this.vehicle});
  @override
  _UpdateCarScreenState createState() => _UpdateCarScreenState();
}

class _UpdateCarScreenState extends State<UpdateCarScreen> {
  // ... All your variables ...
  List<int> yearList =
      List.generate(DateTime.now().year - 2010 + 1, (index) => index + 2010)
          .reversed
          .toList();
  final _formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  File? _carRegistrationFontImage;
  File? _carRegistrationBackImage;
  File? vehicleImage;
  String _manufacturer = '';
  String _licensePlate = '';
  String _status = '';
  String _vinNumber = '';
  String _selectedType = '';
  String _color = '';
  int _manufacturingYear = 0;
  bool _isLoading = false;
  bool _isValidate = false;
  final titleStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  final inputDecoration = InputDecoration(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
  );
  void _submitForm() async {
    var uuid = Uuid();
    String randomId = uuid.v4();
    if (_formKey.currentState!.validate()) {
      _showAlertDialog(context);
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      try {
        bool isSuccess = await authService.createCarApproval(randomId,
            rvoid: widget.userId,
            licensePlate: _licensePlate,
            manufacturer: _manufacturer,
            status: _status,
            vinNumber: _vinNumber,
            type: _selectedType,
            color: _color,
            manufacturingYear: _manufacturingYear,
            carRegistrationFontImage: _carRegistrationFontImage!,
            carRegistrationBackImage: _carRegistrationBackImage!,
            vehicleImage: vehicleImage!);

        if (isSuccess) {
          setState(() {
            _isLoading = false;
            Navigator.pop(context, true);
          });

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Thành công',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                content: Text(
                  'Đã lưu thông tin thành công.Vui lòng chờ quản lí xác nhận',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Đóng'),
                  ),
                ],
              );
            },
          );
        } else {
          // Handle unsuccessful API response, e.g., show a snackbar with an error message.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Failed to create car approval. Please try again.')),
          );
        }
      } catch (error) {
        Navigator.pop(context, false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred. Please try again.')),
        );
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: customAppBar(context, text: 'Đăng kí xe mới', showText: true),
        body:
            _isLoading // If loading, show loading indicator, else show content
                ? LoadingState()
                : SingleChildScrollView(
                    padding: EdgeInsets.all(18),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Thông tin chung', style: titleStyle),
                          Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: inputDecoration.copyWith(
                                          icon: Icon(Icons.drive_eta),
                                          labelText: 'Biển số xe',
                                          hintText:
                                              widget.vehicle!.licensePlate),
                                      onSaved: (value) {
                                        _licensePlate = value!;
                                      },
                                    ),
                                    SizedBox(height: 12),
                                    TextFormField(
                                      decoration: inputDecoration.copyWith(
                                        icon: Icon(Icons.drive_eta),
                                        labelText: 'Hãng xe',
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Vui lòng nhập hãng xe';
                                        }
                                        _isValidate = true;
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _manufacturer = value!;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  width:
                                      12), // Some spacing between the fields and the image button
                              _buildAvatarField(
                                imageFile: vehicleImage,
                                onImageChange: (file) {
                                  if (file!.lengthSync() > 3 * 1024 * 1024) {
                                    // 3MB in bytes
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Ảnh quá lớn. Vui lòng tải lên ảnh dưới 3MB.')),
                                    );
                                  } else {
                                    setState(() {
                                      vehicleImage = file;
                                    });
                                  }
                                },
                                key: Key('avatar'),
                              ),
                            ],
                          ),
                          Text('Chi tiết kỹ thuật', style: titleStyle),
                          Divider(),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Số khung',
                            ),
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Vui lòng nhập số khung';
                            //   } else if (value.length != 17) {
                            //     return 'Số khung phải chứa đúng 17 ký tự';
                            //   } else if (value.contains(RegExp(r'[^\w]'))) {
                            //     return 'Số khung chỉ có thể chứa số và chữ cái';
                            //   } else if (value.contains(RegExp(r'[IQO]'))) {
                            //     return 'Số khung không được chứa các ký tự I, Q, O';
                            //   }
                            //   _isValidate = true;
                            //   return null;
                            // },
                            onSaved: (value) {
                              _vinNumber = value!;
                            },
                          ),
                          SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Loại xe',
                              labelStyle: TextStyle(fontSize: 16),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng chọn loại xe';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _selectedType = value!;
                            },
                            onChanged: (value) {
                              setState(() {
                                _selectedType = value!;
                              });
                            },
                            items: <String>[
                              'Xe kéo',
                              'Xe cẩu',
                              'Xe chở'
                            ] // Replace with your types of xe
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            hint: Text('Chọn loại xe'),
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2 -
                                    20, // Giving it half of the screen width minus a small margin
                                padding: EdgeInsets.only(
                                    right:
                                        10), // Padding to add spacing between the two widgets
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Màu sắc',
                                    labelStyle: TextStyle(fontSize: 16),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      print(value);
                                      return 'Vui lòng nhập màu sắc';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _color = value!;
                                  },
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2 -
                                    20, // Giving it half of the screen width minus a small margin
                                padding: EdgeInsets.only(
                                    left:
                                        10), // Padding to add spacing between the two widgets
                                child: DropdownButtonFormField<int>(
                                  decoration: inputDecoration.copyWith(
                                    labelText: 'Năm sản xuất',
                                    labelStyle: TextStyle(fontSize: 16),
                                  ),
                                  dropdownColor: Colors.grey[200],
                                  items: yearList.map((year) {
                                    return DropdownMenuItem<int>(
                                      value: year,
                                      child: SizedBox(
                                        width: 60,
                                        child: Center(
                                          child: Text(year.toString()),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _manufacturingYear =
                                          value ?? DateTime.now().year;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Vui lòng chọn năm sản xuất';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _manufacturingYear =
                                        value ?? DateTime.now().year;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text('Hình ảnh đăng kí xe',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildImageField(
                                label: 'Ảnh mặt trước',
                                imageFile: _carRegistrationFontImage,
                                onImageChange: (file) {
                                  if (file!.lengthSync() > 3 * 1024 * 1024) {
                                    // 3MB in bytes
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Ảnh quá lớn. Vui lòng tải lên ảnh dưới 3MB.')),
                                    );
                                  } else {
                                    setState(() {
                                      _carRegistrationFontImage = file;
                                    });
                                  }
                                },
                                key: Key('front'),
                              ),
                              // SizedBox(width: 25),
                              _buildImageField(
                                label: 'Ảnh mặt sau',
                                imageFile: _carRegistrationBackImage,
                                onImageChange: (file) {
                                  if (file!.lengthSync() > 3 * 1024 * 1024) {
                                    // 3MB in bytes
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Ảnh quá lớn. Vui lòng tải lên ảnh dưới 3MB.')),
                                    );
                                  } else {
                                    setState(() {
                                      _carRegistrationBackImage = file;
                                    });
                                  }
                                },
                                key: Key('back'),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment
                                .bottomCenter, // Set the alignment to bottom center
                            child: ElevatedButton(
                              onPressed: () async {
                                _submitForm();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        FrontendConfigs.kActiveColor),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                minimumSize: MaterialStateProperty.all<Size>(
                                    Size(double.infinity, 50)),
                                padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                    EdgeInsets.symmetric(vertical: 12)),
                              ),
                              child: Text('Lưu thông tin'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    ]);
  }

  _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận'),
          content: Text('Bạn đã chắc chắc điền đúng thông tin chưa ? '),
          actions: [
            TextButton(
              child: Text(
                'Hủy',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the AlertDialog
              },
            ),
            TextButton(
              child: Text(
                'Chắc chắn',
                style: TextStyle(color: FrontendConfigs.kActiveColor),
              ),
              onPressed: () {
                _submitForm();
                Navigator.of(context)
                    .pop(); // Close the AlertDialog after submitting
              },
            ),
          ],
        );
      },
    );
  }

  bool _isEmpty(File? imageFile) {
    return imageFile == null;
  }

  Widget _buildImageField({
    required String label,
    required File? imageFile,
    required ValueChanged<File?> onImageChange,
    required Key key,
    //
    String validationMessage = 'Ảnh bắt buộc',
  }) {
    bool isValid = !_isEmpty(imageFile);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final pickedFile =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              onImageChange(File(pickedFile.path));
            }
          },
          child: _getImageWidget(imageFile, key),
        ),
        if (!isValid)
          Transform.translate(
            offset: Offset(
                40, -40), // Set the offset to move the text up by 10 pixels
            child: imageFile == null
                ? Text(
                    validationMessage,
                    style: TextStyle(color: Colors.red),
                  )
                : SizedBox.shrink(),
          ) // Displaying a mandatory text in red when image is not uploaded
      ],
    );
  }

  Widget _buildAvatarField(
      {required File? imageFile,
      required ValueChanged<File?> onImageChange,
      required Key key}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            final pickedFile =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              onImageChange(File(pickedFile.path));
            }
          },
          child: _getImageWidget(imageFile, key),
        ),
        if (imageFile == null)
          Transform.translate(
            offset: Offset(
                40, -40), // Set the offset to move the text up by 10 pixels
            child: imageFile == null
                ? Text(
                    'Hình ảnh xe',
                  )
                : SizedBox.shrink(),
          ) // Displaying a mandatory text in red when image is not uploaded
      ],
    );
  }

  Widget _getImageWidget(File? imageFile, Key key) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          height: 108,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: imageFile != null
              ? Image.file(imageFile, fit: BoxFit.cover)
              : Icon(Icons.camera_alt, size: 50, color: Colors.grey),
        ),
        Visibility(
          visible: imageFile != null,
          child: IconButton(
            icon: Icon(Icons.remove_circle, color: Colors.red),
            onPressed: () {
              setState(() {
                if (key == Key('front')) {
                  _carRegistrationFontImage = null;
                } else if (key == Key('back')) {
                  _carRegistrationBackImage = null;
                } else if (key == Key('avatar')) {
                  vehicleImage = null;
                }
              });
            },
          ),
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
        ),
      ],
    );
  }
}
