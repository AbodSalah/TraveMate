import 'dart:io';
import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:hotelbooking/components/cus.dart';
import 'package:hotelbooking/main.dart';

import 'package:image_picker/image_picker.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.username, required this.peerId});
  final String username, peerId;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');

  Stream<int> generateNumbers = (() async* {
    await Future<void>.delayed(Duration(seconds: 2));

    for (int i = 1; i <= 10; i++) {
      await Future<void>.delayed(Duration(seconds: 1));
      yield i;
    }
  })();
  bool isLoading = false;
  Stream<QuerySnapshot> getChatMessage(String groupChatId, int limit) {
    return firebaseFirestore
        .collection('chat')
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots();
  }

  String myId = sharedPreferences.getString('id')!;
  String groubId = '';
  @override
  Widget build(BuildContext context) {
    if (widget.peerId.hashCode >= myId.hashCode) {
      groubId = '${widget.peerId}s${myId}';
    } else {
      groubId = '${myId}s${widget.peerId}';
    }
    return Scaffold(
      backgroundColor: Color(0xff292F3F),
      appBar: AppBar(
        backgroundColor: Color(0xff292F3F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        toolbarHeight: 90,
        leading: Row(
          children: [
            SizedBox(
              width: 11,
            ),
          ],
        ),
        title: Text(widget.username),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: getChatMessage(groubId, 20),
              builder: (
                BuildContext context,
                AsyncSnapshot snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool isSender =
                            myId == snapshot.data?.docs[index]['idFrom']
                                ? true
                                : false;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: snapshot.data?.docs[index]['type'] != 1
                              ? BubbleSpecialThree(
                                  sent: true,
                                  text: snapshot.data?.docs[index]['content'],
                                  color: isSender
                                      ? Colors.purpleAccent
                                      : Color(0xFFE8E8EE),
                                  tail: true,
                                  isSender: isSender,
                                )
                              : BubbleNormalImage(
                                  id: '$index',
                                  isSender: !isSender,
                                  image: Image.network(
                                    snapshot.data?.docs[index]['content'],
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.network(
                                          'https://firebasestorage.googleapis.com/v0/b/project-dbeb2.appspot.com/o/scaled_image_picker1820260618743328462.jpg?alt=media&token=8dce8d8b-4809-4851-b493-3bc54c92f887');
                                    },
                                  ),
                                  color: isSender
                                      ? Colors.purpleAccent
                                      : Color(0xFFE8E8EE),
                                  sent: true,
                                ),
                        );
                      },
                    );
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              },
            ),
          ),
          MessageBar(
            onSend: (massge) async {
              await sendChatMessage(
                massge,
                0,
                groubId,
                myId,
                widget.peerId,
              );
            },
            actions: [
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: InkWell(
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.green,
                    size: 24,
                  ),
                  onTap: _handleAttachmentPressed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 170,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CustomListtile(
                widget: Icon(Icons.camera_alt_outlined),
                onTap: () {
                  Navigator.pop(context);
                  getImage();
                },
                titel: 'التقاط صوره',
              ),
              CustomListtile(
                widget: Icon(Icons.browse_gallery_outlined),
                onTap: () {
                  Navigator.pop(context);
                  getImage();
                },
                titel: 'اختار صوره',
              ),
              CustomListtile(
                widget: Icon(
                  Icons.arrow_back_ios_outlined,
                  textDirection: TextDirection.rtl,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
                titel: 'الرجوع للخلف',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future sendChatMessage(String message, int type, String groupChatId,
      String currentUserId, String peerId,
      {double? width, double? high}) async {
    DocumentReference documentReference = firebaseFirestore
        .collection('chat')
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      await transaction.set(documentReference, {
        'idFrom': currentUserId,
        'idTo': peerId,
        'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
        'content': message,
        'type': type,
        'width': width ?? 0,
        'high': high ?? 0,
      });
    });
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;
    pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });
        uploadImageFiles(imageFile);
      }
    }
  }

  Future<UploadTask> uploadImageFile(File image, String filename) async {
    Reference reference = await FirebaseStorage.instance.ref().child(filename);
    UploadTask uploadTask = reference.putFile(image);

    return uploadTask;
  }

  void uploadImageFiles(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask = await uploadImageFile(imageFile, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        isLoading = false;
        sendChatMessage(
          imageUrl,
          1,
          groubId,
          myId,
          widget.peerId,
          high: 200,
          width: 400,
        );
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: e.message ?? e.toString());
    }
  }
}
