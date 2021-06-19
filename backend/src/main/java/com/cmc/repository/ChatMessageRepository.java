package com.cmc.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.cmc.model.ChatMessage;
import com.cmc.model.MessageStatus;

@Repository
public interface ChatMessageRepository extends JpaRepository<ChatMessage, String> {

	long countBySenderIdAndRecipientIdAndStatus(String senderId, String recipientId, MessageStatus status);

	List<ChatMessage> findByChatId(String chatId);

	Optional<ChatMessage> findBySenderIdAndRecipientId(String senderId, String recipientId);
}
