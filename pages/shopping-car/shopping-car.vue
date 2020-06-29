<template>
	<view class="shopping-car">
		<view class="shopping-car-head">
			<view class="shopping-car-head-title">
				<text>购物车</text>
				<text class="scht-manage" v-if="showChange" @click="handleManage">管理</text>
				<text class="scht-manage" v-else @click="handleComplete">完成</text>
			</view>
			<text>共 {{shoppingCarNum}} 件商品</text>
		</view>
		<view class="shopping-car-goods">
			<view class="scg-content" v-for="(item,index) in list" :key="index">
				<view class="scgc-shop" @click="handleShop(item)">
					<image src="../../static/shoppingCar-img/shangdian.png" mode=""></image>
					<text>{{item.s_name}}</text>
				</view>
				<view class="scgc-good">
					<checkbox-group @change="selected(item)">
						<checkbox class="xuanzhong" :checked="item.flag" />
					</checkbox-group>
					<image :src="item.g_src" mode="" @click="handleGoods(item)"></image>
					<view class="scgcg-c">
						<view class="scgcgc-i" @click="handleGoods(item)">
							{{item.g_introduce}}
						</view>
						<view class="scgcgc-p">
							<text class="scgcgcp-price">￥{{item.g_price}}</text>
							<view class="scgcgcp-num">
								<view class="scgcgcpn-d" @click="reduce(item)">-</view>
								<view class="scgcgcpn-n">{{item.sc_num}}</view>
								<view class="scgcgcpn-d" @click="add(item)">+</view>
							</view>
						</view>
					</view>
				</view>
			</view>
		</view>
		<view class="shopping-car-bottom-management">
			<view class="quanxuan">
				<checkbox-group @change="selectedall()">
					<checkbox class="quanxuananniu" :checked="allchecked" />全选
				</checkbox-group>
			</view>
			<view class="scbm-total" v-if="showChange">
				总价:￥<text class="scbm-p">{{totalPrice}}</text>
				<text class="scbm-a" @click="handleAccount">结算({{totalNum}})</text>
			</view>
			<view class="scbm-total" v-else>
				<text class="scbm-a" @click="handleDel">删除({{totalNum}})</text>
			</view>
		</view>
		<view class="shopping-car-bottom">
			<you-maybe-like-more :goodslists="goodsLists"></you-maybe-like-more>
		</view>
	</view>
</template>

