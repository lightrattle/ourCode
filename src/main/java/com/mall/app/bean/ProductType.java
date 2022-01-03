package com.mall.app.bean;

import java.io.Serializable;

public class ProductType implements Serializable {
	private static final long serialVersionUID = 1L;
	private int productTypeId;
	private String productTypeName;
	
	public int getProductTypeId() {
		return productTypeId;
	}
	public void setProductTypeId(int productTypeId) {
		this.productTypeId = productTypeId;
	}
	public String getProductTypeName() {
		return productTypeName;
	}
	public void setProductTypeName(String productTypeName) {
		this.productTypeName = productTypeName;
	}
}
