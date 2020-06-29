<template>
	<view class="admin-shops">
		<view class="msct-list" v-for="(item,index) in shops" :key="index">
			<view class="msctl-title">
				<view class="msctlt-left">
					<image :src="item.s_icon" mode=""></image>
					<view class="msctltl-name">
						<text class="msctltl-name-shop">{{item.s_name}}</text>
						<view class="msctltl-name-spe">
							<text>{{item.s_p}}</text>
							<text>{{item.s_y}}</text>
							<text>{{item.s_v}}</text>
						</view>
					</view>
				</view>
				<view class="msctlt-right">
					<image src="../../static/my-img/bianjidizhi.png" mode="" @click="handleEdit(item)"></image>
					<image src="../../static/my-img/shanchu.png" mode="" @click="handleDelete(item)"></image>
				</view>
			</view>
			<view class="msctl-center">
				<image src="../../static/goodsClass-img/dianpu.png" mode=""></image>
				<text>经营：{{item.s_run}}</text>
			</view>
			<view class="msctl-img">
				<image :src="item.s_bg" mode=""></image>
				<view class="msctli-img">
					<image :src="item.s_bga" mode=""></image>
					<image :src="item.s_bgb" mode=""></image>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				shops: []
			};
		},
		onLoad() {
			let that = this
			uni.request({ //店铺
				url: 'http://localhost:3000/shops',
				success: (res) => {
					let getData = res.data.data
					that.shops = getData.sort(function(a, b) {
						let x = a.s_person;
						let y = b.s_person;
						if (x < y) {
							return 1;
						}
						if (x > y) {
							return -1;
						}
						return 0;
					})
				}
			});
		},
		methods: {
			handleDelete(item) {
				uni.request({ //选项卡
					url: 'http://localhost:3000/del/shops',
					data: {
						shopsId: item.shop_id
					},
					success: (res) => {
						uni.showToast({
							title: res.data.data,
							icon: 'none',
							duration: 2000
						})
						this.shops = this.shops.filter(function(i) {
							return i.shop_id != item.shop_id
						})
					}
				});
			},
			handleEdit(item) {
				uni.showToast({
					icon: 'none',
					title: '暂时不可编辑店铺',
					duration: 1000
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

	.admin-shops {
		background: #efefef;
		padding: 30upx;

		.msct-list:first-child {
			margin: 0;
		}

		.msct-list {
			margin-top: 30upx;
			background: #fff;
			border-radius: 15upx;
			padding: 30upx;

			.msctl-title {
				display: flex;
				align-items: center;
				justify-content: space-between;

				.msctlt-left {
					display: flex;
					align-items: center;

					image {
						width: 90upx;
						height: 90upx;
						margin-right: 15upx;
						border-radius: 45upx;
					}

					.msctltl-name {
						display: flex;
						flex-direction: column;

						.msctltl-name-shop {
							overflow: hidden;
							text-overflow: ellipsis;
							white-space: nowrap;
						}

						.msctltl-name-spe {
							text {
								background: #f00;
								color: #fff;
								font-size: 28upx;
							}
						}
					}
				}

				.msctlt-right {
					image {
						width: 40upx;
						height: 40upx;
						margin-left: 15upx;
					}
				}
			}

			.msctl-center {
				margin: 30upx 0;
				padding: 30upx;
				background: #efefef;
				border-radius: 15upx;
				display: flex;
				align-items: center;

				image {
					width: 40upx;
					height: 40upx;
					margin-right: 15upx;
				}

				text {
					width: 90%;
					overflow: hidden;
					white-space: nowrap;
					text-overflow: ellipsis;
				}
			}

			.msctl-img {
				display: flex;
				align-items: center;

				>image {
					width: 60%;
					height: 200upx;
					margin-right: 30upx;
				}

				.msctli-img {
					flex: 1;
					display: flex;
					flex-direction: column;
					align-items: center;

					image {
						width: 90%;
						height: 100upx;
					}
				}
			}
		}
	}
</style>
