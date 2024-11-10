import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7ety/core/functions/navigation.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/core/widgets/custom_button.dart';
import 'package:se7ety/feature/patient/presentation/page/profile/page/settings_view.dart';
import 'package:se7ety/feature/patient/presentation/page/search/widgets/item_tile.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({super.key});

  @override
  PatientProfileState createState() => PatientProfileState();
}

class PatientProfileState extends State<PatientProfile> {
  String? _imagePath;
  File? file;
  String? profileUrl;

  String? userId;

  Future<void> _getUser() async {
    userId = FirebaseAuth.instance.currentUser?.uid;
  }

  uploadImageToFireStore(File image, String imageName) async {
    Reference ref =
        FirebaseStorage.instanceFor(bucket: "gs://se7ety-1303.appspot.com")
            .ref()
            .child('patients/${FirebaseAuth.instance.currentUser!.uid}');
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    await ref.putFile(image, metadata);
    String url = await ref.getDownloadURL();
    return url;
  }

  Future<void> _pickImage() async {
    _getUser();
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        file = File(pickedFile.path);
      });
    }
    profileUrl = await uploadImageToFireStore(file!, 'doc');
    FirebaseFirestore.instance.collection('patients').doc(userId).set({
      'image': profileUrl,
    }, SetOptions(merge: true));
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: const Text(
          'الحساب الشخصي',
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              splashRadius: 20,
              icon: const Icon(
                Icons.settings,
                color: AppColors.whiteColor,
              ),
              onPressed: () {
                push(context, const UserSettings());
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('patients')
                .doc(userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var userData = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(20),
                        Row(
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.whiteColor,
                                  radius: 60,
                                  backgroundImage: (userData?['image'] != '')
                                      ? NetworkImage(userData?['image'])
                                      : (_imagePath != null)
                                          ? FileImage(File(_imagePath!))
                                              as ImageProvider
                                          : const AssetImage(
                                              'assets/images/doc.png'),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await _pickImage();
                                  },
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: const Icon(
                                      Icons.camera_alt_rounded,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Gap(30),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${userData!['name']}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: getTtileTextStyle(),
                                  ),
                                  Gap(15),
                                  (userData['city'] == '')
                                      ? CustomButton(
                                          text: 'تعديل الحساب',
                                          textColor: AppColors.whiteColor,
                                          height: 40,
                                          onPressed: () {},
                                        )
                                      : Text(
                                          userData['city'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: getbodyTextStyle(
                                              color: AppColors.textColor),
                                        ),
                                  Gap(15),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Gap(25),
                        Text(
                          "نبذه تعريفيه",
                          style: getbodyTextStyle(fontWeight: FontWeight.w600),
                        ),
                        Gap(10),
                        Text(
                          userData['bio'] == '' ? 'لم تضاف' : userData['bio'],
                          style: getSmallTextStyle(color: AppColors.textColor),
                        ),
                        Gap(20),
                        const Divider(),
                        Gap(20),
                        Text(
                          "معلومات التواصل",
                          style: getbodyTextStyle(fontWeight: FontWeight.w600),
                        ),
                        Gap(10),
                        Container(
                          padding: const EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.accentColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TileWidget(
                                  text: userData['email'] ?? 'لم تضاف',
                                  icon: Icons.email),
                              Gap(15),
                              TileWidget(
                                  text: userData['phone'] == ''
                                      ? 'لم تضاف'
                                      : userData['phone'],
                                  icon: Icons.call),
                            ],
                          ),
                        ),
                        const Divider(),
                        Gap(20),
                        Text(
                          "حجوزاتي",
                          style: getbodyTextStyle(fontWeight: FontWeight.w600),
                        ),
                        //const MyAppointmentsHistory()
                      ],
                    )),
              );
            }),
      ),
    );
  }
}
