<template>
	<view class="home-swiper-shop">
		<view class="hss-nav">
			<image src="../../static/my-img/fanhui.png" @click="handleBack"></image>
			<view class="hss-nav-title" @click="handleShop">{{currentShop.s_name}}</view>
			<text v-if="attention" class="hss-nav-right" @click="handleAttention">关注</text>
			<text v-else class="hss-nav-right" @click="handleHasAttention">已关注</text>
		</view>
		<view class="hss-title">
			<view class="hss-title-synthesis">
				<text>综合体验</text>
				<uni-rate disabled="true" :value="scoreValue" active-color="#f00"></uni-rate>
			</view>
			<text>粉丝数{{pNum}}</text>
		</view>
		<view class="hss-swiper">
			<swiper class="swiper" :indicator-dots="true" :autoplay="true" :interval="2000" :duration="500" :circular="true">
				<swiper-item v-for="(item,index) in swiperLists" :key="index" @click="handleGoods(item)">
					<view class="swiper-item">
						<image :src="item.g_src"></image>
					</view>
				</swiper-item>
			</swiper>
		</view>
		<view class="hss-rank">
			<view class="hss-rank-title">排行榜</view>
			<view class="hss-rank-content">
				<view class="hss-rank-content-list" v-for="(item,index) in shopGoods" :key="index" @click="handleRankGoods(item)">
					<image :src="item.g_src" mode=""></image>
					<text class="hrcl-i">{{item.g_introduce}}</text>
					<text>已售<text class="hrcl-text">{{item.g_buy_num}}</text>件</text>
				</view>
			</view>
		</view>
		<view class="hss-bottom">
			<you-maybe-like-more :goodslists="goodsLists"></you-maybe-like-more>
		</view>
		<uni-popup ref="popup" type="center">
			<view class="hssp-text">确定要取消关注？</view>
			<view class="hssp-b">
				<view class="hss-popup" @click="handleCancelAttention">确定</view>
				<view class="hss-popup" @click="handleThinkAttention">再想想</view>
			</view>
		</uni-popup>
		<uni-popup ref="popupop" type="center">
			<view class="hssp-text">您还没有登录</view>
			<view class="hssp-b">
				<view class="hss-popup" @click="handleT">现在去</view>
				<view class="hss-popup" @click="handleW">稍后登录</view>
			</view>
		</uni-popup>
	</view>
</template>

<script>
	import homeSwiper from '../../components/home-swiper.vue'
	import youMaybeLikeMore from '../../components/you-maybe-like-more.vue'
	export default {
		components: {
			homeSwiper,
			youMaybeLikeMore
		},
		data() {
			return {
				attention: true, //是否关注
				currentShop: [], //当前店铺
				currentFollow: [], //当前关注
				scoreValue: 0,
				isScrollbar: false,
				pNum: 0, //粉丝数
				swiperLists: [], //轮播图列表
				shopGoods: [],
				goodsLists: []
			};
		},
		onLoad(options) {
			let that = this
			uni.request({ //店铺
				url: 'http://localhost:3000/shops',
				success: (res) => {
					let allShops = res.data.data
					that.currentShop = allShops.filter(function(item) {
						return item.shop_id == options.id
					})[0]
					that.pNum = that.currentShop.s_person
					let total = this.currentShop.s_des + this.currentShop.s_log + this.currentShop.s_ser
					that.scoreValue = Number((total / 3).toFixed(2))
				}
			});
			uni.request({ //商品
				url: 'http://localhost:3000/goods',
				success: (res) => {
					let allGoods = res.data.data
					that.shopGoods = allGoods.filter(function(item) {
						return item.shop_id == that.currentShop.shop_id
					}).sort(function(a, b) {
						let x = a.g_buy_num
						let y = b.g_buy_num
						if (x < y) {
							return 1;
						}
						if (x > y) {
							return -1;
						}
						return 0
					})
					that.swiperLists = that.shopGoods.slice(0, 5)
				}
			});
			uni.request({
				url: 'http://localhost:3000/goods',
				success: (res) => {
					that.goodsLists = res.data.data
				}
			});
			uni.getStorage({
				key: 'user_login',
				success(res) {
					that.user = res.data
					uni.request({ //店铺
						url: 'http://localhost:3000/my/follow',
						data: {
							userId: that.user.user_id
						},
						success: (res) => {
							let myFollow = res.data.data
							that.currentFollow = myFollow.filter(function(item) {
								return item.shop_id == options.id
							})
							if (that.currentFollow.length > 0) {
								that.attention = false
							}
						}
					});
				}
			})
		},
		methods: {
			handleBack() { //返回
				uni.navigateBack()
			},
			handleShop() { //店铺详情
				uni.navigateTo({
					url: '../home-swiper-shop-info/home-swiper-shop-info?id=' + this.currentShop.shop_id
				})
			},
			handleAttention() { //关注
				let that = this
				uni.getStorage({
					key: 'user_login',
					success(res) {
						that.user = res.data
						uni.request({ //关注
							url: 'http://localhost:3000/add/my/follow',
							data: {
								userId: that.user.user_id,
								shopName: that.currentShop.s_name,
								shopId: that.currentShop.shop_id,
								shopIcon: that.currentShop.s_icon,
								shopBg: that.currentShop.s_bg,
								shopBga: that.currentShop.s_bga,
								shopBgb: that.currentShop.s_bgb,
								shopBgc: that.currentShop.s_bgc
							},
							success: (res) => {
								uni.request({
									url: 'http://localhost:3000/add/shops/person',
									data: {
										shopId: that.currentShop.shop_id,
										shopPerson: that.currentShop.s_person + 1
									},
									success: (res) => {
										that.attention = false
										that.pNum += 1
										uni.showToast({
											title: '关注成功',
											icon: 'none',
											duration: 1000
										})
									}
								});
							}
						});
					},
					fail() {
						that.$refs.popupop.open()
					}
				})
			},
			handleT() { //去登陆
				uni.navigateTo({
					url: '../signIn/signIn'
				});
			},
			handleW() { //暂不登录
				this.$refs.popupop.close()
			},
			handleHasAttention() { //取消关注
				this.$refs.popup.open()
			},
			handleCancelAttention() { //确定取消
				let that = this
				uni.request({ //店铺
					url: 'http://localhost:3000/del/my/follow',
					data: {
						favoritesId: that.currentFollow[0].f_id
					},
					success: (res) => {
						uni.request({ //取消关注
							url: 'http://localhost:3000/add/shops/person',
							data: {
								shopId: that.currentShop.shop_id,
								shopPerson: that.currentShop.s_person - 1
							},
							success: (res) => {
								that.$refs.popup.close()
								that.attention = true
								that.pNum -= 1
								uni.showToast({
									title: '已取消关注',
									icon: 'none',
									duration: 1000
								})
							}
						});
					}
				});
			},
			handleThinkAttention() { //再想想
				this.$refs.popup.close()
			},
			handleRankGoods(item) {
				uni.navigateTo({
					url: '../goods-class-detail/goods-class-detail?goods=' + JSON.stringify(item)
				})
			},
			handleGoods(item) {
				uni.navigateTo({
					url: '../goods-class-detail/goods-class-detail?goods=' + JSON.stringify(item)
				})
			}
		}
	}
