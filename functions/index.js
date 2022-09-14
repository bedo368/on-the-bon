const functions = require("firebase-functions");

const admin = require("firebase-admin");

admin.initializeApp(functions.config().functions);

exports.orederTrigger = functions.firestore
  .document("orderInProgres/{orderInProgresId}")
  .onCreate(async (snapshot, context) => {
    var payload = {
      notification: {
        title: "new order",
        body: " there is a new order please check ",
      },
      data: { click_action: "FLUTTER_NOTIFICATION_CLICK" },
    };
    admin.messaging().sendToTopic("Admin", payload);
  });
