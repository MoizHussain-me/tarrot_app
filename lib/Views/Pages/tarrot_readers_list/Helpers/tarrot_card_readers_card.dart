import 'package:flutter/material.dart';
class TarrotCardReadersCard extends StatefulWidget {

 const TarrotCardReadersCard({Key? key}) : super(key: key);

  @override
  State<TarrotCardReadersCard> createState() => _TarrotCardReadersCard();
}

class _TarrotCardReadersCard extends State<TarrotCardReadersCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   width: 100,
                    //   height: 120,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(8),
                    //     image: DecorationImage(
                    //       image:
                    //           NetworkImage(widget.data.avatar.toString()),
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("data",
                                // widget.data.name.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                Icons.verified,
                                color: Colors.green,
                                size: 25,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          const Row(
                            children: [
                              Icon(Icons.support_agent_rounded,
                                  color: Colors.grey),
                              SizedBox(width: 8),
                              Text(
                                "5 years",
                                //widget.data.readersExpert.toString(),
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey),
                              ),
                              Text(
                                ' +7 more',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                            ],
                          ),
                          const Row(
                            children: [
                              Icon(Icons.g_translate_outlined,
                                  color: Colors.grey),
                              SizedBox(width: 8),
                              Text(
                                "English",
                                //widget.data.readersLanguage.toString(),
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey),
                              ),
                              Text(
                                ' +2 more',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                            ],
                          ),
                          const Row(
                            children: [
                              Icon(Icons.school_outlined,
                                  color: Colors.grey),
                              SizedBox(width: 8),
                              Text(
                                //'${widget.data.readersExperience} Years',
                                '2 Years',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey),
                              ),
                            ],
                          ),
                          const Row(
                            children: [
                              Icon(Icons.attach_money_outlined,
                                  color: Colors.grey),
                              SizedBox(width: 8),
                              Text(
                                '200\$ /min',
                                
                                //'${widget.data.readersFees} /min',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                '\t\t\t Online',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.green),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => CometChatMessages(
                          //             user: widget.data,
                          //           )),
                          // );
                          // navigateToMessagesScreen();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.chat, color: Colors.green),
                            SizedBox(width: 8),
                            Text('Chat', style: TextStyle(color: Colors.green)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 110,
              left: 30,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 19,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '5',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // void navigateToMessagesScreen(
  //     {User? user, Group? group, BuildContext? context}) {
  //   Navigator.push(
  //       context ?? this.context,
  //       MaterialPageRoute(
  //           builder: (context) => CometChatMessages(
  //                 user: user,
  //                 group: group,
  //                 messageComposerConfiguration:
  //                     messageConfiguration?.messageComposerConfiguration ??
  //                         const MessageComposerConfiguration(),
  //                 messageListConfiguration:
  //                     messageConfiguration?.messageListConfiguration ??
  //                         const MessageListConfiguration(),
  //                 messageHeaderConfiguration:
  //                     messageConfiguration?.messageHeaderConfiguration ??
  //                         const MessageHeaderConfiguration(),
  //                 customSoundForIncomingMessagePackage: messageConfiguration
  //                     ?.customSoundForIncomingMessagePackage,
  //                 customSoundForIncomingMessages:
  //                     messageConfiguration?.customSoundForIncomingMessages,
  //                 customSoundForOutgoingMessagePackage: messageConfiguration
  //                     ?.customSoundForOutgoingMessagePackage,
  //                 customSoundForOutgoingMessages:
  //                     messageConfiguration?.customSoundForOutgoingMessages,
  //                 detailsConfiguration:
  //                     messageConfiguration?.detailsConfiguration,
  //                 disableSoundForMessages:
  //                     messageConfiguration?.disableSoundForMessages,
  //                 disableTyping: messageConfiguration?.disableTyping ?? false,
  //                 hideMessageComposer:
  //                     messageConfiguration?.hideMessageComposer ?? false,
  //                 hideMessageHeader: messageConfiguration?.hideMessageHeader,
  //                 messageComposerView:
  //                     messageConfiguration?.messageComposerView,
  //                 messageHeaderView: messageConfiguration?.messageHeaderView,
  //                 messageListView: messageConfiguration?.messageListView,
  //                 messagesStyle: messageConfiguration?.messagesStyle,
  //                 theme: messageConfiguration?.theme ?? theme,
  //                 threadedMessagesConfiguration:
  //                     messageConfiguration?.threadedMessagesConfiguration,
  //                 hideDetails: messageConfiguration?.hideDetails,
  //               )));
  // }
}
