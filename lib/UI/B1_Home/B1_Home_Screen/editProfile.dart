import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hotelbooking/ShardFunction/valid.dart';
import 'package:hotelbooking/UI/handlingView/handlingview.dart';
import 'package:hotelbooking/controller/edit_profile_controller.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final ImagePicker picker = ImagePicker();

  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    EditProfileController editProfileController =
    Get.put(EditProfileController());
    return GetBuilder<EditProfileController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            title:  Text("Edit_Profile".tr,
                style: TextStyle(fontFamily: "Sofia", color: Colors.black)),
            actions: <Widget>[
              GetBuilder<EditProfileController>(
                builder: (controller) {
                  return HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: Center(
                      child: InkWell(
                        onTap: () async {
                          controller.updateUser(image);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Text(
                            "done".tr,
                            style: TextStyle(
                              color: Color(0xFF7F53AC),
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w800,
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.bottomRight,
                  width: 115,
                  height: 115,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: AssetImage('assets/image/images/GirlProfile.png'),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.defaultDialog(
                        title: "",
                        middleText: "Hello world!",
                        content: Container(
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  pickImage(ImageSource.gallery);
                                },
                                title: Text('اختار صوره من المعرض'),
                                leading: Icon(Icons.photo),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                onTap: () {
                                  pickImage(ImageSource.camera);
                                },
                                title: Text('اختار صوره من الكاميرا'),
                                leading: Icon(Icons.camera),
                              ),
                            ],
                          ),
                        ),
                        backgroundColor: Colors.grey[300],
                        titleStyle: TextStyle(color: Colors.white),
                        middleTextStyle: TextStyle(color: Colors.white),
                      );
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.camera_alt_outlined),
                    ),
                  ),
                ),
                Container(
                  height: 420.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 15.0,
                        spreadRadius: 10.0,
                        color: Colors.black12.withOpacity(0.03),
                      )
                    ],
                  ),
                  child: GetBuilder<EditProfileController>(
                    builder: (controller) {
                      return HandlingDataView(
                        statusRequest: controller.statusRequest1,
                        widget: Container(
                          child: Form(
                            key: editProfileController.formkeyedit,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 50.0,
                                ),
                                TextFieldEditing(
                                  hint: controller
                                      .infousetModel?.message!.username ??
                                      'mohamed',
                                  onSaved: (p0) {
                                    editProfileController.username = p0!;
                                  },
                                  validator: (p0) {
                                    return validInput(
                                        p0.toString(), 2, 50, 'username');
                                  },
                                  titels: 'user_name'.tr,
                                ),
                                Divider(
                                  color: Colors.black12.withOpacity(0.1),
                                  height: 0.3,
                                ),
                                TextFieldEditing(
                                  hint: controller
                                      .infousetModel?.message!.email ??
                                      'moahamed@gmaoil.com',
                                  onSaved: (p0) {
                                    editProfileController.email = p0!;
                                  },
                                  validator: (p0) {
                                    return validInput(
                                        p0.toString(), 5, 100, 'email');
                                  },
                                  titels: 'email'.tr,
                                ),
                                Divider(
                                  color: Colors.black12.withOpacity(0.1),
                                  height: 0.3,
                                ),
                                TextFieldEditing(
                                  hint: controller
                                      .infousetModel?.message!.phone ??
                                      '0123456789',
                                  onSaved: (p0) {
                                    editProfileController.phone = p0!;
                                  },
                                  validator: (p0) {
                                    return validInput(
                                      p0.toString(),
                                      4,
                                      50,
                                      'phone',
                                    );
                                  },
                                  titels: 'phone'.tr,
                                ),
                                Divider(
                                  color: Colors.black12.withOpacity(0.1),
                                  height: 1.2,
                                ),
                                TextFieldEditing(
                                  hint: controller
                                      .infousetModel?.message!.country ??
                                      'Egypt',
                                  onSaved: (p0) {
                                    editProfileController.countery = p0!;
                                  },
                                  validator: (p0) {
                                    return validInput(
                                      p0.toString(),
                                      2,
                                      50,
                                      'country',
                                    );
                                  },
                                  titels: 'country'.tr,
                                ),
                                TextFieldEditing(
                                  hint:
                                  controller.infousetModel?.message!.city ??
                                      'cairo',
                                  onSaved: (p0) {
                                    editProfileController.countery = p0!;
                                  },
                                  validator: (p0) {
                                    return validInput(
                                      p0.toString(),
                                      2,
                                      50,
                                      'city',
                                    );
                                  },
                                  titels: 'city'.tr,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TextFieldEditing extends StatelessWidget {
  const TextFieldEditing({
    Key? key,
    required this.titels,
    required this.hint,
    required this.onSaved,
    this.validator,
  }) : super(key: key);
  final String titels, hint;
  final void Function(String?) onSaved;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        bottom: 10.0,
        top: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            titels,
            style: TextStyle(
                fontFamily: "Sofia",
                color: Colors.black26,
                fontSize: 17.0,
                fontWeight: FontWeight.w700),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: TextFormField(
                initialValue: hint,
                onSaved: onSaved,
                validator: validator,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: const TextStyle(
                      fontFamily: "Sofia",
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 17.0),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
