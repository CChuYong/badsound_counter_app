import 'package:badsound_counter_app/core/api/model/auth_request.dart';
import 'package:badsound_counter_app/core/api/model/auth_result.dart';
import 'package:badsound_counter_app/core/api/model/chat_response.dart';
import 'package:badsound_counter_app/core/api/model/dashboard_response.dart';
import 'package:badsound_counter_app/core/api/model/device_request.dart';
import 'package:badsound_counter_app/core/api/model/room_create_request.dart';
import 'package:badsound_counter_app/core/api/model/room_detail_response.dart';
import 'package:badsound_counter_app/core/api/model/room_response.dart';
import 'package:badsound_counter_app/core/api/model/upload_request.dart';
import 'package:badsound_counter_app/core/api/model/user_nickname_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import 'model/chat_request.dart';
import 'model/me_response.dart';
import 'model/refresh_request.dart';
import 'model/upload_req_response.dart';

part 'open_api.g.dart';

@RestApi(baseUrl: 'https://bsc.chuyong.kr/app')
abstract class OpenAPI {
  factory OpenAPI(Dio dio, {String baseUrl}) = _OpenAPI;

  @POST('/users/oauth')
  Future<AuthResult> authenticate(@Body() AuthRequest request);

  @POST('/users/device')
  Future<dynamic> registerDevice(@Body() DeviceRequest request);

  @POST('/users/refresh')
  Future<AuthResult> refresh(@Body() RefreshRequest request);

  @GET('/users/me')
  Future<MeResponse> getMe();

  @GET('/users/{userId}')
  Future<MeResponse> getUserById(@Path() String userId);

  @GET('/users/dashboard')
  Future<DashboardResponse> getDashboard();

  @POST('/rooms')
  Future<RoomResponse> createNewRoom(@Body() RoomCreateRequest request);

  @GET('/users/rooms')
  Future<List<RoomDetailResponse>> getMyRooms();

  @POST('/users/nickname')
  Future<MeResponse> updateNickname(@Body() UserNicknameRequest request);

  @GET('/rooms/{roomId}/messages')
  Future<List<ChatResponse>> getChattings(@Path() String roomId);

  @GET('/rooms/{roomId}/messages?fetchType=BACKWARD')
  Future<List<ChatResponse>> getChattingsBefore(
    @Path() String roomId,
    @Query("baseId") String baseId,
  );

  @GET('/rooms/{roomId}/messages?fetchType=FORWARD')
  Future<List<ChatResponse>> getChattingsAfter(
    @Path() String roomId,
    @Query("baseId") String baseId,
  );

  @GET('/rooms/{roomId}/users')
  Future<List<MeResponse>> getUsersInRoom(@Path() String roomId);

  @POST('/rooms/{roomId}/messages')
  Future<ChatResponse> sendMessage(
      @Path() String roomId, @Body() ChatRequest request);

  @GET('/upload-request?type=USER')
  Future<UploadRequestResponse> requestProfileImageUpload();

  @GET('/upload-request?type=ROOM')
  Future<UploadRequestResponse> requestRoomImageUpload(@Query("roomId") String roomId);

  @POST('/users/profile-image')
  Future<MeResponse> updateProfileImage(@Body() UploadRequest request);

  @POST('/rooms/{roomId}/profile-image')
  Future<RoomResponse> updateRoomImage(@Path() String roomId, @Body() UploadRequest request);
}
