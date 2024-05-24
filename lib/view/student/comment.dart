import 'package:flutter/material.dart';
import 'package:abeermdrsty/constant/appbarchild.dart';
import 'package:abeermdrsty/constant/fontstyle.dart';
import 'package:abeermdrsty/style/list.dart';



class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<Comment> replies = [];

  TextEditingController _replyController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  void _sendReply() {
    String reply = _replyController.text;
    if (reply.isNotEmpty) {
      setState(() {
        replies.add(Comment(
          text: reply,
          userName: 'حلا بن بشر',
          avatarUrl: 'img/arabic.jpg',
          date: DateTime.now(),
        ));
        _replyController.clear();
      });
    }
  }

  void _editReply(int index) {
    String editedReply = replies[index].text;
    _replyController.text = editedReply;
    _replyController.selection = TextSelection.fromPosition(TextPosition(
        offset: editedReply.length));
    setState(() {
      replies.removeAt(index);
    });
  }

  void _deleteReply(int index) {
    setState(() {
      replies.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _replyController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appbarchild(title: "اقتراحاتي",),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _replyController,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            hintText: 'اكتب سؤالك هنا...',
                            border: UnderlineInputBorder(),
                          ),
                          textDirection: TextDirection.rtl,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال سؤالك';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_replyController.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        'الرجاء إدخال سؤالك قبل الإرسال'),
                                    backgroundColor: Colors.red,
                                  ));
                                } else {
                                  _sendReply();
                                }
                              },
                              child: Text('إرسال'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: replies.length,
                  itemBuilder: (context, index) {
                    final comment = replies[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: CommentWidget(
                        comment: comment,
                        onEdit: () => _editReply(index),
                        onDelete: () => _deleteReply(index),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class CommentWidget extends StatelessWidget {
  final Comment comment;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CommentWidget({
    required this.comment,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                comment.userName,
                style:fonttitlestyle.fonttitle,
              ),
              subtitle: Text(
                comment.date.toString(),
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              leading: CircleAvatar(
                backgroundImage: AssetImage(comment.avatarUrl),
                radius: 20,
              ),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: ListTile(
                      title: Text(
                        'تعديل',
                          style:fonttitlestyle.fonttitle,
                      ),
                      onTap: () {
                        onEdit();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      title: Text('حذف',
                            style:fonttitlestyle.fonttitle,),
                      onTap: () {
                        onDelete();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(comment.text,  style:fonttitlestyle.fonttitle,),
            SizedBox(height: 10),
            Divider(
              thickness: 2,
              color: Colors.grey.shade300,
            ),
            SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.shade900,
              ),
              child: Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الجواب:',
                        style:fonttitlestyle.fonttitle,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'محتوى الكارد',
                          style:fonttitlestyle.fonttitle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


