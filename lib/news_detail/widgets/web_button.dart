import 'package:flutter/material.dart';
import 'package:kagi_task/const/colors.dart';
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
      onTap: _canOpenUrl ? () => _showWebview(context, url!) : null,
      borderRadius: BorderRadius.circular(14),
      splashColor: Colors.blue.withOpacity(0.2),
      child: _buildButtonContent(context),
    );
  }

  bool get _canOpenUrl => url != null && url!.isNotEmpty;

  Widget _buildButtonContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIcon(),
          const SizedBox(width: 4),
          _buildName(context),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    if (favIcon != null) {
      return ClipOval(
        child: Image.network(
          favIcon!,
          width: 14,
          height: 14,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.language,
            color: linkBlue,
            size: 14,
          ),
        ),
      );
    }
    return const Icon(
      Icons.language,
      color: linkBlue,
      size: 14,
    );
  }

  Widget _buildName(BuildContext context) {
    return Flexible(
      child: Text(
        name,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: linkBlue),
        overflow: TextOverflow.ellipsis,
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
