<template>
	<view class="shopping-car-order-confirm-pay">
		<view class="scocp-top">
			<view class="user-name-phone">
				<text>{{address.address_user}}</text>
				<text>{{address.address_phone}}</text>
			</view>
			<view class="user-address">
				<image src="/static/shoppingCar-img/location.png" mode=""></image>
				<text>{{address.address_provence}}-{{address.address_house}}</text>
			</view>
		</view>
		<view class="scocp-price">
			<text>订单金额</text>
			<text class="scocpp-p">￥{{total}}</text>
		</view>
		<view class="scocp-type">
			<view class="scocpt-t">
				请选择支付方式
			</view>
			<view class="scocpt-t" @click="handleType">
				<text>微信支付</text>
				<view class="scocptt-icon" v-if="isChecked">√</view>
				<view class="scocptt-icon-no" v-else></view>
			</view>
			<view class="scocpt-t" @click="handleType">
				<text>支付宝支付</text>
				<view class="scocptt-icon-no" v-if="isChecked"></view>
				<view class="scocptt-icon" v-else>√</view>
			</view>
		</view>
		<view class="scocp-bottom">
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
	export default {
		data() {
			return {
				userName: "user01",
				userPhone: "13111111111",
				userAddress: "四川省成都市双流县    xx镇xx小区1-1-0101",
				total: 0,
				isChecked: true,
				order: [],
				address: []
			};
		},
		onLoad(options) {
			let that = this
			uni.request({
				url: 'http://localhost:3000/my/order/submit',
				data: {
					oId: Number(options.id)
				},
				success: (res) => {
					that.order = res.data.data
					that.total = that.order[0].o_total
					uni.request({
						url: 'http://localhost:3000/set/address',
						data: {
							userId: that.order[0].user_id
						},
						success: (res) => {
							let getData = res.data.data
							if (that.order[0].address_id != null) {
								that.address = getData.filter(function(item) {
									return item.address_id == that.order[0].address_id
								})[0]
							} else {
								that.address = getData[0]
							}
						}
					});
				}
			});
		},
		methods: {
			handleType() {
				this.isChecked = !this.isChecked
			},
			handleSubmit() {
				uni.showToast({
					title: '支付功能等待后续完善',
					icon: 'none',
					duration: 2000
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

	.shopping-car-order-confirm-pay {
		background: #efefef;

		.scocp-top {
			padding: 30upx;
			background: #fff;

			.user-name-phone {
				font-size: 40upx;
				margin-bottom: 20upx;

				text {
					padding-right: 30upx;
				}
			}

			.user-address {
				color: #666;
				font-size: 32upx;
				display: flex;
				align-items: center;

				image {
					width: 40upx;
					height: 40upx;
					margin-right: 30upx;
				}
			}
		}

		.scocp-price {
			padding: 30upx;
			background: #fff;
			margin-top: 30upx;
			display: flex;
			justify-content: space-between;
			align-items: center;

			.scocpp-p {
				color: #f00;
			}
		}

		.scocp-type {
			background: #fff;
			margin-top: 30upx;

			.scocpt-t {
				padding: 30upx;
				border-bottom: 1upx solid #666;
				display: flex;
				justify-content: space-between;
				align-items: center;

				.scocptt-icon {
					width: 48upx;
					height: 48upx;
					background: #f00;
					color: #fff;
					border-radius: 45upx;
					text-align: center;
					line-height: 48upx;
				}

				.scocptt-icon-no {
					width: 48upx;
					height: 48upx;
					border: 1upx solid #666;
					border-radius: 45upx;
				}
			}
		}

		.scocp-bottom {
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
