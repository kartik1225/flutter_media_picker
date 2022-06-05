enum MediaType { all, image, video, audio }

enum SelectMode {
  single,
  multiple,
}

extension SelectModeExtension on SelectMode {
  int get pos{
    switch(this){
      case SelectMode.single:
        return 1;
      case SelectMode.multiple:
        return 2;
    }
  }
}

class MediaPickerResult {
  List<String> selectedPaths;
  MediaPickerResult({required this.selectedPaths});

  @override
  String toString() {
    return 'selectedPaths: $selectedPaths';
  }
}


