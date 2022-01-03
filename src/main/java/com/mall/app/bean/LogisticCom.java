package com.mall.app.bean;

import java.io.Serializable;

public class LogisticCom implements Serializable {
	private static final long serialVersionUID = 1L;
	private int logisticId;
	private String comName;

	public int getLogisticId() {
		return logisticId;
	}
	public void setLogisticId(int logisticId) {
		this.logisticId = logisticId;
	}
	public String getComName() {
		return comName;
	}
	public void setComName(String comName) {
		this.comName = comName;
	}
}
