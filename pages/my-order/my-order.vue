<template>
	<view class="my-order">
		<view class="mo-tab">
			<scroll-view scroll-x="true" :show-scrollbar="isScrollbar">
				<home-tab id="tabbar" :values="items" :stickyTop="108" :current="current" @clickItem="onClickItem"></home-tab>
			</scroll-view>
		</view>
		<!-- 全部 -->
		<view class="mo-center" v-if="current == 0">
			<view class="mo-content" v-if="isHave">
				<view class="moc-list" v-for="(item,index) in orderList" :key="index" @click="handleOrder(item)">
					<myOrderList :lists="item"></myOrderList>
				</view>
			</view>
			<view class="mo-content-else" v-else>
				<image src="../../static/home-img/zanwushuju.png" mode=""></image>
				<view>暂无数据</view>
			</view>
		</view>
		<!-- 待付款 -->
		<view class="mo-center" v-else-if="current == 1">
			<view class="mo-content" v-if="isHave">
				<view class="moc-list" v-for="(item,index) in orderPayment" :key="index" @click="handleOrder(item)">
					<myOrderList :lists="item"></myOrderList>
				</view>
			</view>
			<view class="mo-content-else" v-else>
				<image src="../../static/home-img/zanwushuju.png" mode=""></image>
				<view>暂无数据</view>
			</view>
		</view>
		<!-- 待发货 -->
		<view class="mo-center" v-else-if="current == 2">
			<view class="mo-content" v-if="isHave">
				<view class="moc-list" v-for="(item,index) in orderDelivery" :key="index" @click="handleOrder(item)">
					<myOrderList :lists="item"></myOrderList>
				</view>
			</view>
			<view class="mo-content-else" v-else>
				<image src="../../static/home-img/zanwushuju.png" mode=""></image>
				<view>暂无数据</view>
			</view>
		</view>
		<!-- 待收货 -->
		<view class="mo-center" v-else-if="current == 3">
			<view class="mo-content" v-if="isHave">
				<view class="moc-list" v-for="(item,index) in orderReceiving" :key="index" @click="handleOrder(item)">
					<myOrderList :lists="item"></myOrderList>
				</view>
			</view>
			<view class="mo-content-else" v-else>
				<image src="../../static/home-img/zanwushuju.png" mode=""></image>
				<view>暂无数据</view>
			</view>
		</view>
		<!-- 待评价 -->
		<view class="mo-center" v-else-if="current == 4">
			<view class="mo-content" v-if="isHave">
				<view class="moc-list" v-for="(item,index) in orderAppraisals" :key="index" @click="handleOrder(item)">
					<myOrderList :lists="item"></myOrderList>
				</view>
			</view>
			<view class="mo-content-else" v-else>
				<image src="../../static/home-img/zanwushuju.png" mode=""></image>
				<view>暂无数据</view>
			</view>
		</view>
		<!-- 已成功 -->
		<view class="mo-center" v-else-if="current == 5">
			<view class="mo-content" v-if="isHave">
				<view class="moc-list" v-for="(item,index) in orderSuccess" :key="index" @click="handleOrder(item)">
					<myOrderList :lists="item"></myOrderList>
				</view>
			</view>
			<view class="mo-content-else" v-else>
				<image src="../../static/home-img/zanwushuju.png" mode=""></image>
				<view>暂无数据</view>
			</view>
		</view>
		<!-- 已关闭 -->
		<view class="mo-center" v-else>
			<view class="mo-content" v-if="isHave">
				<view class="moc-list" v-for="(item,index) in orderFail" :key="index" @click="handleOrder(item)">
					<myOrderList :lists="item"></myOrderList>
				</view>
			</view>
			<view class="mo-content-else" v-else>
				<image src="../../static/home-img/zanwushuju.png" mode=""></image>
				<view>暂无数据</view>
			</view>
		</view>
		<view class="shopping-car-bottom">
			<you-maybe-like-more :goodslists="goodsLists"></you-maybe-like-more>
		</view>
	</view>
</template>

