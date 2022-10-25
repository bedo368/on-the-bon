import 'package:flutter/material.dart';
import 'package:on_the_bon/global_widgets/image_picker.dart';
import 'package:on_the_bon/screens/add_product_screens/widets/add_product_forms.dart';
import 'package:on_the_bon/service/manage_notification.dart';

class NotificationForm extends StatelessWidget {
  const NotificationForm({
    Key? key,
  }) : super(key: key);

  static GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> formData = {};
    Future<void> formSubmit() async {
      formKey.currentState!.save();

      if (!formKey.currentState!.validate()) {
        return;
      }
      try {
        await NotificationApi.sendNotification(
            title: formData["title"],
            content: formData["content"],
            image: formData["image"]);
      } catch (e) {
        rethrow;
      }
    }

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formKey,
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
            child: ImagePickerWedgit((pickedImagefn) {
              formData["image"] = pickedImagefn;
            }),
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
              child: const Text("ارسال اشعار"),
            ),
          )
        ],
      ),
    );
  }
}
