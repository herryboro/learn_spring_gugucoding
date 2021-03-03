package org.zerock.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class TodoDTO {
	private String title;
	@DateTimeFormat(pattern = "yyyy/mm/dd")
	private Date dueDate;
}
