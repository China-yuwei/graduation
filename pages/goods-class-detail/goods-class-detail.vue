<!-- 商品类别详情 -->
<template>
	<view class="goods-class-detail">
		<uni-nav-bar class="gcd-nav" left-icon="back" :title="title" :fixed="true" background-color="#67C23A" color="#fff"
		 @clickLeft="handleBack">
		</uni-nav-bar>
		<view class="gcd-top">
			<image :src="good.g_src" mode=""></image>
		</view>
		<view class="gcd-price">
			<view class="gcd-price-left">
				<view class="gcdpl-if" v-if="hsaDiscount">
					<text>￥<text class="gcd-price-left-text">{{good.g_price}}</text></text>
					<text>原价<text class="gcd-price-left-line">￥{{good.g_discount}}</text></text>
				</view>
				<view class="" v-else>
					<text>￥<text class="gcd-price-left-text">{{good.g_price}}</text></text>
				</view>
			</view>
			<view class="gcd-price-right">
				<text>距结束仅剩</text>
				<view class="gcd-price-right-time">
					<text>10</text>:
					<text>10</text>:
					<text>10</text>
				</view>
			</view>
		</view>
		<view class="gcd-sale">
			<text>快递：0.00</text>
			<text>已售：{{good.g_buy_num}}</text>
			<text>{{shop.s_address}}</text>
		</view>
		<!-- <view class="gcd-special-offer">
			<view class="gcd-special-offer-left">
				<text class="gcd-special-offer-title">优惠</text>
			</view>
			<view class="gcd-special-offer-right">
				<text class="gcd-special-offer-text">选择优惠券</text>
				<image src="../../static/my-img/youjiantou.png" mode=""></image>
			</view>
		</view> -->
		<!-- <view class="gcd-special-offer">
			<view class="gcd-special-offer-left">
				<text class="gcd-special-offer-title">活动</text>
				<text class="gcd-special-offer-text">xxx</text>
			</view>
		</view> -->
		<!-- <view class="gcd-special-offer">
			<view class="gcd-special-offer-left">
				<text class="gcd-special-offer-title">服务</text>
				<text class="gcd-special-offer-text">xxx</text>
			</view>
		</view> -->
		<!-- <view class="gcd-special-offer">
			<view class="gcd-special-offer-left">
				<text class="gcd-special-offer-title">参数</text>
			</view>
			<view class="gcd-special-offer-right">
				<text class="gcd-special-offer-text">xxx</text>
				<image src="../../static/my-img/youjiantou.png" mode=""></image>
			</view>
		</view> -->
		<!-- <view class="gcd-special-offer">
			<view class="gcd-special-offer-left">
				<text class="gcd-special-offer-title">选择</text>
			</view>
			<view class="gcd-special-offer-right">
				<text class="gcd-special-offer-text">选择商品规格</text>
				<image src="../../static/my-img/youjiantou.png" mode=""></image>
			</view>
		</view> -->
		<view class="gcd-appraisals">
			<view class="gcd-appraisals-top">
				<text>宝贝评价(0)</text>
				<view class="gcd-appraisals-top-right" @click="handleCo">
					<text>查看全部</text>
					<image src="../../static/my-img/youjiantou.png" mode=""></image>
				</view>
			</view>
		</view>
		<view class="gcd-shop">
			<view class="gcd-shop-top">
				<image :src="shop.s_icon" mode=""></image>
				<view class="gcd-shop-top-shop">
					<text>{{shop.s_name}}</text>
					<view class="gcd-shop-top-shop-xing">
						<text>综合体验</text>
						<uni-rate :disabled="true" :value="scoreValue" active-color="#f00"></uni-rate>
					</view>
				</view>
			</view>
			<view class="gcd-shop-top-center">
				<text class="gcd-shop-top-center-all" @click="handleAllGoods">全部宝贝</text>
				<text class="gcd-shop-top-center-shop" @click="handleShops">进店逛逛</text>
			</view>
			<view class="gcd-shop-bottom">
				<text>商品描述：{{shop.s_des}}</text>
				<text>服务态度：{{shop.s_ser}}</text>
				<text>物流服务：{{shop.s_log}}</text>
			</view>
		</view>
		<view class="gcd-recommended">
			<view class="gcd-recommended-top">
				<text>店铺推荐</text>
				<view class="gcd-recommended-top-right" @click="handleShops">
					<text>查看全部</text>
					<image src="../../static/my-img/youjiantou.png" mode=""></image>
				</view>
			</view>
			<view class="gcd-recommended-content">
				<view class="gcdrc-list" v-for="(item,index) in shopGoods" :key="index" @click="handleGoods(item)">
					<image :src="item.g_src" mode=""></image>
					<text class="gcdrc-list-in">{{item.g_introduce}}</text>
					<text class="gcdrc-list-price">￥{{item.g_price}}</text>
				</view>
			</view>
		</view>
		<view class="gcd-bottom">
			<view class="gcd-bottom-left">
				<view class="gcd-bottom-left-list" @click="handleShops">
					<image src="../../static/goodsClass-img/dianpu.png" mode=""></image>
					<text>店铺</text>
				</view>
				<view class="gcd-bottom-left-list" @click="handleKefu">
					<image src="../../static/goodsClass-img/kefu.png" mode=""></image>
					<text>客服</text>
				</view>
				<view class="gcd-bottom-left-list" @click="handleF">
					<image src="../../static/goodsClass-img/shoucang.png" mode=""></image>
					<text>收藏</text>
				</view>
			</view>
			<view class="gcd-bottom-right">
				<view class="gcdbr-left" @click="handleS">
					加入购物车
				</view>
				<view class="gcdbr-right" @click="handleBuy">
					立即购买
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				title: "分类", //导航标题
				good: [],
				shop: [],
				shopGoods: [],
				scoreValue: 0,
				user: [],
				hsaDiscount: true
			};
		},
		onLoad(options) { //接收搜索或分类页的参数
			let that = this
			that.good = JSON.parse(options.goods)
			that.title = that.good.g_name
			if (that.good.g_discount > 0) {
				that.hsaDiscount = true
			} else {
				that.hsaDiscount = false
			}
			uni.getStorage({
				key: 'user_login',
				success(res) {
					that.user = res.data
				}
			});
			uni.request({ //店铺
				url: 'http://localhost:3000/shops',
				success: (res) => {
					let allShops = res.data.data
					that.shop = allShops.filter(function(item) {
						return item.shop_id == that.good.shop_id
					})[0]
					let total = that.shop.s_des + that.shop.s_log + that.shop.s_ser
					that.scoreValue = Number((total / 3).toFixed(2))
				}
			});
			uni.request({ //商品
				url: 'http://localhost:3000/goods',
				success: (res) => {
					let allGoods = res.data.data
					that.shopGoods = allGoods.filter(function(item) {
						return item.shop_id == that.shop.shop_id
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
					}).slice(0, 6)
				}
			});
			uni.request({ //足迹
				url: 'http://localhost:3000/my/footprint',
				data: {
					userId: that.user.user_id
				},
				success: (res) => {
					let getData = res.data.data
					let crtTime = new Date()
					let nowTime = that.dateFtt("yyyy-MM-dd hh:mm:ss", crtTime)
					let hasGoods = getData.filter(function(item) {
						return item.g_id == that.good.g_id
					})
					if (hasGoods.length == 0) {
						uni.request({ //足迹
							url: 'http://localhost:3000/add/my/footprint',
							data: {
								userId: that.user.user_id,
								goodId: that.good.g_id,
								goodName: that.good.g_name,
								goodPrice: that.good.g_price,
								goodSrc: that.good.g_src,
								fTime: nowTime
							},
							success: (res) => {
								console.log(res)
							}
						});
					}
				}
			});
		},
		methods: {
			handleBack() {
				uni.navigateBack()
			},
			// 评价
			handleCo() {
				uni.showToast({
					icon: 'none',
					title: '暂无评价',
					duration: 1000
				})
			},
			// 全部宝贝
			handleAllGoods() {
				uni.switchTab({
					url: '../goods-class/goods-class'
				})
			},
			// 进店
			handleShops() {
				uni.navigateTo({
					url: '../home-swiper-shop/home-swiper-shop?id=' + this.shop.shop_id
				});
			},
			// 客服
			handleKefu() {
				uni.showToast({
					icon: 'none',
					title: '暂时不能联系客服',
					duration: 1000
				})
			},
			handleGoods(item) {
				uni.navigateTo({
					url: '../goods-class-detail/goods-class-detail?goods=' + JSON.stringify(item)
				})
			},
			// 收藏
			handleF() {
				let that = this
				uni.request({
					url: 'http://localhost:3000/my/favorites',
					data: {
						userId: that.user.user_id
					},
					success: (res) => {
						let getData = res.data.data
						let hasGoods = getData.filter(function(item) {
							return item.g_id == that.good.g_id
						})
						if (hasGoods.length == 0) {
							uni.request({ //收藏
								url: 'http://localhost:3000/add/my/favorites',
								data: {
									userId: that.user.user_id,
									goodsId: that.good.g_id,
									goodsPrice: that.good.g_price,
									goodsName: that.good.g_name,
									goodsSrc: that.good.g_src
								},
								success: (res) => {
									uni.showToast({
										icon: 'none',
										title: '收藏商品成功！',
										duration: 1000
									})
								}
							});
						} else {
							uni.showToast({
								icon: 'none',
								title: '你已经收藏过该商品了！',
								duration: 1000
							})
						}
					}
				})
			},
			handleS() { //加入购物车
				let that = this
				uni.request({
					url: 'http://localhost:3000/add/shopping/car',
					data: {
						userId: that.user.user_id,
						goodId: that.good.g_id,
						shopId: that.shop.shop_id,
						shopName: that.shop.s_name,
						goodName: that.good.g_name,
						goodIntroduce: that.good.g_introduce,
						goodSrc: that.good.g_src,
						goodPrice: that.good.g_price,
						scNum: 1
					},
					success: (res) => {
						uni.showToast({
							title: '加入购物车成功',
							icon: 'none',
							duration: 1000
						})
						uni.switchTab({
							url: '../shopping-car/shopping-car'
						})
					}
				});
			},
			handleBuy() {
				let that = this
				let crtTime = new Date()
				let nowTime = that.dateFtt("yyyy-MM-dd hh:mm:ss", crtTime)
				uni.request({
					url: 'http://localhost:3000/add/shopping/car',
					data: {
						userId: that.user.user_id,
						goodId: that.good.g_id,
						shopId: that.shop.shop_id,
						shopName: that.shop.s_name,
						goodName: that.good.g_name,
						goodIntroduce: that.good.g_introduce,
						goodSrc: that.good.g_src,
						goodPrice: that.good.g_price,
						scNum: 1
					},
					success: (res) => {
						uni.request({ //足迹
							url: 'http://localhost:3000/shopping/car',
							data: {
								userId: that.user.user_id,
							},
							success: (res) => {
								let getData = res.data.data
								let scid = getData[getData.length - 1].sc_id
								uni.request({
									url: 'http://localhost:3000/add/my/order',
									data: {
										userId: that.user.user_id,
										goodId: that.good.g_id,
										shopId: that.shop.shop_id,
										shopName: that.shop.s_name,
										goodName: that.good.g_name,
										goodSrc: that.good.g_src,
										goodPrice: that.good.g_price,
										scNum: 1,
										oTime: nowTime,
										oType: "待付款",
										scId: scid
									},
									success: (res) => {
										uni.request({
											url: 'http://localhost:3000/del/shopping/car',
											data: {
												scId: scid
											},
											success: (res) => {
												uni.navigateTo({
													url: '../shopping-car-order-confirm/shopping-car-order-confirm?id=' + scid
												})
											}
										});
									}
								});
							}
						});
					}
				});
			},
			dateFtt(fmt, date) {
				let newDate = {
					"M+": date.getMonth() + 1, //月份 
					"d+": date.getDate(), //日 
					"h+": date.getHours(), //小时 
					"m+": date.getMinutes(), //分 
					"s+": date.getSeconds(), //秒 
				};
				if (/(y+)/.test(fmt))
					fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
				for (let k in newDate)
					if (new RegExp("(" + k + ")").test(fmt))
						fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (newDate[k]) : (("00" + newDate[k]).substr(("" + newDate[k])
							.length)));
				return fmt;
			}
		}
	}
