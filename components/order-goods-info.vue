<template>
	<view class="order-goods-info" name="orderGoodsInfo">
		<view class="ogi-title">
			<image src="/../static/goodsClass-img/dianpu.png" mode=""></image>
			<text>{{list.shop_name}}</text>
			<!-- <image src="/../static/my-img/youjiantou.png" mode=""></image> -->
		</view>
		<view class="ogi-content">
			<image :src="list.g_src" mode=""></image>
			<view class="ogi-content-info">
				<view class="ogici-name">
					<text>{{list.g_name}}</text>
					<text class="ogici-price">¥ {{list.g_price}}</text>
				</view>
				<text>x{{list.g_num}}</text>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		name: "orderGoodsInfo",
		props:{
			list:{}
		},
		data() {
			return {

			};
		}
	}
</script>

<style lang="less">
	.order-goods-info {
		padding: 30upx;
		background: #fff;
		margin-top: 20upx;
		.ogi-title{
			display: flex;
			align-items: center;
			padding-bottom: 40upx;
			font-size: 36upx;
			image{
				width: 44upx;
				height: 44upx;
			}
			text{
				margin: 0 40upx;
				color: #666;
			}
		}
		.ogi-content{
			display: flex;
			justify-content: space-between;
			font-size: 36upx;
			image{
				width: 200upx;
				height: 200upx;
			}
			.ogi-content-info{
				width: calc(70%);
				text-align: right;
				>text{
					color: #999;
					font-size: 32upx;
				}
				.ogici-name{
					display: flex;
					justify-content: space-between;
					align-items: center;
					.ogici-price{
						font-size: 48upx;
						color: #000;
					}
				}
			}
		}
	}
</style>
