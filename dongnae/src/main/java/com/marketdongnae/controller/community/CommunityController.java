package com.marketdongnae.controller.community;



import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.attribute.UserPrincipal;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.annotations.Param;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.Property;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.SessionScope;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;
import com.marketdongnae.domain.community.CategoryDTO;
import com.marketdongnae.domain.community.CommentDTO;
import com.marketdongnae.domain.community.CommunityAllDTO;
import com.marketdongnae.domain.community.HeartDTO;
import com.marketdongnae.domain.community.PageDTO;
import com.marketdongnae.domain.community.communityDetailDTO;
import com.marketdongnae.domain.member.MemberDTO;
import com.marketdongnae.security.CustomAuthenticationProvider;
import com.marketdongnae.security.CustomUserDetails;
import com.marketdongnae.service.Community.CommunityService;
import com.marketdongnae.service.member.MemberService;

@Controller
public class CommunityController {
	@Autowired
	CommunityService communityService;
	
	private String extractImageUrlFromContent(String content) {
		  Document doc = Jsoup.parse(content);
		    Elements imgTags = doc.select("img"); // img 태그들을 선택

		    for (Element imgTag : imgTags) {
		        String imageUrl = imgTag.attr("src"); // img 태그의 src 속성 추출
		        if (!imageUrl.isEmpty()) {
		            return imageUrl; // 이미지 URL이 비어있지 않다면 반환
		        }
		    }

	    return ""; // 이미지가 없을 경우 빈 문자열 반환
	}
	
	@GetMapping("/community")
	public ModelAndView getCommunity(@RequestParam(value = "num", defaultValue = "1") int num) {
		CustomUserDetails customUserDetails = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		ModelAndView view = new ModelAndView();
		PageDTO page =new PageDTO();
		
		page.setNum(num);
		page.setCount(communityService.counts());
		
		List<CommunityAllDTO> list = communityService.listPage(page.getDisplayPost(), page.getPostNum());
		List<CategoryDTO> categorys = communityService.category();
		
		 for (CommunityAllDTO dto : list) {
		        String content = dto.getMu_detail();
		        String imageUrl = extractImageUrlFromContent(content); // 이미지 URL 추출 메서드 호출
		        dto.setPreviewImageUrl(imageUrl);
		    }

		
		view.addObject("member", customUserDetails);
		view.addObject("categorys", categorys);
		view.addObject("list",list);
		view.addObject("page", page);
		view.addObject("select", num);
		view.setViewName("community/community");
		
		return view;
	}

	@GetMapping("/pageCategory")
	public String getpageCategory(Model model,@RequestParam(value = "num", defaultValue = "1") int num,
											  @RequestParam(value = "ca_l") String ca_l) {
		CustomUserDetails customUserDetails = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		PageDTO page =new PageDTO();
		page.setNum(num);
		page.setCount(communityService.pageCategoryCount(ca_l));
		page.setCa_l(ca_l);
		
		List<CommunityAllDTO> list = null;
		list = communityService.pageCategory(page.getDisplayPost(), page.getPostNum(), ca_l);
		List<CategoryDTO> category = communityService.category();
		
		model.addAttribute("category", category);
		model.addAttribute("member",customUserDetails);
		model.addAttribute("list",list);
		model.addAttribute("page", page);
		model.addAttribute("select", num);
		
		return "community/communityCategory";
	}
	
	@ResponseBody
	@GetMapping("/communitySearch")
	public ModelAndView communitySearch(@RequestParam(value = "num", defaultValue = "1") int num,
										@RequestParam(value = "keyword") String keyword,
										@RequestParam(value = "searchType") String searchType) {
		ModelAndView view = new ModelAndView();
		PageDTO page =new PageDTO();
		CustomUserDetails customUserDetails = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		page.setNum(num);
		page.setCount(communityService.listPageSearchCount(searchType, keyword));
		page.setSearchType(searchType);
		page.setKeyword(keyword);
		List<CommunityAllDTO> list = null;
		list = communityService.listPageSearch(page.getDisplayPost(), page.getPostNum(), searchType, keyword);
		view.addObject("member",customUserDetails);
		view.addObject("list",list);
		view.addObject("page", page);
		view.addObject("select", num);
		view.setViewName("community/communitySearch");
		
		return view;
	}
	
	
	@GetMapping("/communityDetail")
	public ModelAndView communityDetail(@RequestParam("mu_id") String mu_id ,
										@RequestParam("m_number") String m_number,
										@RequestParam(value = "num", defaultValue = "1") int num){
		CustomUserDetails customUserDetails = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		ModelAndView view = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mu_id", mu_id);
		map.put("m_number", m_number);	
		
		CommunityAllDTO communityDetail = communityService.communityDetail(mu_id);
		communityService.updateCount(mu_id);
		
		HeartDTO heartview = communityService.heartview(m_number, mu_id); 
		 
		PageDTO page =new PageDTO();
		page.setNum(num);
		
		List<CommentDTO> lists  = communityService.selectComment(Integer.parseInt(mu_id));
		view.addObject("member",customUserDetails);
		view.addObject("page", page);
		view.addObject("comment",lists);
		view.addObject("communityDetail", communityDetail);
		view.addObject("heartview", heartview); 
		view.setViewName("community/communityDetail");
		
		return view;
	}
	
	
	
