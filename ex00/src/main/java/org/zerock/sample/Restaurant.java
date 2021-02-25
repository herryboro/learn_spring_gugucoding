package org.zerock.sample;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.Setter;
import lombok.ToString;

@Component
@ToString
@Data
public class Restaurant {
	
	// Setter주입 => @Setter(onMethod_ = {@Autowired}) ( 필드 위에 )
	// 생성자 주입	=> @AllArgsConstructor ( Restaurant클래스 위에 )
	// 필드 주입 =>@Autowired ( 필드 위에 )
	// 필드에 final 주고 Restaurant클래스 위에 @RequiredArgsConstructor 
	@Setter(onMethod_ = {@Autowired})
	private Chef chef;
}
