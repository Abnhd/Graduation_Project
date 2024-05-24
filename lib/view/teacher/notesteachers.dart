import 'package:flutter/material.dart';
import 'package:abeermdrsty/constant/appbarchild.dart';
import 'package:abeermdrsty/constant/fontstyle.dart';
import 'package:abeermdrsty/style/list.dart';
import 'package:abeermdrsty/view/teacher/components/drawer/custom_drawer.dart';

class notesteachers extends StatefulWidget {
  @override
  _notesteachersState createState() => _notesteachersState();
}

class _notesteachersState extends State<notesteachers> {
  List<Comment> replies = [];
  TextEditingController _replyController = TextEditingController();

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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تعديل الرد'),
        content: TextFormField(
          controller: TextEditingController(text: editedReply),
          decoration: InputDecoration(
            hintText: 'اكتب الدرس هنا...',
          ),
          textDirection: TextDirection.rtl,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'الرجاء إدخال الدرس';
            }
            return null;
          },
          autofocus: true,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                replies[index] = Comment(
                  text: _replyController.text,
                  userName: 'حلا بن بشر',
                  avatarUrl: 'img/arabic.jpg',
                  date: DateTime.now(),
                );
                _replyController.clear();
                Navigator.pop(context);
              });
            },
            child: Text('حفظ التعديل'),
          ),
        ],
      ),
    );
  }

  void _deleteReply(int index) {
    setState(() {
      replies.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appbarchild(title: "التقرير اليومي"),
        drawer: CustomDrawer(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _replyController,
                          decoration: InputDecoration(
                            hintText: 'اكتب الدرس هنا...',
                            border: UnderlineInputBorder(),
                          ),
                          textDirection: TextDirection.rtl,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال الدرس';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            if (_replyController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('الرجاء إدخال الدرس قبل الإرسال'),
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
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: replies.map((comment) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 15.0,
                        ),
                        child: CommentWidget(
                          comment: comment,
                          onEdit: () => _editReply(replies.indexOf(comment)),
                          onDelete: () => _deleteReply(replies.indexOf(comment)),
                        ),
                      );
                    }).toList(),
                  ),
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
                comment.text,
                style: fonttitlestyle.fonttitle,
              ),
              subtitle: Text(comment.date.toString()),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: ListTile(
                      title: Text(
                        'تعديل',
                        style: fonttitlestyle.fonttitle,
                      ),
                      onTap: () {
                        onEdit();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      title: Text(
                        'حذف',
                        style: fonttitlestyle.fonttitle,
                      ),
                      onTap: () {
                        onDelete();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Comment {
  final String text;
  final String userName;
  final String avatarUrl;
  final DateTime date;

  Comment({
    required this.text,
    required this.userName,
    required this.avatarUrl,
    required this.date,
  });
}
