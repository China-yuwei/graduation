<template>
	<view class="order-detail">
		<view class="order-status">
			<text>{{order.o_type}}</text>
		</view>
		<user-name-phone-address :address="address"></user-name-phone-address>
		<order-goods-info :list="order"></order-goods-info>
		<view class="order-total">
			<view class="order-total-list">
				<text>商品总价</text>
				<text>+ {{order.o_total}}</text>
			</view>
			<view class="order-total-list">
				<text>优惠券优惠</text>
				<text>- {{order.o_coupon}}</text>
			</view>
			<view class="order-total-list">
				<text>红包抵扣</text>
				<text>- {{order.o_evenlope}}</text>
			</view>
			<view class="order-total-list">
				<text>积分抵扣</text>
				<text>- {{order.o_integral}}</text>
			</view>
			<view class="order-total-list">
				<text>订单总价</text>
				<text class="odl-price">¥ {{order.o_total}}</text>
			</view>
		</view>
	</view>
</template>

<script>
	import userNamePhoneAddress from "../../components/user-name-phone-address.vue"
	import orderGoodsInfo from "../../components/order-goods-info.vue"
	export default {
		components: {
			userNamePhoneAddress,
			orderGoodsInfo
		},
		data() {
			return {
				orderStatus: "交易关闭",
				orderNum: "CD20200313111347798110463",
				order: {},
				address: {}
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
				url: 'http://localhost:3000/my/order',
				data: {
					userId: that.user.user_id
				},
				success: (res) => {
					let allOrder = res.data.data
					that.order = allOrder.filter(function(item) {
						return item.o_id == options.id
					})[0]
				}
			});
			uni.request({
				url: 'http://localhost:3000/set/address',
				data: {
					userId: that.user.user_id
				},
				success: (res) => {
					let getDate = res.data.data
					that.address = getDate.filter(function(item) {
						return item.address_id == that.order.address_id
					})[0]
				}
			});
		},
		methods: {
			handleCopyOrderNum() {
				console.log(123, "你已复制订单编号", this.orderNum)
			},
			handleContactSeller() {
				console.log(456, "联系卖家")
			},
			handleCallUp() {
				console.log(789, "拨打电话")
			},
			handleDeleteOrder() {
				console.log(101, "删除订单")
			}
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
		background: #efefef;
	}

	.order-detail {
		background: #efefef;

		.order-status {
			background: #fff;
			padding: 30upx;
			border-bottom: 10upx solid #efefef;
			color: #000;
		}

		.order-total {
			margin-top: 20upx;
			background: #fff;
			padding: 30upx;

			.order-total-list {
				display: flex;
				justify-content: space-between;
				align-items: center;
				font-size: 36upx;
				padding: 30upx 0;

				.odl-price {
					color: #f00;
				}
			}
		}

		.order-num {
			margin-top: 20upx;
			background: #fff;
			padding: 30upx;
			font-size: 36upx;

			.order-num-num {
				display: flex;
				justify-content: space-between;
				align-items: center;
				padding: 20upx 0;

				>text {
					display: -webkit-box;
					-webkit-box-orient: vertical;
					-webkit-line-clamp: 1;
					overflow: hidden;
				}

				.onn-copy {
					font-size: 30upx;
					padding: 10upx 20upx;
					border: 1upx solid #666;
					border-radius: 30upx;
					white-space: nowrap;
				}
			}

			.on-buyerMsg {
				padding: 20upx 0;
			}

			.order-num-msg {
				display: flex;
				justify-content: space-around;
				align-items: center;
				padding: 20upx 0;

				.onm-button {
					display: flex;
					align-items: center;

					image {
						width: 48upx;
						height: 48upx;
						margin-right: 10upx;
					}
				}
			}
		}

		.delete-order {
			width: 100%;
			padding: 30upx 0;
			background: #fff;
			position: fixed;
			bottom: 0;
			text-align: right;

			text {
				display: inline-block;
				margin-right: 30upx;
				border: 1upx solid #666;
				border-radius: 40upx;
				padding: 10upx 30upx;
			}
		}
	}
</style>