<script>
	import youMaybeLikeMore from '../../components/you-maybe-like-more.vue'
	export default {
		components: {
			youMaybeLikeMore
		},
		data() {
			return {
				showChange: true, //管理或完成
				shoppingCarNum: 0, //商品数量
				user: [],
				list: [],
				flag: false,
				allchecked: false,
				totalNum: 0,
				totalPrice: 0,
				goodsLists: []
			};
		},
		onShow() {
			let that = this
			uni.getStorage({
				key: 'user_login',
				success(res) {
					if (res.data.admin_id > 0) {
						that.user.user_id = 0
					} else {
						that.user = res.data
					}
					uni.request({
						url: 'http://localhost:3000/shopping/car',
						data: {
							userId: that.user.user_id
						},
						success: (res) => {
							that.list = res.data.data
							that.shoppingCarNum = that.list.length
						}
					});
					uni.request({
						url: 'http://localhost:3000/goods',
						success: (res) => {
							that.goodsLists = res.data.data
						}
					});
				},
				fail() {
					uni.navigateTo({
						url: '../signIn/signIn'
					});
				}
			})
		},
		methods: {
			handleManage() {
				this.showChange = false
			},
			handleComplete() {
				this.showChange = true
			},
			handleShop(item) {
				uni.navigateTo({
					url: '../home-swiper-shop/home-swiper-shop?id=' + item.shop_id
				})
			},
			handleGoods(item) {
				uni.navigateTo({
					url: '../goods-class-detail/goods-class-detail?goods=' + JSON.stringify(item)
				})
			},
			// 减号操作
			reduce(item) {
				// 需要判断是否会减到0，我在这里是最小为1.
				if (item.sc_num > 1) {
					item.sc_num -= 1
				} else {
					uni.request({
						url: 'http://localhost:3000/del/shopping/car',
						data: {
							scId: item.sc_id
						},
						success: (res) => {
							this.list = this.list.filter(function(i) {
								return i.sc_id != item.sc_id
							})
						}
					});
				}
			},
			// 加号操作
			add(item) {
				item.sc_num += 1
			},
			// 单个商品前的勾选
			selected(item) {
				let that = this
				item.flag = !item.flag
				if (!item.flag) {
					that.allchecked = false
					that.totalPrice = ((that.totalPrice * 100 - item.sc_num * item.g_price * 100) / 100).toFixed(2)
					that.totalNum -= item.sc_num
				} else {
					that.totalPrice += (item.sc_num * item.g_price)
					that.totalNum += item.sc_num
					const test = that.list.every(item => {
						return item.flag === true
					})
					if (test) {
						that.allchecked = true
					} else {
						that.allchecked = false
					}
				}
			},
			// 全选按钮
			selectedall() {
				let that = this
				that.totalNum = 0
				that.totalPrice = 0
				that.allchecked = !that.allchecked
				if (that.allchecked) {
					that.list.map(item => {
						item.flag = true
					})
					that.list.map(item => {
						that.totalPrice += (item.sc_num * item.g_price)
						that.totalNum += item.sc_num
					})
				} else {
					that.list.map(item => {
						item.flag = false
					})
					that.totalNum = 0
					that.totalPrice = 0
				}
			},
			handleAccount() {
				let that = this
				let crtTime = new Date()
				let nowTime = that.dateFtt("yyyy-MM-dd hh:mm:ss", crtTime)
				if (that.totalNum == 0) {
					uni.showToast({
						title: '你还未选中商品',
						icon: 'none',
						duration: 1000
					})
				} else {
					let order = that.list.filter(function(item) {
						return item.flag == true
					})
					for (let i = 0; i < order.length; i++) {
						uni.request({
							url: 'http://localhost:3000/add/my/order',
							data: {
								userId: that.user.user_id,
								goodId: order[i].g_id,
								shopId: order[i].shop_id,
								shopName: order[i].s_name,
								goodName: order[i].g_name,
								goodSrc: order[i].g_src,
								goodPrice: order[i].g_price,
								scNum: order[i].sc_num,
								oTime: nowTime,
								oType: "待付款",
								scId: order[i].sc_id
							},
							success: (res) => {
								uni.request({
									url: 'http://localhost:3000/del/shopping/car',
									data: {
										scId: order[i].sc_id
									},
									success: (res) => {
										that.list = that.list.filter(function(i) {
											return i.flag != true
										})
									}
								});
								uni.navigateTo({
									url: '../shopping-car-order-confirm/shopping-car-order-confirm?id=' + order[i].sc_id
								})
							}
						});
					}
				}
			},
			handleDel() {
				let that = this
				if (that.totalNum == 0) {
					uni.showToast({
						title: '你还未选中商品',
						icon: 'none',
						duration: 1000
					})
				} else {
					let order = that.list.filter(function(item) {
						return item.flag == true
					})
					for (let i = 0; i < order.length; i++) {
						uni.request({
							url: 'http://localhost:3000/del/shopping/car',
							data: {
								scId: order[i].sc_id
							},
							success: (res) => {
								that.list = that.list.filter(function(i) {
									return i.flag != true
								})
							}
						});
					}
				}
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
	uni-page-wrapper {
		background: #E9E9E9;
	}

	uni-page-body {
		// height: 100%;
		background: #E9E9E9;
	}

	.shopping-car {
		.shopping-car-head {
			background: #67c23a;
			padding: 60upx 20upx 60upx 20upx;
			color: #fff;

			.shopping-car-head-title {
				display: flex;
				justify-content: space-between;
				align-items: center;

				.scht-manage {
					font-size: 30upx;
				}
			}

			>text {
				font-size: 30upx;
			}
		}

		.shopping-car-goods {
			padding: 30upx;
			background: #efefef;

			.scg-content:first-child {
				margin-top: 0;
			}

			.scg-content {
				margin-top: 30upx;
				padding: 30upx;
				background: #fff;
				border-radius: 20upx;

				.scgc-shop {
					display: flex;
					align-items: center;
					padding-bottom: 30upx;

					image {
						width: 40upx;
						height: 40upx;
						margin-right: 30upx;
					}
				}

				.scgc-good {
					display: flex;
					align-items: center;
					justify-content: space-between;

					/deep/ .uni-checkbox-input {
						border-radius: 30upx;
						margin-right: 0;
					}

					>image {
						width: 160upx;
						height: 160upx;
						border-radius: 15upx;
						margin: 0 20upx;
					}

					.scgcg-c {
						height: 160upx;
						flex: 1;
						display: flex;
						flex-direction: column;
						justify-content: space-between;

						.scgcgc-i {
							font-size: 30upx;
							overflow: hidden;
							text-overflow: ellipsis;
							display: -webkit-box;
							-webkit-line-clamp: 2;
							-webkit-box-orient: vertical;
						}

						.scgcgc-p {
							display: flex;
							justify-content: space-between;
							align-items: center;

							.scgcgcp-price {
								color: #f00;
							}

							.scgcgcp-num {
								display: flex;
								align-items: center;
								border: 4upx solid #999;
								border-radius: 15upx;

								.scgcgcpn-d {
									padding: 0 20upx;
								}

								.scgcgcpn-n {
									padding: 0 20upx;
									border-left: 4upx solid #999;
									border-right: 4upx solid #999;
								}
							}
						}
					}
				}
			}
		}

		.shopping-car-bottom-management {
			width: 100%;
			position: fixed;
			bottom: 50px;
			display: flex;
			align-items: center;
			justify-content: space-between;
			background: #efefef;
			z-index: 100;

			.quanxuan {
				margin-left: 30upx;
				display: flex;
				align-items: center;

				/deep/ .uni-checkbox-input {
					border-radius: 30upx;
					margin-right: 0;
				}
			}

			.scbm-total {
				margin-right: 30upx;
				display: flex;
				align-items: center;

				.scbm-p {
					color: #f00;
					font-size: 44upx;
					font-weight: 600;
				}

				.scbm-a {
					display: block;
					background: #f00;
					height: 100%;
					color: #fff;
					padding: 30upx;
					margin-left: 15upx;
				}
			}
		}

		.shopping-car-bottom {
			margin-bottom: 100upx;
		}
	}
</style>