<script>
	import youMaybeLikeMore from '../../components/you-maybe-like-more.vue';
	import homeTab from '../../components/home-tab.vue';
	import myOrderList from '../../components/my-order-list.vue';
	export default {
		components: {
			homeTab,
			youMaybeLikeMore,
			myOrderList
		},
		data() {
			return {
				items: ["全部", "待付款", "待发货", "待收货", "待评价", "已成功", "已关闭"],
				current: 0,
				isScrollbar: false, //是否显示滚动条
				isHave: true,
				orderList: [], //全部
				orderPayment: [], //待付款
				orderDelivery: [], //待发货
				orderReceiving: [], //待收货
				orderAppraisals: [], //待评价
				orderSuccess: [], //已成功
				orderFail: [], //已关闭
				delId: 0,
				goodsLists: []
			};
		},
		onLoad(options) {
			let that = this
			uni.getStorage({
				key: 'user_login',
				success(res) {
					that.user = res.data
				}
			});
			uni.request({
				url: 'http://localhost:3000/goods',
				success: (res) => {
					that.goodsLists = res.data.data
				}
			});
			uni.request({
				url: 'http://localhost:3000/my/order',
				data: {
					userId: that.user.user_id
				},
				success: (res) => {
					that.orderLists = res.data.data
					that.orderList = that.orderLists.sort(function(a, b) {
						let x = a.o_time.toLowerCase();
						let y = b.o_time.toLowerCase();
						if (x < y) {
							return 1;
						}
						if (x > y) {
							return -1;
						}
						return 0;
					})
					that.current = that.items.indexOf(options.orderName)
					if (that.current == 0) {
						if (that.orderList.length < 1) {
							that.isHave = false
						} else {
							that.isHave = true
						}
					}
					if (that.current == 1) {
						that.orderPayment = that.orderList.filter(function(item) {
							return item.o_type == "待付款"
						})
						if (that.orderPayment.length < 1) {
							that.isHave = false
						} else {
							that.isHave = true
						}
					}
					if (that.current == 2) {
						that.orderDelivery = that.orderList.filter(function(item) {
							return item.o_type == "待发货"
						})
						if (that.orderDelivery.length < 1) {
							that.isHave = false
						} else {
							that.isHave = true
						}
					}
					if (that.current == 3) {
						that.orderReceiving = that.orderList.filter(function(item) {
							return item.o_type == "待收货"
						})
						if (that.orderReceiving.length < 1) {
							that.isHave = false
						} else {
							that.isHave = true
						}
					}
					if (that.current == 4) {
						that.orderAppraisals = that.orderList.filter(function(item) {
							return item.o_type == "待评价"
						})
						if (that.orderAppraisals.length < 1) {
							that.isHave = false
						} else {
							that.isHave = true
						}
					}
					if (that.current == 5) {
						that.orderSuccess = that.orderList.filter(function(item) {
							return item.o_type == "已成功"
						})
						if (that.orderSuccess.length < 1) {
							that.isHave = false
						} else {
							that.isHave = true
						}
					}
					if (that.current == 6) {
						that.orderFail = that.orderList.filter(function(item) {
							return item.o_type == "已关闭"
						})
						if (that.orderFail.length < 1) {
							that.isHave = false
						} else {
							that.isHave = true
						}
					}
				}
			});

		},
		methods: {
			onClickItem(index) { //选项卡
				let that = this
				if (that.current !== index) {
					that.current = index;
					if (that.current == 0) {
						if (that.orderList.length < 1) {
							that.isHave = false
						} else {
							that.isHave = true
						}
					}
					if (that.current == 1) {
						that.orderPayment = that.orderList.filter(function(item) {
							return item.o_type == "待付款"
						})
						if (that.orderPayment.length < 1) {
							that.isHave = false
						} else {
							that.isHave = true
						}
					}
					if (that.current == 2) {
						that.orderDelivery = that.orderList.filter(function(item) {
							return item.o_type == "待发货"
						})
						if (that.orderDelivery.length < 1) {
							that.isHave = false
						} else {
							that.isHave = true
						}
					}
					if (that.current == 3) {
						that.orderReceiving = that.orderList.filter(function(item) {
							return item.o_type == "待收货"
						})
						if (that.orderReceiving.length < 1) {
							that.isHave = false
						} else {
							that.isHave = true
						}
					}
					if (that.current == 4) {
						that.orderAppraisals = that.orderList.filter(function(item) {
							return item.o_type == "待评价"
						})
						if (that.orderAppraisals.length < 1) {
							that.isHave = false
						} else {
							that.isHave = true
						}
					}
					if (that.current == 5) {
						that.orderSuccess = that.orderList.filter(function(item) {
							return item.o_type == "已成功"
						})
						if (that.orderSuccess.length < 1) {
							that.isHave = false
						} else {
							that.isHave = true
						}
					}
					if (that.current == 6) {
						that.orderFail = that.orderList.filter(function(item) {
							return item.o_type == "已关闭"
						})
						if (that.orderFail.length < 1) {
							that.isHave = false
						} else {
							that.isHave = true
						}
					}
				}
			},
			handleOrder(item) {
				uni.navigateTo({
					url: '../shopping-car-order-detail/shopping-car-order-detail?id=' + item.o_id
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

	.my-order {
		.mo-center {
			background: #efefef;

			.mo-content {
				.moc-list {
					width: 95%;
					margin: 30upx auto 0;
					background: #fff;
					border-radius: 30upx;

					.mol-title {
						display: flex;
						align-items: center;
						justify-content: space-between;
						padding: 30upx;

						.molt-left {
							display: flex;
							align-items: center;

							image {
								width: 40upx;
								height: 40upx;
							}

							text {
								padding: 0 15upx;
							}
						}

						>text {
							color: #f00;
						}
					}

					.molt-center {
						padding: 0 30upx;
						display: flex;
						justify-content: space-between;
						align-items: center;

						image {
							width: 160upx;
							height: 160upx;
							border-radius: 15upx;
						}

						.moltc-right {
							height: 160upx;
							flex: 1;
							margin-left: 15upx;

							.moltcr-top {
								display: flex;
								justify-content: space-between;
								align-items: center;

								.moltcrt-price {
									color: #f00;
									font-size: 48upx;
								}
							}

							>text {
								display: block;
								color: #666;
								font-size: 30upx;
								text-align: right;
							}
						}
					}

					.molt-bottom {
						padding: 30upx;

						.moltb-top {
							text-align: right;
							padding-bottom: 30upx;

							text {
								color: #f00;
							}

							.moltbt-price {
								font-size: 48upx;
							}
						}

						.moltb-bottom {
							text-align: right;

							text {
								padding: 15upx 30upx;
								border: 1upx solid #666;
								border-radius: 45upx;
								color: #666;
							}
						}
					}
				}
			}

			.mo-content-else {
				padding: 30upx 0;
				text-align: center;

				image {
					width: 120upx;
					height: 120upx;
				}
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

	/deep/ .uni-popup__wrapper-box {
		width: 90%;
		margin: 0 auto;
		background: fff;
		border-radius: 15upx;

		.mol-popup {

			.molp-text {
				text-align: center;
				padding: 60upx 0;
				border-bottom: 1upx solid #666;
			}

			.molp-button {
				display: flex;
				align-items: center;
				justify-content: space-between;
				padding: 30upx 0;
				text-align: center;

				text {
					display: block;
					width: 50%;
				}
			}
		}
	}
</style>
