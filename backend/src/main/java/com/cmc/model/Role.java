package com.cmc.model;

import javax.persistence.*;

@Entity
@Table(name = "roles")
public class Role extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@Enumerated(EnumType.STRING)
	@Column(length = 20)
	private ERole name;

	public ERole getName() {
		return name;
	}

	public void setName(ERole name) {
		this.name = name;
	}

}