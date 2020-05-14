package com.project.vo;

public class VisitCountVO {
	
	 /*CREATE TABLE MP_VISITOR(
	    VISIT_ID INT PRIMARY KEY,	//접속자 id
	    VISIT_IP VARCHAR(100) NOT NULL, //접속자 ip
	    VISIT_AGENT VARCHAR(400) NOT NULL //브라우저 정보
	    );*/
	
	private int visit_id;
	private String visit_ip;
	private int visit_time;
	private String visit_agent;
	
	public int getVisit_id() {
		return visit_id;
	}
	public void setVisit_id(int visit_id) {
		this.visit_id = visit_id;
	}
	public String getVisit_ip() {
		return visit_ip;
	}
	public void setVisit_ip(String string) {
		this.visit_ip = string;
	}
	public int getVisit_time() {
		return visit_time;
	}
	public void setVisit_time(int visit_time) {
		this.visit_time = visit_time;
	}
	public String getVisit_agent() {
		return visit_agent;
	}
	public void setVisit_agent(String string) {
		this.visit_agent = string;
	}
	
}