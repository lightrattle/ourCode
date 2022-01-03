package com.mall.app.bean;

import java.io.Serializable;

public class Goods implements Serializable {

	private static final long serialVersionUID = 1L;
	private int product_id;
	private int seller_id;
	private int product_type_id;
	private String product_name;
	private String product_image;
	private double price;
	private double discount_price;
	private int storage;
	private int sale;
	private int state;
	private String create_time;
	private String modify_time;
	
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public int getSeller_id() {
		return seller_id;
	}
	public void setSeller_id(int seller_id) {
		this.seller_id = seller_id;
	}
	public int getProduct_type_id() {
		return product_type_id;
	}
	public void setProduct_type_id(int product_type_id) {
		this.product_type_id = product_type_id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_image() {
		return product_image;
	}
	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public double getDiscount_price() {
		return discount_price;
	}
	public void setDiscount_price(double discount_price) {
		this.discount_price = discount_price;
	}
	public int getStorage() {
		return storage;
	}
	public void setStorage(int storage) {
		this.storage = storage;
	}
	public int getSale() {
		return sale;
	}
	public void setSale(int sale) {
		this.sale = sale;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getCreate_time() {
		return create_time;
	}
	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}
	public String getModify_time() {
		return modify_time;
	}
	public void setModify_time(String modify_time) {
		this.modify_time = modify_time;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
	
}
