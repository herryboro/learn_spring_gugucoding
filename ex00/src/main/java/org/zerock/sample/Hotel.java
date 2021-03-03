package org.zerock.sample;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.ToString;

@Component
@ToString
@AllArgsConstructor
public class Hotel {
	
	private Chef chef;
	private Restaurant restaurant;

//	public Hotel(Chef chef) {
//		super();
//		this.chef = chef;
//	}
	
//	public Hotel(Restaurant restaurant) {
//		super();
//		this.restaurant = restaurant;
//	}
	
	
}
