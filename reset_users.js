// reset_users.js — รีเซ็ต check-in data ของทุก user ใน Firestore
// Usage: node reset_users.js <path-to-serviceAccountKey.json>
//
// วิธีดาวน์โหลด service account key:
//   Firebase Console → Project Settings → Service Accounts → Generate new private key

const admin = require('firebase-admin');
const path = require('path');

const keyPath = process.argv[2];
if (!keyPath) {
    console.error('\n❌ กรุณาระบุ path ของ service account key:\n   node reset_users.js ./serviceAccountKey.json\n');
    process.exit(1);
}

const serviceAccount = require(path.resolve(keyPath));

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    projectId: 'ku-campus-dex',
});

const db = admin.firestore();

async function resetAllUsers() {
    console.log('🔄 กำลังดึงข้อมูล users...');
    const snapshot = await db.collection('users').get();

    if (snapshot.empty) {
        console.log('✅ ไม่มี user ในระบบ');
        return;
    }

    const batch = db.batch();
    let count = 0;

    snapshot.forEach((doc) => {
        batch.update(doc.ref, {
            level: 0,
            unlocked_places: [],
            checked_in_places: [],
        });
        count++;
        console.log(`  ↺ Reset: ${doc.id} (${doc.data().displayName || doc.data().email || 'unknown'})`);
    });

    await batch.commit();
    console.log(`\n✅ รีเซ็ต ${count} users เรียบร้อยแล้ว! ทุกคน level = 0, ไม่มี check-in`);
    process.exit(0);
}

resetAllUsers().catch((err) => {
    console.error('❌ Error:', err.message);
    process.exit(1);
});
