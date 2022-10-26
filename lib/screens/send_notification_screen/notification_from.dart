import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/image_picker.dart';
import 'package:on_the_bon/screens/add_product_screens/widets/add_product_forms.dart';
import 'package:on_the_bon/service/manage_notification.dart';

class NotificationForm extends StatefulWidget {
  const NotificationForm({
    Key? key,
  }) : super(key: key);

  static GlobalKey<FormState> formKey = GlobalKey();

  @override
  State<NotificationForm> createState() => _NotificationFormState();
}

class _NotificationFormState extends State<NotificationForm> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> formData = {};
    Future<void> formSubmit() async {
      NotificationForm.formKey.currentState!.save();

      if (!NotificationForm.formKey.currentState!.validate()) {
        return;
      }
      try {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("ارسال اشعار"),
                  content: const Text(
                      "هل انت متاكد من ارسال الاشعار ارسال الكثير من الاشعارت للعميل قد يؤدي الي تجربه سيئه مما قد يسبب مسح التطبيث"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("الغاء")),
                    TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop();

                          setState(() {
                            isLoading = true;
                          });
                          await NotificationApi.sendNotification(
                              title: formData["title"],
                              content: formData["content"],
                              image: formData["image"]);
                          setState(() {
                            isLoading = false;
                          });
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("تم ارسال الاشعار")));
                        },
                        child: const Text("متاكد")),
                  ],
                ));
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        rethrow;
      }
    }

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: NotificationForm.formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width * .8,
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "من فضلك ادخل النوع الفرعي للمنتج";
                } else if (value.length < 4) {
                  return "النوع الفرعي قصير للغايه ";
                }

                return null;
              },
              onSaved: (value) {
                formData["title"] = value;
              },
              decoration: formInputDecortion("العنوان", context),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40),
            width: MediaQuery.of(context).size.width * .8,
            child: TextFormField(
              maxLines: 3,
              validator: (value) {
                if (value!.isEmpty) {
                  return "من فضلك ادخل النوع الفرعي للمنتج";
                } else if (value.length < 10) {
                  return "النوع الفرعي قصير للغايه ";
                }

                return null;
              },
              onSaved: (value) {
                formData["content"] = value;
              },
              decoration: formInputDecortion("محتوي الاشعار", context),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: ImagePickerWedgit(
              imageQulity: 30,
              (pickedImagefn) {
                formData["image"] = pickedImagefn;
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .8,
            height: 40,
            margin: const EdgeInsets.only(top: 40),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: formSubmit,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("ارسال اشعار"),
            ),
          )
        ],
      ),
    );
  }
}
