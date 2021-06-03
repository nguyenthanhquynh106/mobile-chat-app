package com.cmc.service;

import org.springframework.http.ResponseEntity;

import com.cmc.request.LogOutRequest;
import com.cmc.request.LoginRequest;
import com.cmc.request.SignupRequest;
import com.cmc.request.TokenRefreshRequest;

public interface AuthService {

	public ResponseEntity<?> authenticateUser(LoginRequest loginRequest);

	public ResponseEntity<?> registerUser(SignupRequest signUpRequest);

	public ResponseEntity<?> refreshtoken(TokenRefreshRequest request);

	public ResponseEntity<?> logoutUser(LogOutRequest logOutRequest);

}