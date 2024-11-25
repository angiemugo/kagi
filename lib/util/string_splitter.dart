extension StringSplitter on String {
  Map<String, String>? splitOrExtract({
    RegExp? pattern,
    String delimiter = ':',
  }) {
    if (pattern != null) {
      final match = pattern.firstMatch(this);
      if (match != null) {
        return {
          'date': match.group(1)?.trim() ?? '',
          'description': match.group(2)?.trim() ?? '',
        };
      }
      return null;
    } else {
      final delimiterIndex = indexOf(delimiter);
      if (delimiterIndex != -1) {
        return {
          'title': substring(0, delimiterIndex + delimiter.length).trim(),
          'content': substring(delimiterIndex + delimiter.length).trim(),
        };
      }
      return {
        'title': trim(),
        'content': '',
      };
    }
  }
}
