import 'dart:io';

import 'package:blog_app/src/core/view_models/add_blog_view_model.dart';
import 'package:blog_app/src/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddBlogScreen extends StatelessWidget {
  const AddBlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => serviceLocator<BlogViewModel>(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Blog",
              ),
              elevation: 0.0,
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    model.addBlog().then((value) {
                      if (value) {
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Error"),
                          ),
                        );
                      }
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Icon(Icons.file_upload)),
                )
              ],
            ),
            body: model.isBusy
                ? Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  )
                : Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            model.getImage();
                          },
                          child: model.selectedImage != null
                              ? Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  height: 170,
                                  width: MediaQuery.of(context).size.width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.file(
                                      File(model.selectedImage!.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  height: 170,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6)),
                                  width: MediaQuery.of(context).size.width,
                                  child: const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.black45,
                                  ),
                                )),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              decoration:
                                  const InputDecoration(hintText: "Title"),
                                  controller: model.titleController,
                              onChanged: (val) {
                                // title = val;
                              },
                            ),
                            TextField(
                              controller: model.contentController,
                              decoration:
                                  const InputDecoration(hintText: "Desc"),
                              onChanged: (val) {
                                // desc = val;
                              },
                            ),
                            //category sports and tech
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                items: const [
                                  DropdownMenuItem(
                                    value: "Sports",
                                    child: Text("Sports"),
                                  ),
                                  DropdownMenuItem(
                                    value: "Tech",
                                    child: Text("Tech"),
                                  ),
                                ],
                                onChanged: model.onChangedCategory,
                                hint: const Text("Select Category"),
                                value: model.category,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          );
        });
  }
}
