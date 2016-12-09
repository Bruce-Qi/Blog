package cn.tf.blog.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.tf.blog.po.SType;
import cn.tf.blog.pojo.ItemInfo;
import cn.tf.blog.service.ItemPortalService;
import cn.tf.blog.service.STypeService;


@Controller
public class ItemController {
	
	@Autowired
	private ItemPortalService itemPortalService;
	@Autowired
	private STypeService typeService;
	
	@RequestMapping("/item/{itemId}")
	public ModelAndView showItem(@PathVariable Long itemId,Model model){
		ModelAndView mav = new ModelAndView();
		ItemInfo item = itemPortalService.getItemById(itemId);
		
		//System.out.println("title:"+item.getTitle());
		
		mav.addObject("item",item);
		// 类别
		List<SType> typeList = typeService.typelist();
		model.addAttribute("typeList", typeList);
		
		
		mav.addObject("mainPage", "mall/item.jsp");
		mav.setViewName("mall");
		
		return mav;
	}
	
	@RequestMapping(value="/item/desc/{itemId}",produces=MediaType.TEXT_HTML_VALUE+";charset=utf-8")
	@ResponseBody
	public String getItemDesc(@PathVariable Long itemId){
		String string=itemPortalService.getItemDescById(itemId);
		return string;
	}
	
	@RequestMapping(value="/item/param/{itemId}",produces=MediaType.TEXT_HTML_VALUE+";charset=utf-8")
	@ResponseBody
	public String getItemParam(@PathVariable Long itemId){
		String string=itemPortalService.getItemParam(itemId);
		return string;
	}
	

}
