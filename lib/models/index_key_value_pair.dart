class IndexKeyValuePair {
  int index;
  String key;
  int value;

  IndexKeyValuePair(this.index, this.key, this.value);

  void setValue(int newValue) {
    value = newValue;
  }
}