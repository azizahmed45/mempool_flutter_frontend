class MempoolBlockModel {
  int blockSize;
  int numberOfTransaction;

  double get blockSizeInMb => (blockSize / (1024 * 1024));

  MempoolBlockModel({this.blockSize, this.numberOfTransaction});

  factory MempoolBlockModel.fromJson(Map<String, dynamic> json) {
    return MempoolBlockModel(
        blockSize: json['blockSize'], numberOfTransaction: json['nTx']);
  }
}
