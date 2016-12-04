package cn.tf.blog.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cn.tf.blog.common.pojo.PageBean;
import cn.tf.blog.common.util.ResponseUtil;
import cn.tf.blog.common.util.StringUtil;
import cn.tf.blog.po.SType;
import cn.tf.blog.po.UBlog;
import cn.tf.blog.po.UBlogtype;
import cn.tf.blog.service.BlogService;
import cn.tf.blog.service.BlogTypeService;
import cn.tf.blog.service.STypeService;



import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;


/**
 * 管理员博客Controller层
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/user/blog")
public class BlogAdminController {

	@Resource
	private BlogTypeService blogTypeService;
	
	@Resource
	private BlogService blogService;
	
	@Autowired
	private STypeService typeService;
	
	// 博客索引
//	private BlogIndex blogIndex=new BlogIndex();
	
	
	
	//去写博客的页面
	//查询所有博客列表
	@RequestMapping("/toWrite")
	public String typelist(String username,Model  model){
		
		List<UBlogtype>   blogTypeCountList=blogTypeService.typelist(username);
		model.addAttribute("blogTypeCountList",blogTypeCountList);
		
		//官方提供的大类
		List<SType> typeCountList = typeService.typelist();
		model.addAttribute("typeCountList",typeCountList);
		
		
		return "writeBlog";
	}
	
	
	
	
	
	
	/**
	 * 添加或者修改博客信息
	 * @param blog
	 * @param response
	 * @return
	 * @throws Exception
	 */
	/*@RequestMapping("/save")
	public String save(UBlog blog,HttpServletResponse response)throws Exception{
		int resultTotal=0; // 操作的记录条数
		if(blog.getBlogid()==null){
			resultTotal=blogService.add(blog);
			blogIndex.addIndex(blog); // 添加博客索引
		}else{
			resultTotal=blogService.update(blog);
			blogIndex.updateIndex(blog); // 更新博客索引
		}
		JSONObject result=new JSONObject();
		if(resultTotal>0){
			result.put("success", true);
		}else{
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	
	*//**
	 * 分页查询博客信息
	 * @param page
	 * @param rows
	 * @param s_customer
	 * @param response
	 * @return
	 * @throws Exception
	 *//*
	@RequestMapping("/list")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,Blog s_blog,HttpServletResponse response)throws Exception{
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("title", StringUtil.formatLike(s_blog.getTitle()));
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<UBlog> blogList=blogService.list(map);
		Long total=blogService.getTotal(map);
		JSONObject result=new JSONObject();
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		JSONArray jsonArray=JSONArray.fromObject(blogList,jsonConfig);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	
	*//**
	 * 删除博客信息
	 * @param ids
	 * @param response
	 * @return
	 * @throws Exception
	 *//*
	@RequestMapping("/delete")
	public String delete(@RequestParam(value="ids")String ids,HttpServletResponse response)throws Exception{
		String []idsStr=ids.split(",");
		for(int i=0;i<idsStr.length;i++){
			blogService.delete(Integer.parseInt(idsStr[i]));
			blogIndex.deleteIndex(idsStr[i]); // 删除对应博客的索引
		}
		JSONObject result=new JSONObject();
		result.put("success", true);
		ResponseUtil.write(response, result);
		return null;
	}
	
	*//**
	 * 通过ID查找实体
	 * @param id
	 * @param response
	 * @return
	 * @throws Exception
	 *//*
	@RequestMapping("/findById")
	public String findById(@RequestParam(value="id")String id,HttpServletResponse response)throws Exception{
		UBlog blog=blogService.findById(Integer.parseInt(id));
		JSONObject jsonObject=JSONObject.fromObject(blog);
		ResponseUtil.write(response, jsonObject);
		return null;
	}
	
	*/
	
}