import 'package:carpimskoroyunu/pages/inventory_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FalseReplyScreenDialog {
  SimpleDialog falseReply(int skor, String mod) {
    return SimpleDialog(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Yanlış Cevaba Tıkladın!\n $mod Mod Skorun: $skor',
          textAlign: TextAlign.center,
        ),
      ),
      children: [
        Container(
          margin: const EdgeInsets.all(8.0),
          child: MaterialButton(
            padding: const EdgeInsets.all(15),
            color: Colors.deepOrange,
            onPressed: () {
              Get.offAll(() => const InventoryScreen());
            },
            child: const Text(
              'Geri Dön',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        )
      ],
    );
  }
}
