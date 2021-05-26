package com.cmc.response;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

public class GeneralResponse<T> implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private GeneralResponseStatus status;
	private T data;

	public GeneralResponseStatus getStatus() {
		return status;
	}

	public void setStatus(GeneralResponseStatus status) {
		this.status = status;
	}

	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}

}
