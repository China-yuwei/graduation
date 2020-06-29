<template>
	<view class="shopping-car-order-confirm-price" name="shoppingCarOrderConfirmPrice">
		<view class="scocg-title">
			<image src="/../static/goodsClass-img/dianpu.png" mode=""></image>
			<text>{{lists.shop_name}}</text>
		</view>
		<view class="scocg-good">
			<image :src="lists.g_src" mode=""></image>
			<view class="scocgg-right">
				<view class="scocggr-top">
					<text class="scocggr-top-in">{{lists.g_name}}</text>
					<text class="scocggr-top-p">￥{{lists.g_price}}</text>
				</view>
				<view class="scocggr-num">
					x{{lists.g_num}}
				</view>
			</view>
		</view>
		<view class="scocg-type">
			<text>配送方式</text>
			<text class="scocgt-type">快递</text>
		</view>
		<view class="scocg-notes">
			<text>备注：</text>
			<input type="text" value="" placeholder="(选填)请填写备注" />
		</view>
		<view class="scocg-bottom">
			店铺合计(含运费)：<text>￥{{price}}</text>
		</view>
	</view>
</template>

<script>
	export default {
		name: "shoppingCarOrderConfirmPrice",
		props: {
			lists: {}
		},
		data() {
			return {

			};
		},
		computed: {
			price() {
				let price = this.lists.g_price * this.lists.g_num
				return price
			}
		}
	}
</script>

<style lang="less">
	.shopping-car-order-confirm-price {
		background: #fff;
		border-radius: 15upx;
		padding: 30upx;
		margin-top: 30upx;

		.scocg-title {
			display: flex;
			align-items: center;

			image {
				width: 40upx;
				height: 40upx;
				margin-right: 30upx;
			}
		}

		.scocg-good {
			margin-top: 15upx;
			display: flex;
			align-items: center;

			image {
				width: 160upx;
				height: 160upx;
				margin-right: 15upx;
				border-radius: 15upx;
			}

			.scocgg-right {
				flex: 1;
				height: 160upx;

				.scocggr-top {
					display: flex;
					justify-content: space-between;

					.scocggr-top-in {
						font-size: 32upx;
						overflow: hidden;
						text-overflow: ellipsis;
						display: -webkit-box;
						-webkit-line-clamp: 2;
						-webkit-box-orient: vertical;
					}

					.scocggr-top-p {
						font-size: 40upx;
						padding-left: 15upx;
						color: #f00;
					}
				}

				.scocggr-num {
					text-align: right;
					color: #999;
					font-size: 28upx;
				}
			}
		}

		.scocg-type {
			padding: 30upx 0 0;
			display: flex;
			justify-content: space-between;

			.scocgt-type {
				color: #666;
			}

			.scocgt-coupon {
				display: flex;
				align-items: center;
				color: #f00;

				image {
					width: 40upx;
					height: 40upx;
					margin-left: 15upx;
				}
			}
		}

		.scocg-notes {
			padding: 30upx 0 0;
			display: flex;
			align-items: center;
			vertical-align: middle;

			input {
				width: 75%;
				padding-left: 15upx;
				vertical-align: middle;
			}
		}

		.scocg-bottom {
			text-align: right;

			text {
				color: #f00;
				font-size: 40upx;
			}
		}
	}
</style>
