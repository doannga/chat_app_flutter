import '../../models/conversation.dart';
import '../provider/conversation_firebase_provider.dart';

class ConversationRepository {
  final ConversationFirebaseProvider conversationFirebaseProvider;

  ConversationRepository({
    required this.conversationFirebaseProvider,
  });

  Future<Conversation?> getConversation({
    required String senderUID,
    required String receiverUID,
  }) async {
    final convesationMap = await conversationFirebaseProvider.getConversationId(
      senderUID: senderUID,
      receiverUID: receiverUID,
    );
    if (convesationMap == null) {
      return null;
    } else {
      return Conversation.fromMap(convesationMap);
    }
  }

  Future<String> createConversation({
    required Conversation conversation,
  }) async {
    final conversationId =
        await conversationFirebaseProvider.createConversation(
      conversation: conversation.toMap(),
    );
    return conversationId;
  }
}
