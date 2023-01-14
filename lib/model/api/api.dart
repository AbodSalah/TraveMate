import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import '../../funs.dart' as f;
import '../../vars.dart' as v;


String supplications = "supplications";

BaseOptions options = BaseOptions(
  baseUrl: "${v.apiLink}",
  connectTimeout: 10000,
  receiveTimeout: 11000,
);

Dio dio = Dio(options);

class Api {
  int progress = 0;
  int size = 0;
  // var controller;
  Future? request({
        String? url,
        required String apiPath,
        String? urlExtra,
        Map<String, dynamic>? params,
        required bool isGet,
        File? file,
        List<File>? files,
        CancelToken? cancelToken,
        String condition = '1',
        var controller = null,
      }) async {
    Response? response = null;
    try {

      if(urlExtra != null) {
        if(url != null) {
          url = url + urlExtra;
        }
        apiPath = apiPath + urlExtra;
      }

      if ((isGet == true)) {
        response = await dio.get(
          url ?? "${v.apiLink}${apiPath}",
          queryParameters: params,
          cancelToken: cancelToken,
        );
      }
      else {
        if (file != null) {
          if (file.path.split("/").last == "tmp") {
            params!['img'] = null;
          } else {
            params!['img'] = MultipartFile.fromFileSync(
              file.path,
              filename: basename(file.path),

            );
          }
        }

        if(files != null) {
          List fromFiles = [];
          for (var element in files) {
            fromFiles.add(MultipartFile.fromFileSync(
              element.path,
              filename: basename(element.path),
              contentType: MediaType('image', basename(element.path).toString().split(".").last), //important
            ),);
          }
          params!['imgs[]'] = fromFiles;
        }


        var formData = FormData.fromMap(params!);
        response = await dio.post(
          url ?? "${v.apiLink}${apiPath}",
          data: formData,
          onSendProgress: (int sent, int total) {
            print('$sent $total');
            progress = sent;
            size = total;
            if (controller != null) {
              controller.progressRun(((sent / total) * 100).toInt());
            }
          },
          cancelToken: cancelToken,
        );
      }

      print("response data: ${response.data}");
      return response;
    } catch (err) {
      print("err cache api: ${err}");
      if (err is DioError) {
        DioError dioError = err as DioError;
        print("err: ${dioError.message}");
        if (dioError.response == null) {
          print("خطا تم الغاء الرفع تاكد من اتصال الانترنت او قد يكون خلل في السرفر");
          if (isGet == false) {
            Fluttertoast.showToast(
              msg: "خطا تم الغاء الرفع تاكد من اتصال الانترنت او قد يكون خلل في السرفر",
              backgroundColor: Colors.red,
              textColor: Colors.black,
            );
          }
        } else {
          print("response status code: ${dioError.response!.statusCode}");
          if (dioError.response!.statusCode == 404) {
            print("خطا في السرفر قد يكون ملف php غير صحيح");
            Fluttertoast.showToast(
              msg: "خطا في السرفر قد يكون ملف php غير صحيح",
              backgroundColor: Colors.red,
              textColor: Colors.black,
            );
          } else if (dioError.response!.statusCode == 500) {
            print("خطا تم الغاء الرفع او الرابط غير صحيح او الملف الذي اخترته غير موجود او معطوب");
            Fluttertoast.showToast(
              msg: "خطا تم الغاء الرفع او الرابط غير صحيح او الملف الذي اخترته غير موجود او معطوب",
              backgroundColor: Colors.red,
              textColor: Colors.black,
            );
          } else {
            print("خطا لم يتم الرفع خطا غير متوقع");
            Fluttertoast.showToast(
              msg: "خطا لم يتم الرفع خطا غير متوقع",
              backgroundColor: Colors.red,
              textColor: Colors.black,
            );
          }
        }
      }
      else if (err is FileSystemException) {
        FileSystemException fileSystemException = err as FileSystemException;
        print("err: ${fileSystemException.message}");
        Fluttertoast.showToast(
          msg: "خطا الملف الذي اخترته غير موجود او معطوب او تم الغاء الرفع او الرابط غير صحيح",
          backgroundColor: Colors.red,
          textColor: Colors.black,
        );
      }
      else {
        Fluttertoast.showToast(
          msg: "خطا لم يتم الرفع خطا غير متوقع",
          backgroundColor: Colors.red,
          textColor: Colors.black,
        );
      }
      return null;
    }
  }
}
