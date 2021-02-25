package org.zerock.sample;

import org.springframework.stereotype.Component;

import lombok.ToString;

@Component
@ToString
public class Hotel {
	
	private Chef chef;

	public Hotel(Chef chef) {
		super();
		this.chef = chef;
	}
	
	
}
