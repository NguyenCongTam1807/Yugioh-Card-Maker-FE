class YugiohApi {
  static const baseUrl = "http://10.0.2.2:8080/api/v1.0/cards";
  static const getAll = "$baseUrl/all";
  static const getAllByCardNameContaining = "$baseUrl/";
  static const getAllByCreatorName = "$baseUrl/?creatorName=";
  static const uploadCard = "$baseUrl/";
  static const deleteById = "$baseUrl/";
}