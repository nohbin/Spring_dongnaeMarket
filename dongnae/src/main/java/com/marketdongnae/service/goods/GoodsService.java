package com.marketdongnae.service.goods;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.marketdongnae.domain.goods.GoodsDTO;

public interface GoodsService {

	List<GoodsDTO> getGoodsList();

	void insertGoods(GoodsDTO goodsDTO);

	void updateGoods(GoodsDTO goodsDTO);


}
