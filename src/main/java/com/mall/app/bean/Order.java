package com.mall.app.bean;

import java.io.Serializable;

public class Order implements Serializable {

	private static final long serialVersionUID = 1L;
	private int orderId;
	private int productId;
	private int ProductNum;
	private double price;
	private int buyerId;
	private int sellerId;
	private String orderTime;
 	private String buyerAddr;
	private String sellerAddr;
 	private int logisticId;
	private int status;
	private String productName;    // 商品名称
	private String comName;    // 物流公司名

	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getComName() {
		return comName;
	}
	public void setComName(String comName) {
		this.comName = comName;
	}
	public int getBuyerId() {
		return buyerId;
	}
	public void setBuyerId(int buyerId) {
		this.buyerId = buyerId;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public int getProductNum() {
		return ProductNum;
	}
	public void setProductNum(int ProductNum) {
		this.ProductNum = ProductNum;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getSellerId() {
		return sellerId;
	}
	public void setSellerId(int sellerId) {
		this.sellerId = sellerId;
	}
	public String getOrderTime() {
		return orderTime;
	}
	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}
	public String getBuyerAddr() {
		return buyerAddr;
	}
	public void setBuyerAddr(String buyerAddr) {
		this.buyerAddr = buyerAddr;
	}
	public String getSellerAddr() {
		return sellerAddr;
	}
	public void setSellerAddr(String sellerAddr) {
		this.sellerAddr = sellerAddr;
	}
	public int getLogisticId() {
		return logisticId;
	}
	public void setLogisticId(int logisticId) {
		this.logisticId = logisticId;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
}
