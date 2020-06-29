<!-- 商品类别 -->
<template>
	<view class="goods-class">
		<view class="goods-class-left">
			<view :class="index===current?'gcl-active':'gcl-default'" :id="'sc-'+index" :data-index="index" v-for="(item,index) in lists"
			 :key="index" @click="handleListsName(index)">
				{{item}}
			</view>
		</view>
		<view class="goods-class-right">
			<swiper class="swiper" :indicator-dots="indicatorDots" autoplay :interval="2000" :duration="500" :circular="true">
				<swiper-item v-for="(item,index) in swiperLists" :key="index" @click="handleImg(index)">
					<view class="swiper-item">
						<image :src="item.s_bg" mode="scaleToFill"></image>
					</view>
				</swiper-item>
			</swiper>
			<view class="gcr-name">
				{{goodsClassName}}
			</view>
			<view class="gcr-class">
				<view class="gcr-class-content" v-for="(item,index) in goodsClass" :key="index" @click="handleGoods(index)">
					<image :src="item.c_src" mode=""></image>
					<text>{{item.c_name}}</text>
				</view>
			</view>
			<view class="gcr-name">
				{{goodsShop}}
			</view>
			<view class="gcr-shop">
				<view class="gcr-shop-img" v-for="(item,index) in swiperLists" :key="index">
					<image :src="item.s_icon" mode=""></image>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	import homeSwiper from '../../components/home-swiper.vue'
	export default {
		components: {
			homeSwiper
		},
		data() {
			return {
				lists: [], //选项卡列表
				allGoodsClass: [], //所有商品分类
				goodsClass: [], //商品分类
				swiperLists: [],
				allGoods: [], //所有商品
				allGood: [], //每一类商品
				current: 0,
				indicatorDots: false,
				shopIcon: [] //店铺图标
			};
		},
		onLoad() {
			let that = this
			uni.request({ //选项卡
				url: 'http://localhost:3000/goods/class',
				success: (res) => {
					that.lists = res.data.data.map(function(item) {
						return item.class_name
					})
				}
			});
			uni.request({ //类别
				url: 'http://localhost:3000/goods/class/child',
				success: (res) => {
					that.allGoodsClass = res.data.data
					that.goodsClass = that.allGoodsClass.filter(function(item) {
						return item.class_id == 1
					})
				}
			});
			uni.request({ //商品
				url: 'http://localhost:3000/goods',
				success: (res) => {
					that.allGoods = res.data.data
					that.allGood = that.allGoods.filter(function(item) {
						return item.class_id == 1
					})
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
			});
		},
		computed: {
			goodsClassName() {
				return this.lists[this.current]
			},
			goodsShop() {
				if (this.swiperLists.length > 0) {
					return "热门品牌"
				}
			}
		},
		methods: {
			handleListsName(index) { //选项卡
				let that = this
				if (that.current !== index) {
					that.current = index;
				}
				if (that.current == 0) {
					that.goodsClass = that.allGoodsClass.filter(function(item) {
						return item.class_id == 1
					})
					that.allGood = that.allGoods.filter(function(item) {
						return item.class_id == 1
					})
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
				if (that.current == 1) {
					that.goodsClass = that.allGoodsClass.filter(function(item) {
						return item.class_id == 2
					})
					that.allGood = that.allGoods.filter(function(item) {
						return item.class_id == 2
					})
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
						return item.class_id == 3
					})
					that.allGood = that.allGoods.filter(function(item) {
						return item.class_id == 3
					})
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
						return item.class_id == 4
					})
					that.allGood = that.allGoods.filter(function(item) {
						return item.class_id == 4
					})
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
						return item.class_id == 5
					})
					that.allGood = that.allGoods.filter(function(item) {
						return item.class_id == 5
					})
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
						return item.class_id == 6
					})
					that.allGood = that.allGoods.filter(function(item) {
						return item.class_id == 6
					})
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
						return item.class_id == 7
					})
					that.allGood = that.allGoods.filter(function(item) {
						return item.class_id == 7
					})
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
						return item.class_id == 8
					})
					that.allGood = that.allGoods.filter(function(item) {
						return item.class_id == 8
					})
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
						return item.class_id == 9
					})
					that.allGood = that.allGoods.filter(function(item) {
						return item.class_id == 9
					})
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
						return item.class_id == 10
					})
					that.allGood = that.allGoods.filter(function(item) {
						return item.class_id == 10
					})
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
					url: '../home-swiper-shop/home-swiper-shop?id=' + this.swiperLists[index].shop_id
				});
			},
			handleGoods(index) {
				uni.navigateTo({
					url: '../goods-class-class/goods-class-class?id=' + this.goodsClass[index].c_id
				})
			}
		}
	}
</script>

<style lang="less">
	.goods-class {
		background: #efefef;
		display: flex;

		.goods-class-left {
			background: #fff;
			text-align: center;

			.gcl-default {
				padding: 30upx 40upx;
				border-bottom: 1upx solid #efefef;
			}

			.gcl-active {
				padding: 30upx 40upx;
				background: #efefef;
				color: #67c23a;
			}
		}

		.goods-class-right {
			flex: 1;
			padding: 30upx;

			/deep/ uni-swiper {
				height: 100px;

				.swiper-item {
					width: 100%;
					height: 100%;

					image {
						width: 100%;
						height: 100%;
					}
				}
			}

			.gcr-name {
				padding: 30upx 0;
			}

			.gcr-class {
				background: #fff;
				border-radius: 30upx;
				display: flex;
				flex-wrap: wrap;
				padding: 30upx 0 0;

				.gcr-class-content {
					width: 33%;
					display: flex;
					flex-direction: column;
					align-items: center;
					font-size: 28upx;
					margin-bottom: 30upx;

					image {
						width: 120upx;
						height: 120upx;
						margin: 0 0 10upx 0;
					}
				}
			}

			.gcr-shop {
				background: #fff;
				border-radius: 30upx;
				display: flex;
				flex-wrap: wrap;

				.gcr-shop-img {
					width: 33%;
					margin-top: 30upx;
					display: flex;
					justify-content: center;

					image {
						width: 120upx;
						height: 120upx;
					}
				}

				.gcr-shop-img:last-child {
					margin-bottom: 30upx;
				}
			}
		}
	}
</style>
