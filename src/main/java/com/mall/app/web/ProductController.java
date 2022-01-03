package com.mall.app.web;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.mall.app.bean.Product;
import com.mall.app.bean.User;
import com.mall.app.service.impl.ProductServiceImpl;

@RestController
@RequestMapping("/product")
public class ProductController {
	@Autowired
	private ProductServiceImpl impl;
	/*添加商品*/
	@RequestMapping("/addProduct")
	public boolean addProduct(Product product) {
		User user=(User)SecurityUtils.getSubject().getSession().getAttribute("user");
		product.setSellerId(user.getUserId());
		return impl.addProduct(product);
	}
	/*删除商品 */
	@RequestMapping("/removeProduct")
	public boolean removeProduct(@RequestParam("pids[]")String[] pids) {
		return impl.removeProduct(pids);
	}
	/*更新商品*/
	@RequestMapping("/updateProduct")
	public boolean updateProduct(Product product) {
		return impl.updateProduct(product);
	}
	@RequestMapping(value="/addProductpic",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	public String addProductpic(@RequestParam MultipartFile file,HttpSession session,HttpServletRequest request) {
		String fileName = file.getOriginalFilename();  // 文件名
        String suffixName = fileName.substring(fileName.lastIndexOf("."));  // 后缀名
        String filePath = session.getServletContext().getRealPath("/")+"img\\";
        int productId = Integer.parseInt(request.getParameter("productId"));

        fileName = UUID.randomUUID() + suffixName; // 新文件名
        File dest = new File(filePath + fileName);
        if (!dest.getParentFile().exists()) {
            dest.getParentFile().mkdirs();
        }
        JSONObject j=new JSONObject();
        try {
            file.transferTo(dest);
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("productId", productId);
            map.put("productImage",fileName);
            impl.updateProductPic(map);
            j.put("success", true);
            j.put("fileName", fileName);
        } catch (IOException e) {
            e.printStackTrace();
            j.put("success", false);
        }
        return j.toJSONString();
	}
	/*查询商品信息*/
	@RequestMapping("/listProduct")
	public Map<String, Object> listProduct(int page,int limit,Integer productTypeId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", (page-1)*limit );
		map.put("size", limit );
		map.put("productTypeId", productTypeId);
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		map.put("sellerId", user.getUserId());
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0 );
		result.put("msg", "" );
		result.put("count", impl.getCountProduct(map));
		result.put("data", impl.listProduct(map));
		return result;
	}
	/*查询商品数*/
	@RequestMapping("/getCountProduct")
	public int getCountProduct() {
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute("user");
		map.put("sellerId", user.getUserId());
		return impl.getCountProduct(map);
	}
	/*更新商品状态：上下架*/
	@RequestMapping("/setProductState")
	public boolean setProductState(int productId,int state) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productId", productId );
		map.put("state", state );
		return impl.setProductState(map);
	}
	/*更新商品库存*/
	@RequestMapping("/setProductStorage")
	public boolean setProductStorage(int productId,int storage) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productId", productId );
		map.put("storage", storage );
		return impl.setProductStorage(map);
	}
}
