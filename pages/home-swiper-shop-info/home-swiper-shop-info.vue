<template>
	<view class="home-swiper-shop-info">
		<view class="hssi-info">
			<image :src="currentShop.s_icon" mode=""></image>
			<view class="hssi-info-right">
				<text>{{currentShop.s_name}}</text>
				<view class="hssi-info-right-center">
					<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
					<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
				</view>
				<view class="hssi-info-right-bottom">
					<text class="hssi-info-right-bottom-left">粉丝数 {{pNum}}</text>
					<text v-if="attention" class="hssi-info-right-bottom-right" @click="handleAttention">关注</text>
					<text v-else class="hssi-info-right-bottom-right" @click="handleHasAttention">已关注</text>
				</view>
			</view>
		</view>
		<view class="hssi-synthesis">
			<view class="hssi-synthesis-title">
				<text>综合体验</text>
				<uni-rate disabled="true" :value="scoreValue" active-color="#f00"></uni-rate>
			</view>
			<text>由网站内测评估，含品质、物流、售后等多项内容。星星越多店铺服务越好。</text>
		</view>
		<view class="hssi-comments">
			<view class="hssi-comments-box">
				<text>店铺好评率 {{goodRatings}}%</text>
				<view class="hssi-comments-list">
					<text>商品描述</text>
					<slider class="hssicl-slider" :value="currentShop.s_des" max="5" disabled activeColor="#f00" backgroundColor="rgb(230,230,230)"
					 block-color="rgb(230,230,230)" block-size="12" />
					<text class="hssicl-score">{{currentShop.s_des}}</text>
				</view>
				<view class="hssi-comments-list">
					<text>服务态度</text>
					<slider class="hssicl-slider" :value="currentShop.s_ser" max="5" disabled activeColor="#f00" backgroundColor="rgb(230,230,230)"
					 block-color="rgb(230,230,230)" block-size="12" />
					<text class="hssicl-score">{{currentShop.s_ser}}</text>
				</view>
				<view class="hssi-comments-list">
					<text>物流服务</text>
					<slider class="hssicl-slider" :value="currentShop.s_log" max="5" disabled activeColor="#f00" backgroundColor="rgb(230,230,230)"
					 block-color="rgb(230,230,230)" block-size="12" />
					<text class="hssicl-score">{{currentShop.s_log}}</text>
				</view>
			</view>
		</view>
		<view class="hssi-basic">
			<view class="hssi-basic-title">
				基础信息
			</view>
			<view class="hssi-basic-list">
				<text>店铺名</text>
				<text>{{currentShop.s_name}}</text>
			</view>
			<view class="hssi-basic-list">
				<text>服务电话</text>
				<text>{{currentShop.s_phone}}</text>
			</view>
			<view class="hssi-basic-list">
				<text>所在地</text>
				<text>{{currentShop.s_address}}</text>
			</view>
			<!-- <view class="hssi-basic-list">
				<text>企业资质</text>
				<image src="../../static/my-img/youjiantou.png" mode=""></image>
			</view>
			<view class="hssi-basic-list">
				<text>店铺名片</text>
				<image src="../../static/my-img/youjiantou.png" mode=""></image>
			</view> -->
			<view class="hssi-basic-list">
				<text>开店时间</text>
				<text>{{currentShop.s_time}}</text>
			</view>
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
	import uniRate from '@/components/uni-rate/uni-rate.vue'
	export default {
		components: {
			uniRate
		},
		data() {
			return {
				attention: true, //是否关注
				currentShop: [],
				pNum: 0,
				goodRatings: 0,
				scoreValue: 0
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
					let total = that.currentShop.s_des + that.currentShop.s_log + that.currentShop.s_ser
					that.goodRatings = ((total / 15).toFixed(4)) * 100
					that.scoreValue = Number((total / 3).toFixed(2))
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
								shopIcon: that.currentShop.s_icon
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
		}
	}
</script>

<style lang="less">
	.home-swiper-shop-info {
		.hssi-info {
			border-top: 1upx solid #efefef;
			border-bottom: 1upx solid #efefef;
			padding: 30upx;
			display: flex;
			align-items: center;

			image {
				width: 150upx;
				height: 150upx;
				margin-right: 30upx;
			}

			.hssi-info-right {
				flex: 1;
				display: flex;
				flex-direction: column;
				font-size: 40upx;

				.hssi-info-right-center {
					display: flex;
					align-items: center;
					margin-top: 10upx;

					image {
						width: 30upx;
						height: 30upx;
						margin-right: 30upx;
						background: #FF0000;
						padding: 10upx;
						border-radius: 8upx;
					}
				}

				.hssi-info-right-bottom {
					display: flex;
					justify-content: space-between;
					align-items: center;
					font-size: 30upx;

					.hssi-info-right-bottom-left {
						color: #666;
					}

					.hssi-info-right-bottom-right {
						color: #fff;
						display: block;
						border-radius: 45upx;
						padding: 10upx 30upx;
						background: #f00;
					}
				}
			}
		}

		.hssi-synthesis {
			padding: 30upx;

			.hssi-synthesis-title {
				display: flex;
				align-items: center;
				color: #f00;
				margin-bottom: 30upx;

				/deep/ .uni-rate {
					margin: 15upx 0 0 15upx;
				}
			}
		}

		.hssi-comments {
			padding: 30upx 0;
			background: #efefef;

			.hssi-comments-box {
				padding: 30upx;
				background: #fff;

				>text {
					font-size: 36upx;
				}

				.hssi-comments-list {
					display: flex;
					justify-content: space-between;
					align-items: center;
					font-size: 30upx;
					padding-top: 30upx;

					.hssicl-slider {
						flex: 1;
						height: 40upx;
						background: #efefef;
						border-radius: 45upx;
						margin: 0 30upx;
					}

					.hssicl-score {
						color: #f00;
						font-weight: 600;
					}
				}
			}
		}

		.hssi-basic {
			padding: 30upx;

			.hssi-basic-title {
				font-size: 28upx;
				color: #666;
			}

			.hssi-basic-list {
				padding-top: 30upx;
				display: flex;
				align-items: center;
				justify-content: space-between;

				image {
					width: 40upx;
					height: 40upx;
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
