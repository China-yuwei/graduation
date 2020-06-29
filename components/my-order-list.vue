<template>
	<view class="my-order-list" name="myOrderList">
		<view class="mol-title">
			<view class="molt-left">
				<image src="/../static/goodsClass-img/dianpu.png" mode=""></image>
				<text>{{lists.shop_name}}</text>
			</view>
			<text>{{lists.o_type}}</text>
		</view>
		<view class="molt-center">
			<image :src="lists.g_src" mode=""></image>
			<view class="moltc-right">
				<view class="moltcr-top">
					<text>{{lists.g_name}}</text>
					<text>￥ <text class="moltcrt-price">{{lists.g_price}}</text></text>
				</view>
				<text>x {{lists.g_num}}</text>
			</view>
		</view>
		<view class="molt-bottom">
			<view class="moltb-top">
				共<text>{{lists.g_num}}</text>件商品 合计:￥ <text class="moltbt-price">{{total}}</text>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		name: "myOrderList",
		props: {
			lists: {}
		},
		data() {
			return {

			};
		},
		computed: {
			total() {
				return this.lists.g_num * this.lists.g_price
			}
		},
	}
</script>

<style lang="less">
	.my-order-list {
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
					padding: 0 30upx;
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
					color: #999;
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
					border: 1upx solid #999;
					border-radius: 45upx;
					color: #999;
				}
			}
		}
	}
</style>
