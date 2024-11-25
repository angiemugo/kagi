import 'package:flutter/material.dart';
import 'package:kagi_task/news_detail/widgets/webview.dart';

class WebButton extends StatelessWidget {
  final String url;
  final String? favIcon; // URL for favicon (optional)

  const WebButton({
    super.key,
    required this.url,
    this.favIcon,
  });

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
                  ), // Fallback icon if favicon fails to load
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
                url,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis, // Handle long URLs gracefully
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
