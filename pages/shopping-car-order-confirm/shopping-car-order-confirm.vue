<template>
	<view class="shopping-car-order-confirm">
		<view class="scoc">
			<view class="scoc-user">
				<view class="scocu-left">
					<text>{{address.address_user}} {{address.address_phone}}</text>
					<text class="scocu-left-address">{{address.address_provence}}-{{address.address_house}}</text>
				</view>
				<image src="../../static/my-img/youjiantou.png" mode="" @click="handleAddress"></image>
			</view>
			<view class="scoc-good" v-for="(item,index) in goods" :key="index">
				<shoppingCarOrderConfirmPrice :lists="item"></shoppingCarOrderConfirmPrice>
			</view>
			<view class="scoc-coupon">
				<text>请选择优惠</text>
				<view class="scocc-list">
					<text>平台优惠券</text>
					<image src="../../static/my-img/youjiantou.png" mode="" @click="handleC"></image>
				</view>
				<view class="scocc-list">
					<text>红包抵扣{{envelope}}元</text>
					<evan-switch v-model="checkedE" inactive-color="#999"></evan-switch>
				</view>
				<view class="scocc-list">
					<text>可用{{integralNum}}积分抵用{{integralPrice}}元</text>
					<evan-switch v-model="checkedI" inactive-color="#999"></evan-switch>
				</view>
			</view>
		</view>
		<uni-popup ref="popup" type="bottom" class="scoc-popup">
			<view class="scoc-pop">
				<view class="scocp-title">优惠券</view>
				<view class="scocp-text">
					<text>领券</text>
					<text>共{{num}}张优惠券</text>
				</view>
				<view class="mccl-content" v-for="(item,index) in couponLists" :key="index">
					<view class="mcclc-left">
						￥<text>{{item.c_money}}</text>
					</view>
					<view class="mcclc-center">
						<text>满{{item.c_full}}减{{item.c_money}}</text>
						<text class="mcclc-center-time">{{item.c_time}}至{{item.c_endTime}}</text>
					</view>
					<view class="mccle-right" @click="handleUse(index)">
						<text>去使用</text>
					</view>
				</view>
			</view>
		</uni-popup>

		<view class="scoc-bottom">
			<view class="scocb-total">
				合计：<text>￥{{total}}</text>
			</view>
			<view class="scocb-submit" @click="handleSubmit">
				提交订单
			</view>
		</view>
	</view>
</template>

