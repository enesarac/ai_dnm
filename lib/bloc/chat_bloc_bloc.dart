import 'dart:async';

import 'package:ai_dnm/models/chat_message_model.dart';
import 'package:ai_dnm/repos/chat_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_bloc_event.dart';
part 'chat_bloc_state.dart';

class ChatBlocBloc extends Bloc<ChatBlocEvent, ChatBlocState> {
  ChatBlocBloc() : super(ChatSuccessState(messages: [])) {
    on<ChatGenerateNewTextMessageEvent>(chatGenerateNewTextMessageEvent);
    
  }

    List<ChatMessageModel> messages = [];


  FutureOr<void> chatGenerateNewTextMessageEvent(
    ChatGenerateNewTextMessageEvent event, Emitter<ChatBlocState> emit) async {
     messages.add(ChatMessageModel(parts: [ChatPartModel(text: event.inputMessage)], role: 'user'));
     emit(ChatSuccessState(messages: messages));

String generatedText =await Aithrepy.chatTextGenerationRepo(messages);
if(generatedText.length>0){
  messages.add(
    ChatMessageModel(parts: [
    ChatPartModel(text: generatedText)
  ], role:'model'));     emit(ChatSuccessState(messages: messages));

}
  }
}