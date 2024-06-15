class StringCutter {
  static String cut(String src, int length) {
    if (length >= src.length) return src;
    return src.substring(0, length - 1) + "...";
  }
}
