package com.cmc.response;

public enum ResponseStatusEnum {

	SUCCESS("SUCCESS", "Request successfully"), UNKNOWN_ERROR("E-000", "Can not specify error"),
	NOT_ENOUGH_PARAM("E-001", "Not enough param in request"),
	PASSWORD_ERROR("E-002", "Password must be between 8 and 50 character including numbers and letters"),
	USERNAME_ERROR("E-003", "Username must be between 8 and 50 character including numbers and letters"),
	WRONG_USERNAME_OR_PASSWORD("E-004", "Username or password is wrong"),
	NAME_ERROR("E-005", "Name must be characters"), USER_EXIST("E-006", "User already exists"),
	EMAIL_EXIST("E-007", "Email was registered"), EMAIL_ERROR("E-008", "Email is wrong format"),
	RETYPE_ERROR("E-009", "Retype is wrong"), RETYPE_OLD_PASSWORD_ERROR("E-010", "Password is wrong"),
	NOT_EXIST("E-011", "Account not exists"), NOT_UPDATE_ADMIN("E-012", "Can not delete admin"),
	ACCOUNT_LOGGED_IN("E-013", "Account is logged in");

	private final String code;
	private final String message;

	public String getCode() {
		return code;
	}

	public String getMessage() {
		return message;
	}

	ResponseStatusEnum(String code, String message) {
		this.code = code;
		this.message = message;
	}
}
