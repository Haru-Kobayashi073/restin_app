const functions = require("firebase-functions");
const admin = require("firebase-admin");

// firebase-adminの初期化
admin.initializeApp();

exports.deleteUser = functions
    .region("asia-northeast1")
    .firestore.document("deleted_users/{docId}")
    .onCreate(async (snap, _) => {
      const deleteDocument = snap.data();
      const uid = deleteDocument.uid;
      // Authenticationのユーザーを削除する
      await admin.auth().deleteUser(uid);
    });
