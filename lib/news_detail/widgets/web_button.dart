import 'package:flutter/material.dart';
import 'package:kagi_task/const/colors.dart';
import 'package:kagi_task/news_detail/widgets/webview.dart';

class WebButton extends StatelessWidget {
  final String url;
  const WebButton({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showWebview(context, url),
      borderRadius: BorderRadius.circular(14),
      splashColor: Colors.blue.withOpacity(0.2),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.language,
              color: linkBlue,
              size: 14,
            ),
            const SizedBox(width: 4),
            Text(
              url,
              style: const TextStyle(color: linkBlue, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  void _showWebview(BuildContext context, String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Webview(link: url),
      ),
    );
  }
}
