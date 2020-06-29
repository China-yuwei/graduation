<template>
	<view name="homeGoodsIntroduce" class="home-goods-introduce">
		<image :src="lists.g_src" mode=""></image>
		<view class="hgi-center">
			<text class="hgi-center-introduce">{{lists.g_introduce}}</text>
		</view>
		<view class="hgi-bottom">
			<text class="hgi-bottom-price">￥ {{lists.g_price}}</text>
			<text class="hgi-bottom-num">{{lists.g_buy_num}} 人付款</text>
		</view>
	</view>
</template>

<script>
	export default {
		name: 'homeGoodsIntroduce',
		data() {
			return {

			};
		},
		props: {
			lists: {}
		},
		methods: {
		}
	}
</script>

<style lang="less">
	.home-goods-introduce {
		// display: flex;
		image {
			border-radius: 16upx;
			width: 100%;
			height: 360upx;
		}

		.hgi-center {
			padding: 15upx 10upx;

			.hgi-center-introduce {
				font-size: 32upx;
				overflow: hidden;
				text-overflow: ellipsis;
				display: -webkit-box;
				-webkit-line-clamp: 2;
				-webkit-box-orient: vertical;

				.hgi-center-text-y {
					background: #ff0000;
					border-radius: 8upx;
					color: #fff;
					font-size: 30upx;
					margin-right: 15upx;
				}

				.hgi-center-text-v {
					background: #ff0000;
					color: #fff;
					font-size: 30upx;
					border-radius: 8upx;
				}
			}
		}

		.hgi-bottom {
			width: 100%;
			display: flex;
			justify-content: space-between;
			align-items: flex-end;

			.hgi-bottom-price {
				color: #ff0000;
				font-size: 40upx;
			}

			.hgi-bottom-num {
				color: #666666;
				font-size: 24upx;
				// padding-left: 30upx;
			}
		}
	}
</style>
