<template>
	<view class="you-maybe-like-more" name="youMaybeLikeMore">
		<view class="ymlm-head">
			<view class="ymlm-head-line"></view>
			<view class="ymlm-head-circle"></view>
			<image src="/static/home-img/xihuan.png" mode=""></image>
			<text>你可能还喜欢</text>
			<view class="ymlm-head-circle"></view>
			<view class="ymlm-head-line"></view>
		</view>
		<view class="home-goods-introduce">
			<view class="home-goods-introduce-list" v-for="(item,index) in goodslists" :key="index" @click="handleGoods(item)">
				<image :src="item.g_src" mode=""></image>
				<view class="hgi-center">
					<text class="hgi-center-introduce">
						<text class="hgi-center-text-y">{{item.shopsSignY}}</text>
						<text class="hgi-center-text-v">{{item.shopsSignV}}</text>
						{{item.g_introduce}}
					</text>
				</view>
				<view class="hgi-bottom">
					<text class="hgi-bottom-price">￥ {{item.g_price}}</text>
					<text class="hgi-bottom-num">{{item.g_buy_num}} 人付款</text>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		name: "youMaybeLikeMore",
		props:{
			goodslists: null
		},
		data() {
			return {
				
			};
		},
		methods: {
			handleGoods(item) {
				uni.navigateTo({
					url:'../goods-class-detail/goods-class-detail?goods=' + JSON.stringify(item)
				})
			}
		}
	}
</script>

<style lang="less">
	.you-maybe-like-more {
		// margin-bottom: 120upx;
		background: #E9E9E9;

		.ymlm-head {
			display: flex;
			justify-content: center;
			align-items: center;
			padding: 30upx 0;
			.ymlm-head-line {
				width: 100upx;
				height: 2upx;
				background: #f00;
			}

			.ymlm-head-circle {
				width: 10upx;
				height: 10upx;
				border: 2px solid #f00;
				border-radius: 60%;
			}
			text{
				display: inline-block;
				margin: 0 30upx 0 20upx;
			}
			image {
				width: 60upx;
				height: 60upx;
				margin-left: 20upx;
			}
		}

		.home-goods-introduce {
			padding: 0 30upx;
			display: flex;
			flex-wrap: wrap;
			justify-content: space-between;
			.home-goods-introduce-list{
				width: 48%;
				display: flex;
				flex-direction: column;
				align-items: center;
				background: #fff;
				border-radius: 16upx;
				margin-bottom: 30upx;
				image {
					border-radius: 16upx;
					width: 100%;
					height: 360upx;
				}
				
				.hgi-center {
					padding: 30upx 10upx;
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
		}
	}
</style>
