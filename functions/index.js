const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();
const fireStore = admin.firestore();
const batchLimit = 500;

/**
 * Deletes all documents in a collection that match a query.
 * @param {Object} collectionRef - A reference to the collection to delete
 * documents from.
 * @param {Function} queryFn - A function that returns a query to match
 * documents to delete.
 */
async function deleteCollectionItems(collectionRef, queryFn) {
  const querySnapshot = await queryFn(collectionRef);
  let batch = fireStore.batch();
  let count = 0;
  const deleteMarkersIds = [];
  try {
    if (!querySnapshot.empty) {
      querySnapshot.forEach((doc) => {
        deleteMarkersIds.push(doc.id);
        batch.delete(doc.ref);
        count++;

        if (count === batchLimit) {
          batch.commit();
          batch = fireStore.batch();
          count = 0;
        }
      });

      if (count > 0) {
        await batch.commit();
      }
    }
    console.log("deleteCollectionItems成功!!!!!!!");
    return deleteMarkersIds;
  } catch (error) {
    console.error("deleteCollectionItems" + error);
  }
}

/**
 * Deletes all documents in a collection that match a query.
 * @param {String} uid - A reference to the collection to delete
 */
async function deleteValueFromBookMarkedUserIds(uid) {
  const querySnapshot = await fireStore.collection("markers").where("bookMarkedUserIds", "array-contains", uid).get();
  let batch = fireStore.batch();
  let count = 0;

  try {
    if (!querySnapshot.empty) {
      for (const doc of querySnapshot.docs) {
        const bookMarkedUserIds = doc.data().bookMarkedUserIds;
        const updatedBookMarkedUserIds = bookMarkedUserIds.filter(
          (id) => id !== uid,
        );
        batch.update(doc.ref, {
          bookMarkedUserIds: updatedBookMarkedUserIds,
        });
        count++;
        if (count == batchLimit) {
          await batch.commit();
          batch = fireStore.batch();
          count = 0;
        }
      }
      if (count > 0) {
        await batch.commit();
      }
    }
    console.log("deleteValueFromBookMarkedUserIds成功!!!!!!!");
  } catch (error) {
    console.error("deleteValueFromBookMarkedUserIds" + error);
  }
}

/**
 * Deletes all documents in a collection that match a query.
 * @param {Array} deleteMarkersIds - A reference to the collection to delete
 */
async function deleteValueFromBookMarkMarkerIds(deleteMarkersIds) {
  const querySnapshot = await fireStore.collection("markers").where("bookMarkMarkerIds", "array-contains", deleteMarkersIds).get();
  let batch = fireStore.batch();
  let count = 0;

  try {
    if (!querySnapshot.empty) {
      for (const doc of querySnapshot.docs) {
        const bookMarkMarkerIds = doc.data().bookMarkMarkerIds;
        const updatedBookMarkMarkerIds = bookMarkMarkerIds.filter(
          (id) => !deleteMarkersIds.includes(id),
        );
        batch.update(doc.ref, {
          bookMarkMarkerIds: updatedBookMarkMarkerIds,
        });
        count++;
        if (count == batchLimit) {
          await batch.commit();
          batch = fireStore.batch();
          count = 0;
        }
      }
      if (count > 0) {
        await batch.commit();
      }
    }
    console.log("deleteValueFromBookMarkMarkerIds成功!!!!!!!");
  } catch (error) {
    console.error("deleteValueFromBookMarkMarkerIds" + error);
  }
}

exports.deleteUser = functions
  .region("asia-northeast1")
  .firestore.document("delete_users/{uid}")
  .onCreate(async (snap, _) => {
    const uid = snap.data().uid;

    // Delete user's comments
    await deleteCollectionItems(
      fireStore.collectionGroup("comments"),
      (collectionRef) => collectionRef.where("creatorId", "==", uid).get(),
    );

    // Delete user's markers
    const deleteMarkersIds = await deleteCollectionItems(
      fireStore.collection("markers"),
      (collectionRef) => collectionRef.where("creatorId", "==", uid).get(),
    );

    // Delete user from 'markers' document
    await deleteValueFromBookMarkedUserIds(uid);

    // Delete markerId from 'users' document
    await deleteValueFromBookMarkMarkerIds(deleteMarkersIds);

    // Delete user's Cloud Storage files
    const storageRef = admin.storage().bucket();
    const userStorageFolder = `users/${uid}`;
    const [files] = await storageRef.getFiles({
      prefix: userStorageFolder,
    });
    files.forEach((file) => file.delete());

    // Delete the user's Firebase Authentication account
    await admin.auth().deleteUser(uid);
    console.log("CLOUDFUNCTIONS: deleteUser成功!!!!!!!");
  });