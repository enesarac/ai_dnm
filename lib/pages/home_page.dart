import "package:ai_dnm/bloc/chat_bloc_bloc.dart";
import "package:ai_dnm/models/chat_message_model.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatBlocBloc chatBlocBloc = ChatBlocBloc();
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBlocBloc, ChatBlocState>(
        bloc: chatBlocBloc,
        listener: (context, state) {
       
        },
        builder: (context, state) {
         switch (state.runtimeType) {
           case ChatSuccessState:
           List<ChatMessageModel> messages = (state as ChatSuccessState).messages;
           return   Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  height: 120,
                  color: Colors.white,
                ),
                Expanded(
                  child:ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index){
                       return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1)
                        ),
                        child: Text(messages[index].parts.first.text));
                })),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                            controller: textEditingController,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor))),
                      )),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: (){
                           if(textEditingController.text.isNotEmpty){
                            String text = textEditingController.text;
                            textEditingController.clear();
                            chatBlocBloc.add(ChatGenerateNewTextMessageEvent(
                              inputMessage: text)); 
                           }
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: const Center(
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
             
             
           default:
           return SizedBox();
         }
        },
      ),
    );
  }
}
