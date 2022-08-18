import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage(
    // Key? key,
    this.data,
    this.mine,
  ) /*  : super(key: key) */;

  final Map<String, dynamic> data;
  final bool mine;

  @override
  Widget build(BuildContext context) {
    /*   DateTime now = DateTime.now();
    String convertedDateTime =
        "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year.toString()} - ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
 */
    //Timestamp convertedDateTime = now.toString() as Timestamp;

    return Card(
      elevation: 3,
      color: Colors.white70,
      shadowColor: Colors.black,
      margin: const EdgeInsets.all(5),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.indigo[900]!, width: 0.3)),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: <Widget>[
            !mine
                ? Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        data['senderPhotoUrl'],
                      ),
                    ),
                  )
                : Container(),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  data['imgUrl'] != null
                      ? Image.network(
                          data['imgUrl'],
                          width: 150,
                        )
                      : Text(
                          data['text'] ?? "",
                          textAlign: mine ? TextAlign.end : TextAlign.start,
                          style: const TextStyle(fontSize: 16),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data['senderName'],
                        style: const TextStyle(
                          color: Colors.indigo,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      /*   Text(
                        convertedDateTime,
                        //data['time'].toString(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ), */
                    ],
                  ),
                ],
              ),
            ),
            mine
                ? Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        data['senderPhotoUrl'],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