</script>

<style lang="less">
	.goods-class-detail {
		background: rgb(247, 247, 247);

		.gcd-nav {
			/deep/ .uni-navbar--fixed {
				width: 100%;
			}
		}

		.gcd-top {
			image {
				width: 100%;
				height: 800upx;
			}
		}

		.gcd-price {
			background: #fff;
			display: flex;

			.gcd-price-left {
				width: 60%;
				background: #f00;
				padding: 30upx;
				color: #fff;
				display: flex;
				align-items: center;
				justify-content: center;

				.gcdpl-if {
					display: flex;
					flex-direction: column;
					align-items: center;
					justify-content: center;
				}

				.gcd-price-left-text {
					font-size: 48upx;
				}

				.gcd-price-left-line {
					text-decoration: line-through;
				}
			}

			.gcd-price-right {
				background: #ffc737;
				color: #f00;
				padding: 30upx;

				.gcd-price-right-time {
					display: flex;
					align-items: center;

					text {
						display: block;
						color: #fff;
						padding: 10upx;
						background: #f00;
						border-radius: 10upx;
					}
				}
			}
		}

		.gcd-introduce {
			background: #fff;
			padding: 30upx;
			display: flex;
			align-items: center;

			.gcd-introduce-text {
				background: #FF0000;
				border-radius: 30upx;
			}

			.gcd-introduce-in {
				font-weight: 500;
				overflow: hidden;
				text-overflow: ellipsis;
				display: -webkit-box;
				-webkit-line-clamp: 2;
				-webkit-box-orient: vertical;
			}
		}

		.gcd-sale {
			background-color: #fff;
			padding: 30upx;
			display: flex;
			justify-content: space-between;
			align-items: center;
			color: #666;
			font-size: 28upx;
		}

		.gcd-special-offer {
			background: #fff;
			margin-top: 30upx;
			padding: 30upx;
			display: flex;
			justify-content: space-between;
			align-items: center;

			.gcd-special-offer-left {
				.gcd-special-offer-title {
					font-size: 28upx;
					color: #666;
					white-space: nowrap;
					padding-right: 15upx;
				}
			}

			.gcd-special-offer-right {
				display: flex;
				align-items: center;

				.gcd-special-offer-text {
					padding-left: 30upx;
				}

				image {
					width: 40upx;
					height: 40upx;
					margin-left: 15upx;
				}
			}
		}

		.gcd-appraisals {
			background: #fff;
			margin-top: 30upx;
			padding: 30upx;

			.gcd-appraisals-top {
				display: flex;
				justify-content: space-between;
				align-items: center;

				.gcd-appraisals-top-right {
					display: flex;
					align-items: center;

					image {
						width: 40upx;
						height: 40upx;
					}
				}
			}
		}

		.gcd-shop {
			background: #fff;
			margin-top: 30upx;
			padding: 30upx;

			.gcd-shop-top {
				display: flex;
				align-items: center;

				image {
					width: 160upx;
					height: 160upx;
					margin-right: 30upx;
				}

				.gcd-shop-top-shop {
					display: flex;
					flex-direction: column;
					justify-content: space-between;
					height: 150upx;

					.gcd-shop-top-shop-xing {
						display: flex;
						align-items: center;
						font-size: 26upx;
						color: #666;

						text {
							white-space: nowrap;
						}

						/deep/ .uni-rate {
							margin: 15upx 0 0 15upx;
						}
					}
				}

			}

			.gcd-shop-top-center {
				display: flex;
				align-items: center;
				justify-content: space-around;
				padding: 30upx 0;

				text {
					display: block;
					padding: 10upx 30upx;
					border-radius: 45upx;
				}

				.gcd-shop-top-center-all {
					border: 1upx solid #f00;
					color: #f00;
				}

				.gcd-shop-top-center-shop {
					background: #f00;
					color: #fff;
					margin-left: 30upx;
				}
			}

			.gcd-shop-bottom {
				display: flex;
				justify-content: space-between;
				align-items: center;
				color: #666;
				font-size: 30upx;
			}
		}

		.gcd-recommended {
			background: #fff;
			margin: 30upx 0 90upx 0;
			padding: 30upx;

			.gcd-recommended-top {
				display: flex;
				justify-content: space-between;
				align-items: center;

				.gcd-recommended-top-right {
					display: flex;
					align-items: center;

					image {
						width: 40upx;
						height: 40upx;
					}
				}
			}

			.gcd-recommended-content {
				display: flex;
				flex-wrap: wrap;
				padding: 30upx 0;

				.gcdrc-list {
					width: 33%;
					display: flex;
					flex-direction: column;
					margin-bottom: 30upx;

					image {
						width: 100%;
						height: 320upx;
						border-radius: 15upx;
					}

					.gcdrc-list-in {
						font-size: 30upx;
						overflow: hidden;
						text-overflow: ellipsis;
						display: -webkit-box;
						-webkit-line-clamp: 2;
						-webkit-box-orient: vertical;
					}

					.gcdrc-list-price {
						color: #f00;
						padding: 15upx 0 0 0;
					}
				}
			}
		}

		.gcd-bottom {
			position: fixed;
			bottom: 0;
			padding: 15upx 0;
			background: #fff;
			display: flex;
			align-items: center;
			justify-content: space-between;
			width: 100%;

			.gcd-bottom-left {
				width: 50%;
				display: flex;
				justify-content: space-around;

				.gcd-bottom-left-list {
					display: flex;
					flex-direction: column;
					align-items: center;

					image {
						width: 40upx;
						height: 40upx;
						margin-bottom: 15upx;
					}
				}
			}

			.gcd-bottom-right {
				width: 50%;
				display: flex;
				padding: 0 30upx;
				font-size: 32upx;

				view {
					width: 50%;
					color: #fff;
					padding: 30upx 0;
					text-align: center;
				}

				.gcdbr-left {
					background: #ffc737;
					border-top-left-radius: 45upx;
					border-bottom-left-radius: 45upx;
				}

				.gcdbr-right {
					background: #f00;
					border-top-right-radius: 45upx;
					border-bottom-right-radius: 45upx;
				}
			}
		}
	}
</style>
