package com.cmc.service;

import java.util.Optional;

import com.cmc.model.RefreshToken;

public interface RefreshTokenService {

	public Optional<RefreshToken> findByToken(String token);

	public RefreshToken verifyExpiration(RefreshToken token);

	public int deleteByUserId(Long userId);
}
