const functions = require("firebase-functions");

const admin = require("firebase-admin");
const { defineBoolean } = require("firebase-functions/v2/params");

admin.initializeApp(functions.config().functions);

exports.orederTriggerByAdmins = functions.firestore
  .document("orderInProgres/{orderInProgresId}")
  .onCreate(async (snapshot, context) => {
    var adminPayload = {
      notification: {
        title: "طلب جديد",
        body: " هناك طلب جديد قم بالتحقق ",
      },
      data: { type: "new Order" },
    };
    admin.messaging().sendToTopic("Admin", adminPayload);

    var userPayload = {
      notification: {
        title: " 😎 لديك طلب جديد ",
        body: " مرحبا صديقي لقد قمت بعمل طلب جديد سيتم  التواصل معك",
      },
    };
    // print(`context : ${context}`);
    // print(`snapshot : ${context}`);

    var userData = await admin
      .firestore()
      .collection(`users`)
      .doc(snapshot.data().userId)
      .get();
    // var addNotification = await admin
    //   .firestore()
    //   .doc(`users/${context.params.userId}`)
    //   .update({userNotification: {}, });

    await admin
      .firestore()
      .collection(`usernotifications`)
      .doc(snapshot.data().userId)
      .set(
        {
          [snapshot.id]: {
            title: "رائع لقد قمت بطلب جديد",
            body: ` لديك طلب جديد سيتم الاتصال بك علي رقم ${
              userData.data().phoneNumber
            } لاستكمال الطلب`,
          },
        },
        { merge: true }
      );

    admin
      .messaging()
      .sendToDevice(userData.data().deviceNotificationId, userPayload);
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

exports.submitOrderToSuccess = functions.firestore
  .document("sucessfulOrder/{sucessfulOrderId}")
  .onCreate(async (snapshot, context) => {
    var userPayload = {
      notification: {
        title: " 🤗 ✌️ مرخبا 👋 : طلبك تم تسليمه ",
        body: "تم تسليم الطلب الخاص بك ✌️ ✌️ لو واجهتك اي مشكله تواصل معانا",
      },
    };
    // print(`context : ${context}`);
    // print(`snapshot : ${context}`);

    var userData = await admin
      .firestore()
      .collection(`users`)
      .doc(snapshot.data().userId)
      .get();
    // var addNotification = await admin
    //   .firestore()
    //   .doc(`users/${context.params.userId}`)
    //   .update({userNotification: {}, });

    await admin
      .firestore()
      .collection(`usernotifications`)
      .doc(snapshot.data().userId)
      .set(
        {
          [snapshot.id]: {
            title: "لقد تم تاكيد تسليم طلبك ",
            body: `تم استكمال الطلب الخاص بك لو واجهتك اي مشكله تواصل معانا `,
          },
        },
        { merge: true }
      );

    admin
      .messaging()
      .sendToDevice(userData.data().deviceNotificationId, userPayload);
  });