<script>
	import shoppingCarOrderConfirmPrice from '../../components/shopping-car-order-confirm-price.vue';
	export default {
		components: {
			shoppingCarOrderConfirmPrice
		},
		data() {
			return {
				envelope: 0,
				integralNum: 0,
				integralPrice: 0,
				num: 0,
				checkedE: false,
				checkedI: false,
				scrollY: true,
				user: [],
				address: [],
				goods: [],
				couponLists: [],
				id: 0
			};
		},
		onLoad(options) {
			this.id = options.id
		},
		onShow() {
			let that = this
			uni.getStorage({
				key: 'user_login',
				success(res) {
					that.user = res.data
				}
			});
			uni.request({
				url: 'http://localhost:3000/my/order/confirm',
				data: {
					scId: that.id
				},
				success: (res) => {
					that.goods = res.data.data
					uni.request({
						url: 'http://localhost:3000/set/address',
						data: {
							userId: that.user.user_id
						},
						success: (res) => {
							let getData = res.data.data
							if (that.goods[0].address_id != null) {
								that.address = getData.filter(function(item) {
									return item.address_id == that.goods[0].address_id
								})[0]
							} else {
								that.address = getData[0]
							}
						}
					});
				}
			});
			uni.request({
				url: 'http://localhost:3000/my/integral',
				data: {
					userId: that.user.user_id
				},
				success: (res) => {
					let integralList = res.data.data
					let negative = 0
					let right = 0
					let aaa = integralList.forEach(function(item) {
						if (item.i_id == 1) {
							return right += item.i_num
						} else {
							return negative += item.i_num
						}
					})
					that.integralNum = right - negative
					that.integralPrice = that.integralNum / 100
				}
			});
			uni.request({
				url: 'http://localhost:3000/my/envelope',
				data: {
					userId: that.user.user_id
				},
				success: (res) => {
					let getData = res.data.data
					let num = 0
					that.envelope = 0
					getData.forEach(function(item) {
						num = num + Number(item.e_money)
					})
					that.envelope = num.toFixed(2)
				}
			});
			uni.request({
				url: 'http://localhost:3000/my/coupon',
				data: {
					userId: that.user.user_id
				},
				success: (res) => {
					that.couponLists = res.data.data
					that.num = that.couponLists.length
				}
			});
		},
		computed: {
			total() {
				let that = this
				let totalPrice = 0
				that.goods.forEach(function(item) {
					totalPrice = totalPrice + item.g_num * item.g_price
				})
				if (that.checkedE == true && that.checkedI == true) {
					return totalPrice - that.integralPrice - that.envelope
				} else if (that.checkedE == true && that.checkedI == false) {
					return totalPrice - that.envelope
				} else if (that.checkedE == false && that.checkedI == true) {
					return totalPrice - that.integralPrice
				} else {
					return totalPrice
				}
			}
		},
		methods: {
			handleC() {
				this.$refs.popup.open()
			},
			handleUse(index) {
				this.$refs.popup.close()
			},
			handleSubmit() {
				let that = this
				let e = 0;
				let i = 0;
				let crtTime = new Date()
				let nowTime = that.dateFtt("yyyy-MM-dd hh:mm:ss", crtTime)
				if (that.checkedE == true) {
					e = that.envelope
					uni.request({
						url: 'http://localhost:3000/add/my/envelope',
						data: {
							envelopeName: "红包抵扣",
							envelopeType: 0,
							userId: that.goods[0].user_id,
							envelopeTime: nowTime,
							envelopeNum: that.envelope
						},
						success: (res) => {
							console.log("红包抵扣", res)
						}
					});
				}
				if (that.checkedI == true) {
					i = that.integralPrice
					uni.request({
						url: 'http://localhost:3000/add/my/integral',
						data: {
							integralName: "积分兑换",
							integralId: 3,
							userId: that.goods[0].user_id,
							integralTime: nowTime,
							integralNum: that.integralNum
						},
						success: (res) => {
							console.log("积分兑换", res)
						}
					});
				}
				uni.request({
					url: 'http://localhost:3000/my/order/confirm/submit',
					data: {
						orderId: that.goods[0].o_id,
						orderE: e,
						orderI: i,
						orderC: 0,
						orderT: that.total
					},
					success: (res) => {
						uni.navigateTo({
							url: '../shopping-car-order-confirm-pay/shopping-car-order-confirm-pay?id=' + this.goods[0].o_id
						});
					}
				});
			},
			handleAddress() {
				uni.navigateTo({
					url: '../shopping-car-order-confirm-address/shopping-car-order-confirm-address?id=' + this.goods[0].o_id
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
	uni-page-body {
		height: 100%;
		background: #efefef;
	}

	.shopping-car-order-confirm {
		height: 100%;
		background: #efefef;
		position: relative;

		.scoc {
			background: #E9E9E9;
			padding: 30upx;
			margin-bottom: 120upx;

			.scoc-user {
				background: #fff;
				border-radius: 15upx;
				padding: 30upx;
				display: flex;
				justify-content: space-between;
				align-items: center;

				.scocu-left {
					display: flex;
					flex-direction: column;

					.scocu-left-address {
						color: #666;
						font-size: 28upx;
					}
				}

				image {
					width: 40upx;
					height: 40upx;
				}
			}

			.scoc-coupon {
				background: #fff;
				border-radius: 15upx;
				padding: 30upx;
				margin-top: 30upx;

				.scocc-list {
					padding: 30upx 0 0 0;
					display: flex;
					justify-content: space-between;
					align-items: center;

					image {
						width: 40upx;
						height: 40upx;
					}
				}
			}
		}

		/deep/ .scoc-popup {
			height: 100%;

			.uni-transition {
				height: 75%;

				.uni-popup__wrapper-box {
					height: 100%;

					.scoc-pop {
						height: 100%;
						padding: 30upx;
						background: #fff;
						border-top-left-radius: 15upx;
						border-top-right-radius: 15upx;

						.scocp-title {
							text-align: center;
							color: #666;
						}

						.scocp-text {
							display: flex;
							justify-content: space-between;
							color: #666;
							padding-top: 30upx;
						}

						.mccl-content:first-child {
							margin: 0;
						}

						.mccl-content {
							color: #f00;
							display: flex;
							margin-top: 30upx;

							.mcclc-left {
								background: #efefef;
								padding-left: 15upx;
								width: 180upx;
								border-radius: 15upx;
								display: flex;
								align-items: center;
								justify-content: flex-start;

								text {
									font-size: 60upx;
								}
							}

							.mcclc-center {
								padding: 15upx 15upx;
								background: #efefef;
								border-radius: 15upx;
								flex: 1;
								display: flex;
								flex-direction: column;

								.mcclc-center-time {
									font-size: 28upx;
									padding-top: 15upx;
								}
							}

							.mccle-right {
								background: #efefef;
								padding-left: 15upx;
								width: 180upx;
								border-radius: 15upx;
								display: flex;
								align-items: center;
								justify-content: center;

								text {
									background: #f00;
									color: #fff;
									border-radius: 45upx;
									padding: 10upx 15upx;
								}
							}
						}
					}
				}
			}
		}

		.scoc-bottom {
			position: fixed;
			bottom: 0;
			width: 100%;
			padding: 10upx 0;
			background: #fff;
			display: flex;
			justify-content: flex-end;
			align-items: center;

			.scocb-total {
				text {
					color: #f00;
					font-size: 50upx;
				}
			}

			.scocb-submit {
				background: #f00;
				border-radius: 45upx;
				color: #fff;
				margin: 0 30upx;
				padding: 20upx 30upx;
			}
		}
	}
</style>
