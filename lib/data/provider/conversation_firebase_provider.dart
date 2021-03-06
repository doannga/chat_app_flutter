import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constant/conversation_key.dart';

class ConversationFirebaseProvider {
  final FirebaseFirestore firestore;
  ConversationFirebaseProvider({
    required this.firestore,
  });

  Future<Map<String, dynamic>?> getConversationId({
    required String senderUID,
    required String receiverUID,
  }) async {
    final members = [senderUID, receiverUID];

    final conversationQuerySnap =
        await firestore.collection(ConversationKey.collectionName).where(
      ConversationKey.members,
      whereIn: [
        members,
        members.reversed.toList(),
      ],
    ).get();
    log(conversationQuerySnap.docs.length.toString());
    if (conversationQuerySnap.docs.isNotEmpty) {
      return conversationQuerySnap.docs.first.data();
    }
    return null;
  }

  Future<String> createConversation({
    required Map<String, dynamic> conversation,
  }) async {
    final conversationRef = await firestore
        .collection(ConversationKey.collectionName)
        .add(conversation);

    await conversationRef.update({ConversationKey.id: conversationRef.id});
    return conversationRef.id;
  }
}
