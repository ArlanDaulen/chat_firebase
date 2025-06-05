const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.notifyOnNewMessage = functions.firestore
    .document("chat_rooms/{roomId}/messages/{messageId}")
    .onCreate(async (snap, context) => {
      const newMessage = snap.data();
      const roomId = context.params.roomId;

      const {senderId, text} = newMessage;

      // Из roomId получим ID обоих пользователей
      const users = roomId.split("_");
      const recipientId = users.find((uid) => uid !== senderId);

      // Получаем токен получателя
      const userDoc = await admin.firestore().collection("users")
          .doc(recipientId).get();
      const recipientToken = userDoc.data().fcmToken;

      if (!recipientToken) {
        console.log("FCM token not found for recipient:", recipientId);
        return null;
      }

      const payload = {
        notification: {
          title: "Новое сообщение",
          body: text || "У вас новое сообщение",
        },
        token: recipientToken,
      };

      try {
        const response = await admin.messaging().send(payload);
        console.log("Notification sent successfully:", response);
      } catch (error) {
        console.error("Error sending notification:", error);
      }

      return null;
    });
