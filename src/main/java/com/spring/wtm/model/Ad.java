package com.spring.wtm.model;

import lombok.Data;

@Data
public class Ad {
	private int adid;
	private String adname;
	private String adstart;
	private String adend;
	private String adimg;
	private String adlink;
	private int adorder;
	private String reg_date;
	private String edit_date;
}
