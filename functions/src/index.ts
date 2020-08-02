import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();

const db=admin.firestore();
const fcm=admin.messaging();

export const sendToLoaner = functions.firestore.document('contracts/{contractId}').onCreate(async snapshot =>{
    const contract=snapshot.data();
    const querySnapshot=await db.collection('contracts').doc(contract.sender).collection('tokens').get();

    const tokens=querySnapshot.docs.map(snap => snap.id);

    const payload: admin.messaging.MessagingPayload ={
        notification:{
            title: 'You have a new request',
            body:`${contract.loanerName} has sent you a request`,
            clickAction:'FLUTTER_NOTIFICATION_CLICK'
        }
    };

    fcm.sendToDevice(tokens,payload);

});

export const sendToBorrower = functions.firestore.document('contracts/{contractId}').onCreate(async snapshot =>{
    const contract=snapshot.data();
    const querySnapshot=await db.collection('contracts').doc(contract.status).collection('tokens').get();

    const tokens=querySnapshot.docs.map(snap => snap.id);

    const payload: admin.messaging.MessagingPayload ={
        notification:{
            title: 'Lender has responded',
            body:`${contract.loanerName} has ${contract.state}ed your request`,
            clickAction:'FLUTTER_NOTIFICATION_CLICK'
        }
    };

    fcm.sendToDevice(tokens,payload);

});