	@GetMapping("/insertCommunity")
	public String insertCommunity(Model model) {
		
		CustomUserDetails customUserDetails = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		model.addAttribute("member",customUserDetails);
		return "community/insertCommunity";
	}
	
	@PostMapping("/insertCommunity")
	public String insertCommunityPost(@ModelAttribute communityDetailDTO communityDetailDTO) {
		if (communityDetailDTO.getMu_name() !=null && communityDetailDTO.getMu_detail() !=null) {  
			communityService.insertCommunity(communityDetailDTO);
		}
		
		return "redirect:/community";
	}
	
	
	@ResponseBody
	@PostMapping("/upload")
	public String upload( @RequestParam("file") MultipartFile[] upload,HttpSession session) {
		JsonObject jsonObject = new JsonObject();
		String fileRoot = "C:\\Users\\jingyu\\git\\Spring_dongnaeMarket\\dongnae\\src\\main\\webapp\\resources\\upload\\community\\"; 
		for (MultipartFile multipartFile : upload) {
	        String originalFileName = multipartFile.getOriginalFilename(); // 오리지날 파일명
	        String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 파일 확장자
	        String savedFileName = UUID.randomUUID() + extension; // 저장될 파일 명
	        File targetFile = new File(fileRoot + savedFileName);
	        
	        try {
	            InputStream fileStream = multipartFile.getInputStream();
	            FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일 저장
	            jsonObject.addProperty("url", "/resources/upload/community/" + savedFileName); 
	            jsonObject.addProperty("responseCode", "success");

	        } catch (IOException e) {
	            FileUtils.deleteQuietly(targetFile); // 저장된 파일 삭제
	            jsonObject.addProperty("responseCode", "error");
	            e.printStackTrace();
	        }
	        
		}
		 String a = jsonObject.toString();
	
		 return a;
		
	}
	@RequestMapping(value = "/deleteSummernoteImageFile", produces = "application/json; charset=utf8")
	@ResponseBody
	public void deleteSummernoteImageFile(@RequestParam("file") String fileName) {
	    // 폴더 위치
	    String filePath = "C:\\Users\\jingyu\\git\\Spring_dongnaeMarket\\dongnae\\src\\main\\webapp\\resources\\upload\\community\\";
	    // 해당 파일 삭제
	    Path path = Paths.get(filePath, fileName);
	    try {
	        Files.delete(path);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	

	@GetMapping("/updateCommunity")
	public ModelAndView update(@RequestParam String mu_id,
							   @RequestParam(value = "num", defaultValue = "1") int num) {
		ModelAndView view = new ModelAndView();
		CommunityAllDTO detailDTO = communityService.communityDetail(mu_id);
		PageDTO page =new PageDTO();
		page.setNum(num);
		view.addObject("page", page);
		view.addObject("community",detailDTO);
		view.setViewName("community/updateCommunity");
		return view;
	}
	@PostMapping("/updateCommunity")
	public String updateCommunityPost(@ModelAttribute communityDetailDTO communityDetailDTO,
			 						  @RequestParam(value = "num", defaultValue = "1") int num,HttpSession session) {
		
		@SuppressWarnings("unchecked")
	    List<String> deletedImageNames = (List<String>) session.getAttribute("deletedImageNames");
		if (deletedImageNames != null && !deletedImageNames.isEmpty()) {
			
			
			
		}
		
		
		communityService.updateCommunity(communityDetailDTO);
		 session.removeAttribute("deletedImageNames");
		return "redirect:/communityDetail?mu_id="+communityDetailDTO.getMu_id()+
									   "&&m_number="+communityDetailDTO.getM_number()+	
									   "&&num="+num;
	}
	
	@ResponseBody
	@GetMapping("/deleteCommunity")
	public String deleteCommunity(@RequestParam("mu_id") int mu_id) {
		System.out.println("글삭제");
		System.out.println("community mu_id= "+mu_id);
		communityService.deleteCommunity(mu_id);
		return "success";
	}
	
	
	
	
	 @PostMapping("/heart") 
	 public  @ResponseBody  int heart(@ModelAttribute HeartDTO heart) { 
		  
		  int result = communityService.insertHeart(heart);
		  System.out.println(result);
		 return result;
	 }
	
	 @PostMapping("/comment")
	 public String comment(@ModelAttribute CommentDTO commentDTO) {
		 communityService.insertComment(commentDTO);
		 int m_ids = commentDTO.getMu_id();
		 String mu_id = String.valueOf(m_ids);

		 return "redirect:/communityDetail?mu_id="+mu_id+"&&m_number="+commentDTO.getM_number();
	 }
	 @ResponseBody
	 @PostMapping("/updateComment")
	 public String updateComment (@ModelAttribute CommentDTO CommentDTO ) {
		 // String data= null;
		 communityService.updateComment(CommentDTO);
		 return "success";
	 }
	 
	 @ResponseBody
	 @PostMapping("/deleteComment")
	 public String deleteComment (@ModelAttribute CommentDTO commentDTO) {
		communityService.deleteComment(commentDTO);
		 return "success";
	 }
	 
	
}