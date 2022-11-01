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
      data: { type: "new Order" },
    };
    admin.messaging().sendToTopic("Admin", payload);
  });

exports.sendNotification = functions.firestore
  .document("notifications/{notificationId}")
  .onCreate(async (snapshot, context) => {
    var payload = {
      notification: {
        title: snapshot.data().title,
        body: snapshot.data().content,
        image: snapshot.data().imageUrl,
      },
      data: { type: "users Notification" },
    };

    admin.messaging().sendToTopic("users", payload);
  });

// exports.checkIsAdmin = functions.https.onCall(async(data, contxt)=> {

//   const adminRole = await admin.firestore.document(`/adims/${contxt.auth.uid}`) ;

// })
