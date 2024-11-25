import 'package:flutter/material.dart';
import 'package:kagi_task/news_detail/widgets/webview.dart';

class WebButton extends StatelessWidget {
  final String name;
  final String? url;
  final String? favIcon;

  const WebButton({
    super.key,
    required this.name,
    this.url,
    this.favIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: url != null && url!.isNotEmpty
          ? () => _showWebview(context, url!)
          : null,
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
            if (favIcon != null)
              ClipOval(
                child: Image.network(
                  favIcon!,
                  width: 14,
                  height: 14,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.language,
                    color: Colors.blue,
                    size: 14,
                  ),
                ),
              )
            else
              const Icon(
                Icons.language,
                color: Colors.blue,
                size: 14,
              ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
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
