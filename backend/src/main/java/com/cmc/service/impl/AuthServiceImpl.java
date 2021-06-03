package com.cmc.service.impl;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.cmc.exception.TokenRefreshException;
import com.cmc.jwt.JwtUtils;
import com.cmc.model.ERole;
import com.cmc.model.RefreshToken;
import com.cmc.model.Role;
import com.cmc.model.User;
import com.cmc.repository.RoleRepository;
import com.cmc.repository.UserRepository;
import com.cmc.request.LogOutRequest;
import com.cmc.request.LoginRequest;
import com.cmc.request.SignupRequest;
import com.cmc.request.TokenRefreshRequest;
import com.cmc.response.JwtResponse;
import com.cmc.response.MessageResponse;
import com.cmc.response.TokenRefreshResponse;
import com.cmc.service.AuthService;
import com.cmc.service.RefreshTokenService;

@Service
public class AuthServiceImpl implements AuthService {
	
	@Autowired
	AuthenticationManager authenticationManager;

	@Autowired
	UserRepository userRepository;

	@Autowired
	RoleRepository roleRepository;

	@Autowired
	PasswordEncoder passwordEncoder;

	@Autowired
	JwtUtils jwtUtils;

	@Autowired
	RefreshTokenService refreshTokenService;

	public ResponseEntity<?> authenticateUser(LoginRequest loginRequest) {

		Authentication authentication = authenticationManager.authenticate(
				new UsernamePasswordAuthenticationToken(loginRequest.getUsername(), loginRequest.getPassword()));
		
		SecurityContextHolder.getContext().setAuthentication(authentication);

		UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

		List<String> roles = userDetails.getAuthorities().stream().map(item -> item.getAuthority())
				.collect(Collectors.toList());

		String jwt = jwtUtils.generateJWT(authentication);
		String jwtRefresh = jwtUtils.generateRefreshToken(authentication);
		
		return ResponseEntity.ok(new JwtResponse(jwt, jwtRefresh, userDetails.getId(), userDetails.getUsername(), userDetails.getEmail(), roles));
	}

	@Transactional
	public ResponseEntity<?> registerUser(SignupRequest signUpRequest) {
		if (userRepository.existsByUsername(signUpRequest.getUsername())) {
			return ResponseEntity.badRequest().body(new MessageResponse("Error: Username is already taken!"));
		}

		if (userRepository.existsByEmail(signUpRequest.getEmail())) {
			return ResponseEntity.badRequest().body(new MessageResponse("Error: Email is already in use!"));
		}

		// Create new user's account
		User user = new User(signUpRequest.getUsername(), signUpRequest.getEmail(), passwordEncoder.encode(signUpRequest.getPassword()));

		Role userRole = roleRepository.findByName(ERole.ROLE_USER).orElseThrow(() -> new RuntimeException("Error: Role is not found."));
		Set<Role> roles = new HashSet<>();
		roles.add(userRole);

		user.setRoles(roles);
		userRepository.save(user);

		return ResponseEntity.ok(new MessageResponse("User registered successfully!"));
	}

	@Transactional
	public ResponseEntity<?> refreshtoken(TokenRefreshRequest request) {
		String requestRefreshToken = request.getRefreshToken();

		RefreshToken refreshToken = refreshTokenService.findByToken(requestRefreshToken).orElseThrow(
				() -> new TokenRefreshException(requestRefreshToken, "Refresh token is not in database!"));
		
		refreshToken = refreshTokenService.verifyExpiration(refreshToken);	
		String token = jwtUtils.generateTokenFromUsername(refreshToken.getUsername());
		return ResponseEntity.ok(new TokenRefreshResponse(token, requestRefreshToken));
	}

	@Transactional
	public ResponseEntity<?> logoutUser(LogOutRequest logOutRequest) {
		refreshTokenService.deleteByUserId(logOutRequest.getUserId());
		return ResponseEntity.ok(new MessageResponse("Log out successful!"));
	}

}