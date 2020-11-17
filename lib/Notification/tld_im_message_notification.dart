import 'package:flutter/material.dart';

class TPIMMessageNotification extends Notification {
  TPIMMessageNotification({@required this.messageList});

  final List messageList;
}