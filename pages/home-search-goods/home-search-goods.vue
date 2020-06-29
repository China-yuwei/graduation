<template>
	<view class="home-search-goods">
		<view class="gcc-content">
			<view class="home-goods-introduce-list" v-for="(item,index) in currentGoods" :key="index" @click="handleG(item)">
				<image :src="item.g_src" mode=""></image>
				<view class="hgi-center">
					<text class="hgi-center-introduce">
						<text class="hgi-center-text-y">{{item.shopsSignY}}</text>
						<text class="hgi-center-text-v">{{item.shopsSignV}}</text>
						{{item.g_introduce}}
					</text>
				</view>
				<view class="hgi-ad">
					<view class="hgi-ad-type">
						<text>{{item.type}}</text>
						<text>{{item.del}}</text>
					</view>
					<text class="hgi-ad-address">{{item.address}}</text>
				</view>
				<view class="hgi-bottom">
					<text class="hgi-bottom-price">￥ {{item.g_price}}</text>
					<text class="hgi-bottom-num">{{item.g_buy_num}} 人付款</text>
				</view>
			</view>
		</view>
		<view class="hsg-text" :style="isShow">
			暂无数据
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				currentGoods: [],
				isShow: "display:block",
				isSign: true,
				user: []
			};
		},
		onLoad(options) {
			let that = this
			uni.request({
				url: 'http://localhost:3000/home/toSearch',
				data: {
					inputKeyword: options.key
				},
				success: (res) => {
					that.currentGoods = res.data.data
					if (that.currentGoods.length > 0) {
						that.isShow = "display:none"
					}
				}
			});
		},
		methods: {
			handleG(item) {
				uni.navigateTo({
					url: '../goods-class-detail/goods-class-detail?goods=' + JSON.stringify(item)
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

	.home-search-goods {
		padding: 30upx;
		background: #efefef;

		.gcc-content {
			display: flex;
			flex-wrap: wrap;
			justify-content: space-between;

			.home-goods-introduce-list {
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

				.hgi-ad {
					width: 100%;
					display: flex;
					justify-content: space-between;

					.hgi-ad-type {
						text {
							color: #fff;
							background: #f00;
							border-radius: 15upx;
						}
					}

					.hgi-ad-address {
						color: #666;
						border: 1upx solid #666;
						border-radius: 15upx;
					}
				}

				.hgi-bottom {
					width: 100%;
					padding: 0 10upx;
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

		.hsg-text {
			text-align: center;
			padding: 30upx;
		}
	}
</style>
