package org.zerock.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class MyLocVO {
	
	private String lng;
	private String lat;
	private Date inputDate;
	private String ip;

}
