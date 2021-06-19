package com.cmc.model;

import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class ChatRoom {

	@Id
	private String id;
	private String chatId;
	private String senderId;
	private String recipientId;
}
