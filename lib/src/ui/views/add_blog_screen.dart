import 'dart:io';

import 'package:blog_app/src/core/services/blog_service.dart';
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
                  onTap: () {},
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
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 6,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
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
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 6,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
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
                            const SizedBox(
                              height: 8,
                            ),
                            TextField(
                              controller: model.contentController,
                              decoration:
                                  const InputDecoration(hintText: "Desc"),
                              onChanged: (val) {
                                // desc = val;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: true,
                                  items: model.categories
                                      .map((category) => DropdownMenuItem(
                                            value: category,
                                            child: Text(category),
                                          ))
                                      .toList(),
                                  onChanged: model.onChangedCategory,
                                  hint: const Text("Select Category"),
                                  value: model.category,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
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
                              icon: const Icon(Icons.upload),
                              label: const Text(
                                "Upload",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
          );
        });
  }
}
