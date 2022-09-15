const functions = require("firebase-functions");

const admin = require("firebase-admin");

admin.initializeApp(functions.config().functions);

exports.orederTriggerByAdmins = functions.firestore
  .document("orderInProgres/{orderInProgresId}")
  .onCreate(async (snapshot, context) => {
    var payload = {
      notification: {
        title: "طلب جديد",
        body: " هناك طلب جديد قم بالتحقق ",
      },
      data: { click_action: "FLUTTER_NOTIFICATION_CLICK" },
    };
    admin.messaging().sendToTopic("Admin", payload);
  });