</script>

<style lang="less">
	.home-swiper-shop {
		.hss-nav {
			padding: 30upx;
			background: #67c23a;
			display: flex;
			justify-content: space-between;
			align-items: center;

			image {
				width: 40upx;
				height: 40upx;
			}

			.hss-nav-title {
				color: #fff;
				font-size: 40upx;
				display: flex;
				align-items: center;
			}

			.hss-nav-right {
				display: block;
				color: #fff;
				font-size: 26upx;
				padding: 10upx 30upx;
				border: 1upx solid #fff;
				border-radius: 45upx;
			}
		}

		.hss-title {
			padding: 30upx;
			display: flex;
			align-items: center;
			color: #000;
			background: #efefef;

			.hss-title-synthesis {
				padding: 10upx 20upx;
				margin-right: 15upx;
				background: #fff;
				border-radius: 45upx;
				display: flex;
				align-items: center;

				/deep/ .uni-rate {
					margin: 15upx 0 0 10upx;
				}
			}
		}

		.hss-swiper {
			padding: 0 30upx;
			background: #efefef;

			/deep/ .swiper-item {
				width: 100%;
				height: 100%;

				image {
					width: 100%;
					height: 100%;
				}
			}
		}

		.hss-rank {
			padding: 30upx;
			background: #efefef;

			.hss-rank-content {
				display: flex;
				flex-wrap: wrap;

				.hss-rank-content-list {
					background: #fff;
					width: 33%;
					display: flex;
					flex-direction: column;
					border-radius: 15upx;
					margin-top: 30upx;
					padding-bottom: 15upx;

					image {
						width: 100%;
						height: 240upx;
						border-radius: 15upx;
						margin-bottom: 15upx;
					}

					text {
						padding: 0 10upx;
					}

					.hrcl-i {
						font-size: 30upx;
						overflow: hidden;
						text-overflow: ellipsis;
						display: -webkit-box;
						-webkit-line-clamp: 2;
						-webkit-box-orient: vertical;
					}

					.hrcl-text {
						color: #f00;
					}
				}
			}
		}

		/deep/ .uni-popup__wrapper-box {
			width: 75%;
			margin: 0 auto;
			background: #efefef;
			text-align: center;
			border-radius: 30upx;

			.hssp-text {
				background: #fff;
				margin-bottom: 30upx;
				padding: 30upx 0;
				border-top-left-radius: 30upx;
				border-top-right-radius: 30upx;
			}

			.hssp-b {
				display: flex;
				background: #fff;
				padding: 30upx 0;
				border-bottom-left-radius: 30upx;
				border-bottom-right-radius: 30upx;

				.hss-popup:first-child {
					color: #ff0000;
				}

				.hss-popup {
					width: 50%;
				}
			}
		}
	}
</style>
