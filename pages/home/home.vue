<!-- 首页 -->
<template>
	<view class="home">
		<view class="home-top-tab">
			<scroll-view scroll-x="true" :show-scrollbar="isScrollbar">
				<home-tab id="tabbar" :values="items" :stickyTop="108" :current="current" @clickItem="onClickItem"></home-tab>
			</scroll-view>
			<view class="home-top-tab-content">
				<!-- 首页 -->
				<view class="httc-content-home" v-if="current == 0">
					<home-swiper :lists="swiperLists" @clickImgItem="handleImg"></home-swiper>
					<!-- 选项列表 -->
					<view class="httc-content-list">
						<view class="httccl-content" v-for="(item,index) in homeLists" :key="index" @click="handleHomeList(index)">
							<image :src="item.list_icon" mode=""></image>
							<text>{{item.list_name}}</text>
						</view>
					</view>
					<!-- 选项内容 -->
					<view class="httc-content-list-detail">
						<!-- 限时抢购 -->
						<view class="httccld-class" @click="handleToFlash">
							<view class="httccld-class-title">
								<text>限时抢购</text>
							</view>
							<view class="httccld-class-title-bottom">
								<view class="httccld-class-title-des">
									<text class="httccld-class-title-des-text">限时半价</text>
									<image src="../../static/images01/mc-11.jpg" mode=""></image>
								</view>
								<view class="httccld-class-title-des">
									<text class="httccld-class-title-des-text">买好茶</text>
									<image src="../../static/images01/mc-12.jpg" mode=""></image>
								</view>
							</view>
						</view>
						<!-- 天天特卖 -->
						<view class="httccld-class" @click="handleToSpecial">
							<view class="httccld-class-title">
								<text>天天特卖</text>
							</view>
							<view class="httccld-class-title-bottom">
								<view class="httccld-class-title-des">
									<text class="httccld-class-title-des-text">源头好货</text>
									<image src="../../static/images01/mc-13.jpg" mode=""></image>
								</view>
								<view class="httccld-class-title-des">
									<text class="httccld-class-title-des-text">9.9元包邮</text>
									<image src="../../static/images01/mc-14.jpg" mode=""></image>
								</view>
							</view>
						</view>
						<!-- 每日好店 -->
						<view class="httccld-class" @click="handleToShop">
							<view class="httccld-class-title">
								<text>每日好店</text>
							</view>
							<view class="httccld-class-title-bottom">
								<view class="httccld-class-title-des">
									<text class="httccld-class-title-des-text">寻深藏的店</text>
									<image src="../../static/images01/mc-41.jpg" mode=""></image>
								</view>
								<view class="httccld-class-title-des">
									<text class="httccld-class-title-des-text">好店</text>
									<image src="../../static/images01/mc-42.jpg" mode=""></image>
								</view>
							</view>
						</view>
						<!-- 有好茶 -->
						<view class="httccld-class" @click="handleToTea">
							<view class="httccld-class-title">
								<text>有好茶</text>
								<view class="httccld-class-title-t">
									<text>品质好茶</text>
								</view>
							</view>
							<view class="httccld-class-title-bottom">
								<view class="httccld-class-title-des">
									<text class="httccld-class-title-des-text">发现好茶</text>
									<image src="../../static/images01/mc-51.jpg" mode=""></image>
								</view>
								<view class="httccld-class-title-des">
									<text class="httccld-class-title-des-text">好礼佳选</text>
									<image src="../../static/images01/mc-52.jpg" mode=""></image>
								</view>
							</view>
						</view>
						<!-- 拼团热购 -->
						<view class="httccld-class" @click="handleToTeam">
							<view class="httccld-class-title">
								<text>拼团热购</text>
							</view>
							<view class="httccld-class-title-bottom">
								<view class="httccld-class-title-des">
									<text class="httccld-class-title-des-text">拼团购茶</text>
									<image src="../../static/images01/mc-61.jpg" mode=""></image>
								</view>
								<view class="httccld-class-title-des">
									<text class="httccld-class-title-des-text">有趣有料</text>
									<image src="../../static/images01/mc-62.jpg" mode=""></image>
								</view>
							</view>
						</view>
						<!-- 好礼佳选 -->
						<view class="httccld-class" @click="handleTovideo">
							<view class="httccld-class-title">
								<text>好礼佳选</text>
							</view>
							<view class="httccld-class-title-bottom">
								<view class="httccld-class-title-des">
									<text class="httccld-class-title-des-text">购物赠人</text>
									<image src="../../static/images01/mc-31.jpg" mode=""></image>
								</view>
								<view class="httccld-class-title-des">
									<text class="httccld-class-title-des-text">佳选</text>
									<image src="../../static/images01/mc-32.jpg" mode=""></image>
								</view>
							</view>
						</view>
						<!-- 茶店头条 -->
						<view class="httccld-special">
							<text>茶店头条</text>
							<view class="httccld-special-text-swiper">
								<swiper class="swiper" :autoplay="autoplay" :interval="interval" :vertical="vertical" :circular="circular">
									<swiper-item v-for="(item,index) in textLists" :key="index">
										<text>{{item}}</text>
									</swiper-item>
								</swiper>
							</view>
						</view>
					</view>
					<!-- 图片 -->
					<view class="httc-content-image">
						<image src="../../static/images01/01.jpg" mode=""></image>
					</view>
					<!-- 商品列表tiele -->
					<view class="httc-content-goods-title">
						<view :class="['httccgt-default',goodsCurrent==0?'httccgt-active':'']" @click="goodsCurrent=0">
							<text>全部</text>
							<text class="httc-content-goods-title-text">猜你喜欢</text>
						</view>
						<view :class="['httccgt-default',goodsCurrent==1?'httccgt-active':'']" @click="goodsCurrent=1">
							<text>热销</text>
							<text class="httc-content-goods-title-text">最多人买</text>
						</view>
						<view :class="['httccgt-default',goodsCurrent==2?'httccgt-active':'']" @click="goodsCurrent=2">
							<text>便宜好货</text>
							<text class="httc-content-goods-title-text">低价购物</text>
						</view>
					</view>
					<!-- 商品列表 -->
					<view class="httc-content-goods">
						<view class="httccg-a" v-show="goodsCurrent == 0">
							<view class="home-goods-introduce-list" v-for="(item,index) in allGoods" :key="index" @click="handleGoods(item)">
								<home-goods-introduce :lists="item"></home-goods-introduce>
							</view>
						</view>
						<view class="httccg-a" v-show="goodsCurrent == 1">
							<view class="home-goods-introduce-list" v-for="(item,index) in hotGoods" :key="index" @click="handleGoods(item)">
								<home-goods-introduce :lists="item"></home-goods-introduce>
							</view>
						</view>
						<view class="httccg-a" v-show="goodsCurrent == 2">
							<view class="home-goods-introduce-list" v-for="(item,index) in discountGoods" :key="index" @click="handleGoods(item)">
								<home-goods-introduce :lists="item"></home-goods-introduce>
							</view>
						</view>
					</view>
				</view>
				<!-- 黑茶 -->
				<view class="httc-content-other" v-else-if="current == 1">
					<!-- 分类 -->
					<view class="httc-content-other-list">
						<view class="httccol-content" v-for="(item,index) in goodsClass" :key="index" @click="handleG(index)">
							<image :src="item.c_src" mode=""></image>
							<text>{{item.c_name}}</text>
						</view>
					</view>
					<!-- 轮播 -->
					<view class="httc-content-other-img">
						<home-swiper :lists="swiperLists" :indicatorDots="indicatorDots" @clickImgItem="handleImg"></home-swiper>
					</view>
					<!-- 茶店严选精品 -->
					<view class="httc-content-other-choose">
						<view class="httccoc-title">
							<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
							<text>茶店严选精品</text>
						</view>
						<view class="httccoc-list">
							<view class="httccoc-list-content" v-for="(item,index) in discountGoods" :key="index" @click="handleGoods(item)">
								<image :src="item.g_src" mode=""></image>
								<text>{{item.g_name}}</text>
								<text class="httccoc-list-content-sale-price">￥{{item.g_price}}</text>
								<text class="httccoc-list-content-sale-person">热销{{item.g_buy_num}}件</text>
							</view>
						</view>
					</view>
					<!-- 爆款推荐 -->
					<view class="httc-content-other-choose">
						<view class="httccoc-title">
							<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
							<text>爆款推荐</text>
						</view>
						<view class="httccoc-list">
							<view class="httccoc-list-content" v-for="(item,index) in hotGoods" :key="index" @click="handleGoods(item)">
								<image :src="item.g_src" mode=""></image>
								<text>{{item.g_name}}</text>
								<text class="httccoc-list-content-sale-price">￥{{item.g_price}}</text>
								<text class="httccoc-list-content-sale-person">热销{{item.g_buy_num}}件</text>
							</view>
						</view>
					</view>
					<!-- 更多热卖 -->
					<view class="httc-content-other-more">
						<view class="httccom-title">
							—— 更多热卖 ——
						</view>
						<view class="httccom-c">
							<view class="home-goods-introduce-list" v-for="(item,index) in allGood" :key="index" @click="handleGoods(item)">
								<home-goods-introduce :lists="item"></home-goods-introduce>
							</view>
						</view>
					</view>
				</view>
				<!-- 白茶 -->
				<view class="httc-content-other" v-else-if="current == 2">
					<!-- 分类 -->
					<view class="httc-content-other-list">
						<view class="httccol-content" v-for="(item,index) in goodsClass" :key="index" @click="handleG(index)">
							<image :src="item.c_src" mode=""></image>
							<text>{{item.c_name}}</text>
						</view>
					</view>
					<!-- 轮播 -->
					<view class="httc-content-other-img">
						<home-swiper :lists="swiperLists" :indicatorDots="indicatorDots" @clickImgItem="handleImg"></home-swiper>
					</view>
					<!-- 茶店严选精品 -->
					<view class="httc-content-other-choose">
						<view class="httccoc-title">
							<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
							<text>茶店严选精品</text>
						</view>
						<view class="httccoc-list">
							<view class="httccoc-list-content" v-for="(item,index) in discountGoods" :key="index" @click="handleGoods(item)">
								<image :src="item.g_src" mode=""></image>
								<text>{{item.g_name}}</text>
								<text class="httccoc-list-content-sale-price">￥{{item.g_price}}</text>
								<text class="httccoc-list-content-sale-person">热销{{item.g_buy_num}}件</text>
							</view>
						</view>
					</view>
					<!-- 爆款推荐 -->
					<view class="httc-content-other-choose">
						<view class="httccoc-title">
							<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
							<text>爆款推荐</text>
						</view>
						<view class="httccoc-list">
							<view class="httccoc-list-content" v-for="(item,index) in hotGoods" :key="index" @click="handleGoods(item)">
								<image :src="item.g_src" mode=""></image>
								<text>{{item.g_name}}</text>
								<text class="httccoc-list-content-sale-price">￥{{item.g_price}}</text>
								<text class="httccoc-list-content-sale-person">热销{{item.g_buy_num}}件</text>
							</view>
						</view>
					</view>
					<!-- 更多热卖 -->
					<view class="httc-content-other-more">
						<view class="httccom-title">
							—— 更多热卖 ——
						</view>
						<view class="httccom-c">
							<view class="home-goods-introduce-list" v-for="(item,index) in allGood" :key="index" @click="handleGoods(item)">
								<home-goods-introduce :lists="item"></home-goods-introduce>
							</view>
						</view>
					</view>
				</view>
				<!-- 红茶 -->
				<view class="httc-content-other" v-else-if="current == 3">
					<!-- 分类 -->
					<view class="httc-content-other-list">
						<view class="httccol-content" v-for="(item,index) in goodsClass" :key="index" @click="handleG(index)">
							<image :src="item.c_src" mode=""></image>
							<text>{{item.c_name}}</text>
						</view>
					</view>
					<!-- 轮播 -->
					<view class="httc-content-other-img">
						<home-swiper :lists="swiperLists" :indicatorDots="indicatorDots" @clickImgItem="handleImg"></home-swiper>
					</view>
					<!-- 茶店严选精品 -->
					<view class="httc-content-other-choose">
						<view class="httccoc-title">
							<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
							<text>茶店严选精品</text>
						</view>
						<view class="httccoc-list">
							<view class="httccoc-list-content" v-for="(item,index) in discountGoods" :key="index" @click="handleGoods(item)">
								<image :src="item.g_src" mode=""></image>
								<text>{{item.g_name}}</text>
								<text class="httccoc-list-content-sale-price">￥{{item.g_price}}</text>
								<text class="httccoc-list-content-sale-person">热销{{item.g_buy_num}}件</text>
							</view>
						</view>
					</view>
					<!-- 爆款推荐 -->
					<view class="httc-content-other-choose">
						<view class="httccoc-title">
							<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
							<text>爆款推荐</text>
						</view>
						<view class="httccoc-list">
							<view class="httccoc-list-content" v-for="(item,index) in hotGoods" :key="index" @click="handleGoods(item)">
								<image :src="item.g_src" mode=""></image>
								<text>{{item.g_name}}</text>
								<text class="httccoc-list-content-sale-price">￥{{item.g_price}}</text>
								<text class="httccoc-list-content-sale-person">热销{{item.g_buy_num}}件</text>
							</view>
						</view>
					</view>
					<!-- 更多热卖 -->
					<view class="httc-content-other-more">
						<view class="httccom-title">
							—— 更多热卖 ——
						</view>
						<view class="httccom-c">
							<view class="home-goods-introduce-list" v-for="(item,index) in allGood" :key="index" @click="handleGoods(item)">
								<home-goods-introduce :lists="item"></home-goods-introduce>
							</view>
						</view>
					</view>
				</view>
				<!-- 绿茶 -->
				<view class="httc-content-other" v-else-if="current == 4">
					<!-- 分类 -->
					<view class="httc-content-other-list">
						<view class="httccol-content" v-for="(item,index) in goodsClass" :key="index" @click="handleG(index)">
							<image :src="item.c_src" mode=""></image>
							<text>{{item.c_name}}</text>
						</view>
					</view>
					<!-- 轮播 -->
					<view class="httc-content-other-img">
						<home-swiper :lists="swiperLists" :indicatorDots="indicatorDots" @clickImgItem="handleImg"></home-swiper>
					</view>
					<!-- 茶店严选精品 -->
					<view class="httc-content-other-choose">
						<view class="httccoc-title">
							<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
							<text>茶店严选精品</text>
						</view>
						<view class="httccoc-list">
							<view class="httccoc-list-content" v-for="(item,index) in discountGoods" :key="index" @click="handleGoods(item)">
								<image :src="item.g_src" mode=""></image>
								<text>{{item.g_name}}</text>
								<text class="httccoc-list-content-sale-price">￥{{item.g_price}}</text>
								<text class="httccoc-list-content-sale-person">热销{{item.g_buy_num}}件</text>
							</view>
						</view>
					</view>
					<!-- 爆款推荐 -->
					<view class="httc-content-other-choose">
						<view class="httccoc-title">
							<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
							<text>爆款推荐</text>
						</view>
						<view class="httccoc-list">
							<view class="httccoc-list-content" v-for="(item,index) in hotGoods" :key="index" @click="handleGoods(item)">
								<image :src="item.g_src" mode=""></image>
								<text>{{item.g_name}}</text>
								<text class="httccoc-list-content-sale-price">￥{{item.g_price}}</text>
								<text class="httccoc-list-content-sale-person">热销{{item.g_buy_num}}件</text>
							</view>
						</view>
					</view>
					<!-- 更多热卖 -->
					<view class="httc-content-other-more">
						<view class="httccom-title">
							—— 更多热卖 ——
						</view>
						<view class="httccom-c">
							<view class="home-goods-introduce-list" v-for="(item,index) in allGood" :key="index" @click="handleGoods(item)">
								<home-goods-introduce :lists="item"></home-goods-introduce>
							</view>
						</view>
					</view>
				</view>
				<!-- 乌龙茶 -->
				<view class="httc-content-other" v-else-if="current == 5">
					<!-- 分类 -->
					<view class="httc-content-other-list">
						<view class="httccol-content" v-for="(item,index) in goodsClass" :key="index" @click="handleG(index)">
							<image :src="item.c_src" mode=""></image>
							<text>{{item.c_name}}</text>
						</view>
					</view>
					<!-- 轮播 -->
					<view class="httc-content-other-img">
						<home-swiper :lists="swiperLists" :indicatorDots="indicatorDots" @clickImgItem="handleImg"></home-swiper>
					</view>
					<!-- 茶店严选精品 -->
					<view class="httc-content-other-choose">
						<view class="httccoc-title">
							<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
							<text>茶店严选精品</text>
						</view>
						<view class="httccoc-list">
							<view class="httccoc-list-content" v-for="(item,index) in discountGoods" :key="index" @click="handleGoods(item)">
								<image :src="item.g_src" mode=""></image>
								<text>{{item.g_name}}</text>
								<text class="httccoc-list-content-sale-price">￥{{item.g_price}}</text>
								<text class="httccoc-list-content-sale-person">热销{{item.g_buy_num}}件</text>
							</view>
						</view>
					</view>
					<!-- 爆款推荐 -->
					<view class="httc-content-other-choose">
						<view class="httccoc-title">
							<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
							<text>爆款推荐</text>
						</view>
						<view class="httccoc-list">
							<view class="httccoc-list-content" v-for="(item,index) in hotGoods" :key="index" @click="handleGoods(item)">
								<image :src="item.g_src" mode=""></image>
								<text>{{item.g_name}}</text>
								<text class="httccoc-list-content-sale-price">￥{{item.g_price}}</text>
								<text class="httccoc-list-content-sale-person">热销{{item.g_buy_num}}件</text>
							</view>
						</view>
					</view>
					<!-- 更多热卖 -->
					<view class="httc-content-other-more">
						<view class="httccom-title">
							—— 更多热卖 ——
						</view>
						<view class="httccom-c">
							<view class="home-goods-introduce-list" v-for="(item,index) in allGood" :key="index" @click="handleGoods(item)">
								<home-goods-introduce :lists="item"></home-goods-introduce>
							</view>
						</view>
					</view>
				</view>
				<!-- 花茶 -->
				<view class="httc-content-other" v-else-if="current == 6">
					<!-- 分类 -->
					<view class="httc-content-other-list">
						<view class="httccol-content" v-for="(item,index) in goodsClass" :key="index" @click="handleG(index)">
							<image :src="item.c_src" mode=""></image>
							<text>{{item.c_name}}</text>
						</view>
					</view>
					<!-- 轮播 -->
					<view class="httc-content-other-img">
						<home-swiper :lists="swiperLists" :indicatorDots="indicatorDots" @clickImgItem="handleImg"></home-swiper>
					</view>
					<!-- 茶店严选精品 -->
					<view class="httc-content-other-choose">
						<view class="httccoc-title">
							<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
							<text>茶店严选精品</text>
						</view>
						<view class="httccoc-list">
							<view class="httccoc-list-content" v-for="(item,index) in discountGoods" :key="index" @click="handleGoods(item)">
								<image :src="item.g_src" mode=""></image>
								<text>{{item.g_name}}</text>
								<text class="httccoc-list-content-sale-price">￥{{item.g_price}}</text>
								<text class="httccoc-list-content-sale-person">热销{{item.g_buy_num}}件</text>
							</view>
						</view>
					</view>
					<!-- 爆款推荐 -->
					<view class="httc-content-other-choose">
						<view class="httccoc-title">
							<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
							<text>爆款推荐</text>
						</view>
						<view class="httccoc-list">
							<view class="httccoc-list-content" v-for="(item,index) in hotGoods" :key="index" @click="handleGoods(item)">
								<image :src="item.g_src" mode=""></image>
								<text>{{item.g_name}}</text>
								<text class="httccoc-list-content-sale-price">￥{{item.g_price}}</text>
								<text class="httccoc-list-content-sale-person">热销{{item.g_buy_num}}件</text>
							</view>
						</view>
					</view>
					<!-- 更多热卖 -->
					<view class="httc-content-other-more">
						<view class="httccom-title">
							—— 更多热卖 ——
						</view>
						<view class="httccom-c">
							<view class="home-goods-introduce-list" v-for="(item,index) in allGood" :key="index" @click="handleGoods(item)">
								<home-goods-introduce :lists="item"></home-goods-introduce>
							</view>
						</view>
					</view>
				</view>
				<!-- 黄茶 -->
				<view class="httc-content-other" v-else-if="current == 7">
					<!-- 分类 -->
					<view class="httc-content-other-list">
						<view class="httccol-content" v-for="(item,index) in goodsClass" :key="index" @click="handleG(index)">
							<image :src="item.c_src" mode=""></image>
							<text>{{item.c_name}}</text>
						</view>
					</view>
					<!-- 轮播 -->
					<view class="httc-content-other-img">
						<home-swiper :lists="swiperLists" :indicatorDots="indicatorDots" @clickImgItem="handleImg"></home-swiper>
					</view>
					<!-- 茶店严选精品 -->
					<view class="httc-content-other-choose">
						<view class="httccoc-title">
							<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
							<text>茶店严选精品</text>
						</view>
						<view class="httccoc-list">
							<view class="httccoc-list-content" v-for="(item,index) in discountGoods" :key="index" @click="handleGoods(item)">
								<image :src="item.g_src" mode=""></image>
								<text>{{item.g_name}}</text>
								<text class="httccoc-list-content-sale-price">￥{{item.g_price}}</text>
								<text class="httccoc-list-content-sale-person">热销{{item.g_buy_num}}件</text>
							</view>
						</view>
					</view>
					<!-- 爆款推荐 -->
					<view class="httc-content-other-choose">
						<view class="httccoc-title">
							<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
							<text>爆款推荐</text>
						</view>
						<view class="httccoc-list">
							<view class="httccoc-list-content" v-for="(item,index) in hotGoods" :key="index" @click="handleGoods(item)">
								<image :src="item.g_src" mode=""></image>
								<text>{{item.g_name}}</text>
								<text class="httccoc-list-content-sale-price">￥{{item.g_price}}</text>
								<text class="httccoc-list-content-sale-person">热销{{item.g_buy_num}}件</text>
							</view>
						</view>
					</view>
					<!-- 更多热卖 -->
					<view class="httc-content-other-more">
						<view class="httccom-title">
							—— 更多热卖 ——
						</view>
						<view class="httccom-c">
							<view class="home-goods-introduce-list" v-for="(item,index) in allGood" :key="index" @click="handleGoods(item)">
								<home-goods-introduce :lists="item"></home-goods-introduce>
							</view>
						</view>
					</view>
				</view>
				<!-- 茶具 -->
				<view class="httc-content-other" v-else-if="current == 8">
					<!-- 分类 -->
					<view class="httc-content-other-list">
						<view class="httccol-content" v-for="(item,index) in goodsClass" :key="index" @click="handleG(index)">
							<image :src="item.c_src" mode=""></image>
							<text>{{item.c_name}}</text>
						</view>
					</view>
					<!-- 轮播 -->
					<view class="httc-content-other-img">
						<home-swiper :lists="swiperLists" :indicatorDots="indicatorDots" @clickImgItem="handleImg"></home-swiper>
					</view>
					<!-- 茶店严选精品 -->
					<view class="httc-content-other-choose">
						<view class="httccoc-title">
							<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
							<text>茶店严选精品</text>
						</view>
						<view class="httccoc-list">
							<view class="httccoc-list-content" v-for="(item,index) in discountGoods" :key="index" @click="handleGoods(item)">
								<image :src="item.g_src" mode=""></image>
								<text>{{item.g_name}}</text>
								<text class="httccoc-list-content-sale-price">￥{{item.g_price}}</text>
								<text class="httccoc-list-content-sale-person">热销{{item.g_buy_num}}件</text>
							</view>
						</view>
					</view>
					<!-- 爆款推荐 -->
					<view class="httc-content-other-choose">
						<view class="httccoc-title">
							<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
							<text>爆款推荐</text>
						</view>
						<view class="httccoc-list">
							<view class="httccoc-list-content" v-for="(item,index) in hotGoods" :key="index" @click="handleGoods(item)">
								<image :src="item.g_src" mode=""></image>
								<text>{{item.g_name}}</text>
								<text class="httccoc-list-content-sale-price">￥{{item.g_price}}</text>
								<text class="httccoc-list-content-sale-person">热销{{item.g_buy_num}}件</text>
							</view>
						</view>
					</view>
					<!-- 更多热卖 -->
					<view class="httc-content-other-more">
						<view class="httccom-title">
							—— 更多热卖 ——
						</view>
						<view class="httccom-c">
							<view class="home-goods-introduce-list" v-for="(item,index) in allGood" :key="index" @click="handleGoods(item)">
								<home-goods-introduce :lists="item"></home-goods-introduce>
							</view>
						</view>
					</view>
				</view>
				<!-- 茶壶 -->
				<view class="httc-content-other" v-else-if="current == 9">
					<!-- 分类 -->
					<view class="httc-content-other-list">
						<view class="httccol-content" v-for="(item,index) in goodsClass" :key="index" @click="handleG(index)">
							<image :src="item.c_src" mode=""></image>
							<text>{{item.c_name}}</text>
						</view>
					</view>
					<!-- 轮播 -->
					<view class="httc-content-other-img">
						<home-swiper :lists="swiperLists" :indicatorDots="indicatorDots" @clickImgItem="handleImg"></home-swiper>
					</view>
					<!-- 茶店严选精品 -->
					<view class="httc-content-other-choose">
						<view class="httccoc-title">
							<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
							<text>茶店严选精品</text>
						</view>
						<view class="httccoc-list">
							<view class="httccoc-list-content" v-for="(item,index) in discountGoods" :key="index" @click="handleGoods(item)">
								<image :src="item.g_src" mode=""></image>
								<text>{{item.g_name}}</text>
								<text class="httccoc-list-content-sale-price">￥{{item.g_price}}</text>
								<text class="httccoc-list-content-sale-person">热销{{item.g_buy_num}}件</text>
							</view>
						</view>
					</view>
					<!-- 爆款推荐 -->
					<view class="httc-content-other-choose">
						<view class="httccoc-title">
							<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
							<text>爆款推荐</text>
						</view>
						<view class="httccoc-list">
							<view class="httccoc-list-content" v-for="(item,index) in hotGoods" :key="index" @click="handleGoods(item)">
								<image :src="item.g_src" mode=""></image>
								<text>{{item.g_name}}</text>
								<text class="httccoc-list-content-sale-price">￥{{item.g_price}}</text>
								<text class="httccoc-list-content-sale-person">热销{{item.g_buy_num}}件</text>
							</view>
						</view>
					</view>
					<!-- 更多热卖 -->
					<view class="httc-content-other-more">
						<view class="httccom-title">
							—— 更多热卖 ——
						</view>
						<view class="httccom-c">
							<view class="home-goods-introduce-list" v-for="(item,index) in allGood" :key="index" @click="handleGoods(item)">
								<home-goods-introduce :lists="item"></home-goods-introduce>
							</view>
						</view>
					</view>
				</view>
				<!-- 茶盘 -->
				<view class="httc-content-other" v-else-if="current == 10">
					<!-- 分类 -->
					<view class="httc-content-other-list">
						<view class="httccol-content" v-for="(item,index) in goodsClass" :key="index" @click="handleG(index)">
							<image :src="item.c_src" mode=""></image>
							<text>{{item.c_name}}</text>
						</view>
					</view>
					<!-- 轮播 -->
					<view class="httc-content-other-img">
						<home-swiper :lists="swiperLists" :indicatorDots="indicatorDots" @clickImgItem="handleImg"></home-swiper>
					</view>
					<!-- 茶店严选精品 -->
					<view class="httc-content-other-choose">
						<view class="httccoc-title">
							<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
							<text>茶店严选精品</text>
						</view>
						<view class="httccoc-list">
							<view class="httccoc-list-content" v-for="(item,index) in discountGoods" :key="index" @click="handleGoods(item)">
								<image :src="item.g_src" mode=""></image>
								<text>{{item.g_name}}</text>
								<text class="httccoc-list-content-sale-price">￥{{item.g_price}}</text>
								<text class="httccoc-list-content-sale-person">热销{{item.g_buy_num}}件</text>
							</view>
						</view>
					</view>
					<!-- 爆款推荐 -->
					<view class="httc-content-other-choose">
						<view class="httccoc-title">
							<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
							<text>爆款推荐</text>
						</view>
						<view class="httccoc-list">
							<view class="httccoc-list-content" v-for="(item,index) in hotGoods" :key="index" @click="handleGoods(item)">
								<image :src="item.g_src" mode=""></image>
								<text>{{item.g_name}}</text>
								<text class="httccoc-list-content-sale-price">￥{{item.g_price}}</text>
								<text class="httccoc-list-content-sale-person">热销{{item.g_buy_num}}件</text>
							</view>
						</view>
					</view>
					<!-- 更多热卖 -->
					<view class="httc-content-other-more">
						<view class="httccom-title">
							—— 更多热卖 ——
						</view>
						<view class="httccom-c">
							<view class="home-goods-introduce-list" v-for="(item,index) in allGood" :key="index" @click="handleGoods(item)">
								<home-goods-introduce :lists="item"></home-goods-introduce>
							</view>
						</view>
					</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	import homeTab from '../../components/home-tab.vue';
	import homeSwiper from '../../components/home-swiper.vue'
	import homeGoodsIntroduce from '../../components/home-goods-introduce.vue'
	export default {
		components: {
			homeTab,
			homeSwiper,
			homeGoodsIntroduce
		},
		data() {
			return {
				items: ["首页"], //选项卡列表
				shopList: [],
				swiperLists: [], //轮播图列表
				current: 0, //选项卡点击的current
				isScrollbar: false, //是否显示滚动条
				goodsCurrent: 0,
				indicatorDots: false, //显示圆点
				homeLists: [], //首页小标题
				vertical: true,
				autoplay: true,
				interval: 1000,
				circular: true,
				textLists: ["文字滚动", "茶店头条", "这是一个文字轮播"], //文字滚动
				allGoods: [], //后台获取所有商品
				allGood: [],
				hotGoods: [], //热销商品
				discountGoods: [], //折扣商品
				allGoodsClass: [], //所有商品分类
				goodsClass: [] //商品分类
			};
		},
		onNavigationBarButtonTap(e) { //监听导航栏事件
			const index = e.index
			if (index === 0) {
				uni.navigateTo({
					url: '../home-search/home-search'
				});
			} else {
				uni.navigateTo({
					url: '../home-info/home-info'
				});
			}
		},
		onLoad() {
			let that = this
			uni.request({ //选项卡
				url: 'http://localhost:3000/goods/class',
				success: (res) => {
					let item = res.data.data.map(function(item) {
						return item.class_name
					})
					that.items = that.items.concat(item)
				}
			});
			uni.request({ //轮播
				url: 'http://localhost:3000/shops',
				success: (res) => {
					let resData = res.data.data
					that.shopList = resData.sort(function(a, b) {
						let x = a.s_time.toLowerCase();
						let y = b.s_time.toLowerCase();
						if (x < y) {
							return 1;
						}
						if (x > y) {
							return -1;
						}
						return 0;
					})
					that.swiperLists = that.shopList.slice(0, 8)
				}
			});
			uni.request({ //小标题
				url: 'http://localhost:3000/home/list',
				success: (res) => {
					that.homeLists = res.data.data
				}
			});
			uni.request({ //商品
				url: 'http://localhost:3000/goods',
				success: (res) => {
					that.allGoods = res.data.data
					that.allGood = that.allGoods
					that.hotGoods = that.allGood.filter(function(item) {
						return item.g_buy_num >= 10
					})
					that.discountGoods = that.allGood.filter(function(item) {
						return item.g_discount != null
					})
				}
			});
			uni.request({ //分类
				url: 'http://localhost:3000/goods/class/child',
				success: (res) => {
					that.allGoodsClass = res.data.data
				}
			});
		},
		methods: {
			onClickItem(index) { //选项卡
				let that = this
				if (that.current !== index) {
					that.current = index;
				}
				if (that.current == 0) {
					that.allGood = that.allGoods
					that.hotGoods = that.allGood.filter(function(item) {
						return item.g_buy_num >= 10
					})
					that.discountGoods = that.allGood.filter(function(item) {
						return item.g_discount != null
					})
					that.swiperLists = that.shopList.slice(0, 8)
				}
				if (that.current == 1) {
					that.goodsClass = that.allGoodsClass.filter(function(item) {
						return item.class_id == 1
					})
					that.allGood = that.allGoods.filter(function(item) {
						return item.class_id == 1
					})
					that.hotGoods = that.allGood.filter(function(item) {
						return item.g_buy_num >= 30
					}).slice(0, 3)
					that.discountGoods = that.allGood.filter(function(item) {
						return item.g_discount == null
					}).slice(0, 6)
					that.swiperLists = []
					let s = [...new Set(that.allGood.map(function(item) {
						return item.shop_id
					}))]
					for (let i = 0; i < s.length; i++) {
						uni.request({
							url: 'http://localhost:3000/shops/swiper',
							data: {
								shopId: s[i]
							},
							success: (res) => {
								let d = res.data.data
								that.swiperLists = that.swiperLists.concat(d)
							}
						});
					}
				}
				if (that.current == 2) {
					that.goodsClass = that.allGoodsClass.filter(function(item) {
						return item.class_id == 2
					})
					that.allGood = that.allGoods.filter(function(item) {
						return item.class_id == 2
					})
					that.hotGoods = that.allGood.filter(function(item) {
						return item.g_buy_num >= 30
					}).slice(0, 3)
					that.discountGoods = that.allGood.filter(function(item) {
						return item.g_discount == null
					}).slice(0, 6)
					that.swiperLists = []
					let s = [...new Set(that.allGood.map(function(item) {
						return item.shop_id
					}))]
					for (let i = 0; i < s.length; i++) {
						uni.request({
							url: 'http://localhost:3000/shops/swiper',
							data: {
								shopId: s[i]
							},
							success: (res) => {
								let d = res.data.data
								that.swiperLists = that.swiperLists.concat(d)
							}
						});
					}
				}
				if (that.current == 3) {
					that.goodsClass = that.allGoodsClass.filter(function(item) {
						return item.class_id == 3
					})
					that.allGood = that.allGoods.filter(function(item) {
						return item.class_id == 3
					})
					that.hotGoods = that.allGood.filter(function(item) {
						return item.g_buy_num >= 30
					}).slice(0, 3)
					that.discountGoods = that.allGood.filter(function(item) {
						return item.g_discount == null
					}).slice(0, 6)
					that.swiperLists = []
					let s = [...new Set(that.allGood.map(function(item) {
						return item.shop_id
					}))]
					for (let i = 0; i < s.length; i++) {
						uni.request({
							url: 'http://localhost:3000/shops/swiper',
							data: {
								shopId: s[i]
							},
							success: (res) => {
								let d = res.data.data
								that.swiperLists = that.swiperLists.concat(d)
							}
						});
					}
				}
				if (that.current == 4) {
					that.goodsClass = that.allGoodsClass.filter(function(item) {
						return item.class_id == 4
					})
					that.allGood = that.allGoods.filter(function(item) {
						return item.class_id == 4
					})
					that.hotGoods = that.allGood.filter(function(item) {
						return item.g_buy_num >= 30
					}).slice(0, 3)
					that.discountGoods = that.allGood.filter(function(item) {
						return item.g_discount == null
					}).slice(0, 6)
					that.swiperLists = []
					let s = [...new Set(that.allGood.map(function(item) {
						return item.shop_id
					}))]
					for (let i = 0; i < s.length; i++) {
						uni.request({
							url: 'http://localhost:3000/shops/swiper',
							data: {
								shopId: s[i]
							},
							success: (res) => {
								let d = res.data.data
								that.swiperLists = that.swiperLists.concat(d)
							}
						});
					}
				}
				if (that.current == 5) {
					that.goodsClass = that.allGoodsClass.filter(function(item) {
						return item.class_id == 5
					})
					that.allGood = that.allGoods.filter(function(item) {
						return item.class_id == 5
					})
					that.hotGoods = that.allGood.filter(function(item) {
						return item.g_buy_num >= 30
					}).slice(0, 3)
					that.discountGoods = that.allGood.filter(function(item) {
						return item.g_discount == null
					}).slice(0, 6)
					that.swiperLists = []
					let s = [...new Set(that.allGood.map(function(item) {
						return item.shop_id
					}))]
					for (let i = 0; i < s.length; i++) {
						uni.request({
							url: 'http://localhost:3000/shops/swiper',
							data: {
								shopId: s[i]
							},
							success: (res) => {
								let d = res.data.data
								that.swiperLists = that.swiperLists.concat(d)
							}
						});
					}
				}
				if (that.current == 6) {
					that.goodsClass = that.allGoodsClass.filter(function(item) {
						return item.class_id == 6
					})
					that.allGood = that.allGoods.filter(function(item) {
						return item.class_id == 6
					})
					that.hotGoods = that.allGood.filter(function(item) {
						return item.g_buy_num >= 30
					}).slice(0, 3)
					that.discountGoods = that.allGood.filter(function(item) {
						return item.g_discount == null
					}).slice(0, 6)
					that.swiperLists = []
					let s = [...new Set(that.allGood.map(function(item) {
						return item.shop_id
					}))]
					for (let i = 0; i < s.length; i++) {
						uni.request({
							url: 'http://localhost:3000/shops/swiper',
							data: {
								shopId: s[i]
							},
							success: (res) => {
								let d = res.data.data
								that.swiperLists = that.swiperLists.concat(d)
							}
						});
					}
				}
				if (that.current == 7) {
					that.goodsClass = that.allGoodsClass.filter(function(item) {
						return item.class_id == 7
					})
					that.allGood = that.allGoods.filter(function(item) {
						return item.class_id == 7
					})
					that.hotGoods = that.allGood.filter(function(item) {
						return item.g_buy_num >= 30
					}).slice(0, 3)
					that.discountGoods = that.allGood.filter(function(item) {
						return item.g_discount == null
					}).slice(0, 6)
					that.swiperLists = []
					let s = [...new Set(that.allGood.map(function(item) {
						return item.shop_id
					}))]
					for (let i = 0; i < s.length; i++) {
						uni.request({
							url: 'http://localhost:3000/shops/swiper',
							data: {
								shopId: s[i]
							},
							success: (res) => {
								let d = res.data.data
								that.swiperLists = that.swiperLists.concat(d)
							}
						});
					}
				}
				if (that.current == 8) {
					that.goodsClass = that.allGoodsClass.filter(function(item) {
						return item.class_id == 8
					})
					that.allGood = that.allGoods.filter(function(item) {
						return item.class_id == 8
					})
					that.hotGoods = that.allGood.filter(function(item) {
						return item.g_buy_num >= 10
					}).slice(0, 3)
					that.discountGoods = that.allGood.filter(function(item) {
						return item.g_discount == null
					}).slice(0, 6)
					that.swiperLists = []
					let s = [...new Set(that.allGood.map(function(item) {
						return item.shop_id
					}))]
					for (let i = 0; i < s.length; i++) {
						uni.request({
							url: 'http://localhost:3000/shops/swiper',
							data: {
								shopId: s[i]
							},
							success: (res) => {
								let d = res.data.data
								that.swiperLists = that.swiperLists.concat(d)
							}
						});
					}
				}
				if (that.current == 9) {
					that.goodsClass = that.allGoodsClass.filter(function(item) {
						return item.class_id == 9
					})
					that.allGood = that.allGoods.filter(function(item) {
						return item.class_id == 9
					})
					that.hotGoods = that.allGood.filter(function(item) {
						return item.g_buy_num >= 10
					}).slice(0, 3)
					that.discountGoods = that.allGood.filter(function(item) {
						return item.g_discount == null
					}).slice(0, 6)
					that.swiperLists = []
					let s = [...new Set(that.allGood.map(function(item) {
						return item.shop_id
					}))]
					for (let i = 0; i < s.length; i++) {
						uni.request({
							url: 'http://localhost:3000/shops/swiper',
							data: {
								shopId: s[i]
							},
							success: (res) => {
								let d = res.data.data
								that.swiperLists = that.swiperLists.concat(d)
							}
						});
					}
				}
				if (that.current == 10) {
					that.goodsClass = that.allGoodsClass.filter(function(item) {
						return item.class_id == 10
					})
					that.allGood = that.allGoods.filter(function(item) {
						return item.class_id == 10
					})
					that.hotGoods = that.allGood.filter(function(item) {
						return item.g_buy_num >= 10
					}).slice(0, 3)
					that.discountGoods = that.allGood.filter(function(item) {
						return item.g_discount == null
					}).slice(0, 6)
					that.swiperLists = []
					let s = [...new Set(that.allGood.map(function(item) {
						return item.shop_id
					}))]
					for (let i = 0; i < s.length; i++) {
						uni.request({
							url: 'http://localhost:3000/shops/swiper',
							data: {
								shopId: s[i]
							},
							success: (res) => {
								let d = res.data.data
								that.swiperLists = that.swiperLists.concat(d)
							}
						});
					}
				}
			},
			handleImg(index) { //轮播图
				uni.navigateTo({
					url: '../home-swiper-shop/home-swiper-shop?id=' + index
				});
			},
			handleToFlash() { //限时抢购
				uni.navigateTo({
					url: '../my-flash-sale/my-flash-sale'
				});
			},
			handleToSpecial() { //天天特卖
				uni.navigateTo({
					url: '../my-special-sale/my-special-sale'
				});
			},
			handleToShop() { //每日好店
				uni.navigateTo({
					url: '../my-shops/my-shops'
				});
			},
			handleToTea() { //每日好茶
				uni.navigateTo({
					url: '../my-tea/my-tea'
				});
			},
			handleToTeam() { //拼团热购
				uni.navigateTo({
					url: '../home-team-buy/home-team-buy'
				});
			},
			handleTovideo() { //礼品
				uni.navigateTo({
					url: '../my-gift/my-gift'
				});
			},
			handleHomeList(index) { //首页内容列表
				switch (index) {
					case 0:
						uni.navigateTo({
							url: '../my-boutique/my-boutique'
						});
						break;
					case 1:
						uni.navigateTo({
							url: '../my-shops/my-shops'
						});
						break;
					case 2:
						uni.navigateTo({
							url: '../my-special-sale/my-special-sale'
						});
						break;
					case 3:
						uni.navigateTo({
							url: '../my-flash-sale/my-flash-sale'
						});
						break;
					case 4:
						uni.navigateTo({
							url: '../home-team-buy/home-team-buy'
						});
						break;
					case 5:
						uni.navigateTo({
							url: '../my-gift/my-gift'
						});
						break;
					case 6:
						uni.navigateTo({
							url: '../my-integral/my-integral'
						});
						break;
					case 7:
						uni.navigateTo({
							url: '../my-envelope-balance/my-envelope-balance'
						});
						break;
					case 8:
						uni.navigateTo({
							url: '../home-integral-shop/home-integral-shop'
						});
						break;
					case 9:
						uni.navigateTo({
							url: '../my-tea/my-tea'
						});
						break;
					default:
						break;
				}
			},
			handleGoods(item) { //全部商品
				uni.navigateTo({
					url: '../goods-class-detail/goods-class-detail?goods=' + JSON.stringify(item)
				})
			},
			handleG(index) {
				uni.navigateTo({
					url: '../goods-class-class/goods-class-class?id=' + this.goodsClass[index].c_id
				})
			}
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
		background: #efefef;
	}

	.home {
		position: relative;

		.home-top-tab {

			/deep/ uni-scroll-view {
				position: fixed;
				top: 44px;
				z-index: 100;
			}

			.home-top-tab-content {
				margin-top: 124upx;

				.httc-content-home {
					position: relative;

					.httc-content-list {
						padding: 0 30upx 30upx;
						display: flex;
						justify-content: space-between;
						flex-wrap: wrap;

						.httccl-content {
							width: 20%;
							padding-top: 30upx;
							display: flex;
							flex-direction: column;
							justify-content: center;
							align-items: center;

							image {
								width: 80upx;
								height: 80upx;
							}

							text {
								font-size: 30upx;
								padding-top: 10upx;
							}
						}
					}

					.httc-content-list-detail {
						padding: 30upx;
						display: flex;
						flex-wrap: wrap;
						justify-content: space-between;
						font-size: 36upx;
						background: #efefef;

						.httccld-class {
							width: 48%;
							margin-bottom: 30upx;
							background: #fff;
							border-radius: 12upx;

							.httccld-class-title {
								display: flex;
								align-items: center;
								padding: 10upx 0;

								>text {
									font-weight: 700;
									margin: 0 20upx 0 10upx;
								}

								.httccld-class-title-time {
									text {
										display: inline-block;
										padding: 10upx;
										background: #666;
										font-size: 20upx;
										color: #fff;
									}
								}

								.httccld-class-title-t {
									padding: 10upx;
									background: #666;
									border-radius: 6upx;
									font-size: 20upx;
								}
							}

							.httccld-class-title-bottom {
								display: flex;
								align-items: center;
								justify-content: space-evenly;

								.httccld-class-title-des {
									width: 45%;

									text {
										display: inline-block;
										font-size: 28upx;
										color: #666;
										padding-bottom: 10upx;
									}

									image {
										width: 150upx;
										height: 200upx;
									}
								}
							}

							.httccld-class-other {
								display: flex;
								justify-content: space-evenly;
								align-items: center;

								.httccld-class-other-lie {
									width: 45%;
									display: flex;
									flex-direction: column;

									.httccld-class-other-title {
										font-size: 36upx;
										font-weight: 700;
										padding: 10upx 0 20upx;
									}

									.httccld-class-other-title-des-text {
										font-size: 28upx;
										color: #666;
										padding-bottom: 10upx;
									}

									image {
										width: 150upx;
										height: 200upx;
									}
								}
							}

						}

						.httccld-special {
							width: 100%;
							height: 80upx;
							line-height: 80upx;
							border-radius: 12upx;
							background: #fff;
							display: flex;

							text {
								font-size: 36upx;
								padding: 0 20upx 0 10upx;
							}

							.httccld-special-text-swiper {
								width: 70%;
								font-size: 28upx;
								color: #666;

								swiper {
									height: 100%;
								}
							}
						}
					}

					.httc-content-image {
						padding: 0 30upx;
						background: linear-gradient(#efefef, #fff);

						image {
							width: 100%;
							height: 200upx;
							border-radius: 12upx;
						}
					}

					.httc-content-goods-title {
						position: sticky;
						top: 200upx;
						display: flex;
						font-size: 36upx;
						padding: 30upx;
						background: #fff;
						z-index: 120;

						.httccgt-default {
							display: flex;
							flex-direction: column;
							align-items: center;
							margin-right: 30upx;

							.httc-content-goods-title-text {
								padding: 10upx 20upx;
								font-size: 28upx;
								color: #666;
							}
						}

						.httccgt-active {
							color: #67c23a;

							.httc-content-goods-title-text {
								display: inline-block;
								background: #67c23a;
								border-radius: 30upx;
								color: #fff;
							}
						}
					}

					.httc-content-goods {
						padding: 30upx 30upx 120upx 30upx;
						background: #efefef;

						.httccg-a {
							display: flex;
							flex-wrap: wrap;
							justify-content: space-between;

							.home-goods-introduce-list {
								width: 48%;
								display: flex;
								flex-direction: column;
								align-items: center;
								background: #fff;
								border-radius: 16upx;
								margin-bottom: 30upx;
							}
						}
					}
				}

				.httc-content-other {
					background: #efefef;
					padding: 30upx;

					.httc-content-other-list {
						background: #fff;
						border-radius: 30upx;
						display: flex;
						flex-wrap: wrap;
						padding: 30upx 30upx 0;

						.httccol-content {
							width: 20%;
							display: flex;
							flex-direction: column;
							align-items: center;
							font-size: 28upx;
							margin-bottom: 30upx;

							image {
								width: 90upx;
								height: 90upx;
								margin: 0 0 10upx 0;
							}
						}
					}

					.httc-content-other-img {
						margin-top: 30upx;

						/deep/ uni-swiper {
							width: 100%;
							height: 200upx;
						}

						/deep/ uni-swiper-item {
							border-radius: 30upx;

							.swiper-item {
								width: 100%;
								height: 100%;

								image {
									width: 100%;
									height: 100%;
								}
							}
						}
					}

					.httc-content-other-choose {
						background: #fff;
						border-radius: 30upx;
						padding: 30upx;
						margin: 30upx 0 0 0;

						.httccoc-title {
							display: flex;
							align-items: center;

							image {
								width: 40upx;
								height: 40upx;
								margin-right: 30upx;
							}
						}

						.httccoc-list {
							display: flex;
							flex-wrap: wrap;

							.httccoc-list-content {
								width: 33%;
								display: flex;
								flex-direction: column;
								margin-top: 30upx;

								image {
									width: 100%;
									height: 200upx;
									border-radius: 15upx;
								}

								>text {
									font-size: 28upx;
									padding: 10upx 0;
								}



								.httccoc-list-content-sale-price {
									color: #ff0000;
									font-size: 40upx;
								}

								.httccoc-list-content-sale-person {
									font-size: 26upx;
									color: #666;
								}
							}
						}
					}

					.httc-content-other-more {
						padding: 0 0 90upx;

						.httccom-title {
							text-align: center;
							padding-top: 30upx;
						}

						.httccom-c {
							display: flex;
							flex-wrap: wrap;
							justify-content: space-between;

							.home-goods-introduce-list {
								width: 48%;
								margin-top: 30upx;
								background: #fff;
							}
						}
					}
				}
			}
		}
	}

	/deep/ .uni-popup__wrapper-box {
		background: #fff;

		.popup-background {
			padding: 40upx;

			text {
				display: inline-block;
				position: absolute;
				left: 50%;
				top: 50%;
				transform: translateX(-50%);
				background: #f0b766;
				padding: 40upx;
				font-size: 40upx;
				border-radius: 60%;
			}
		}

		.popup-close {
			position: absolute;
			right: 40upx;
			top: 40upx;

			image {
				width: 40upx;
				height: 40upx;
			}
		}
	}

	/deep/.uni-scroll-view {
		// background-color: #E9E9E9;
		background: #fff;
	}

	/deep/.uni-scroll-view::-webkit-scrollbar {
		/* 隐藏滚动条，但依旧具备可以滚动的功能 */
		display: none
	}
</style>
