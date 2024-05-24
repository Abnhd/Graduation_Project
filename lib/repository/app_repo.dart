abstract class ApplicationRepo {

  Future<List<dynamic>> getData({required String source});
  Future<dynamic> getoneData({required String source});
  Future<dynamic>   postData({required Map<String, dynamic> dataToSend, required String source});
  Future<dynamic>   updateData({required Map<String, dynamic> dataToSend, required String source});
  Future<dynamic>  delete({required Map<String, dynamic> dataToSend, required String source});
 

}
