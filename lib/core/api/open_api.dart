import 'package:badsound_counter_app/core/api/model/auth_request.dart';
import 'package:badsound_counter_app/core/api/model/auth_result.dart';
import 'package:badsound_counter_app/core/api/model/chat_response.dart';
import 'package:badsound_counter_app/core/api/model/dashboard_response.dart';
import 'package:badsound_counter_app/core/api/model/device_request.dart';
import 'package:badsound_counter_app/core/api/model/room_create_request.dart';
import 'package:badsound_counter_app/core/api/model/room_detail_response.dart';
import 'package:badsound_counter_app/core/api/model/room_response.dart';
import 'package:badsound_counter_app/core/api/model/update_notification_request.dart';
import 'package:badsound_counter_app/core/api/model/upload_request.dart';
import 'package:badsound_counter_app/core/api/model/user_nickname_request.dart';
import 'package:badsound_counter_app/core/api/model/violent_request.dart';
import 'package:badsound_counter_app/core/api/model/violent_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import 'model/chat_request.dart';
import 'model/friend_request.dart';
import 'model/me_response.dart';
import 'model/notification_config_response.dart';
import 'model/refresh_request.dart';
import 'model/upload_req_response.dart';

part 'open_api.g.dart';

@RestApi(baseUrl: 'https://bsc.chuyong.kr/app')
//@RestApi(baseUrl: 'http://192.168.50.81:8080/app')
abstract class OpenAPI {
  factory OpenAPI(Dio dio, {String baseUrl}) = _OpenAPI;

  //앱용 기본 API
  @GET('/upload-request?type=USER')
  Future<UploadRequestResponse> requestProfileImageUpload();

  @GET('/upload-request?type=ROOM')
  Future<UploadRequestResponse> requestRoomImageUpload(
      @Query("roomId") String roomId);

  // Auth (인증 관련) API
  @POST('/auth')
  Future<AuthResult> authenticate(@Body() AuthRequest request);

  @POST('/auth/device')
  Future<dynamic> registerDevice(@Body() DeviceRequest request);

  @POST('/auth/refresh')
  Future<AuthResult> refresh(@Body() RefreshRequest request);

  /// Me (나에 관한) API
  @GET('/me')
  Future<MeResponse> getMe();

  @GET('/me/dashboard')
  Future<DashboardResponse> getDashboard();

  @GET('/me/rooms')
  Future<List<RoomDetailResponse>> getMyRooms();

  @POST('/me/nickname')
  Future<MeResponse> updateNickname(@Body() UserNicknameRequest request);

  @POST('/me/profile-image')
  Future<MeResponse> updateProfileImage(@Body() UploadRequest request);

  @GET('/me/friends')
  Future<List<MeResponse>> getMyFriends();

  @POST('/me/friends')
  Future<dynamic> createFriend(@Body() FriendRequest request);

  @GET('/me/notification')
  Future<NotificationConfigResponse> getNotificationConfig();

  @POST('/me/notification')
  Future<NotificationConfigResponse> updateNotification(@Body() UpdateNotificationRequest request);

  //User (다른 사람) 관련 API
  @GET('/users/{userId}')
  Future<MeResponse> getUserById(@Path() String userId);

  @GET('/users')
  Future<MeResponse> getUserByTag(@Query("tag") String tag);

  //Room 관련 API
  @POST('/rooms')
  Future<RoomResponse> createNewRoom(@Body() RoomCreateRequest request);

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

  @POST('/rooms/{roomId}/profile-image')
  Future<RoomResponse> updateRoomImage(
      @Path() String roomId, @Body() UploadRequest request);

  @GET('/rooms/{roomId}/violents')
  Future<List<ViolentResponse>> getRoomViolents(@Path() String roomId);

  @POST('/rooms/{roomId}/violents')
  Future<ViolentResponse> createRoomViolent(
      @Path() String roomId, @Body() ViolentRequest request);

  @DELETE('/rooms/{roomId}/violents/{violentId}')
  Future<dynamic> deleteViolent(
      @Path() String roomId, @Path() String violentId);
}
