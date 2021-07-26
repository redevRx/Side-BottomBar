class SideModel {
  int? currentIndex;
  int? nextIndex;
  int? oldIndex;

  SideModel({this.currentIndex, this.nextIndex, this.oldIndex});

  setCurrentIndex(int index) => currentIndex = index;
  setNextIndex() => nextIndex = currentIndex! + 1;
  setOldIndex() => currentIndex! == 0 ? 0 : currentIndex! - 1;
}
