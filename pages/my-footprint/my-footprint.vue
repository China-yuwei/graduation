<template>
	<view class="my-footprint">
		<uni-nav-bar class="mf-nav" left-icon="back" right-icon="trash" title="我的足迹" :fixed="true" background-color="#67C23A"
		 color="#fff" @clickLeft="handleBack" @clickRight="handleDel">
		</uni-nav-bar>
		<view class="mf-content">
			<view class="mfc-list" v-for="(item,index) in footprintList" :key="index" @click="handleFoot(item)">
				<text class="mfcl-text">{{item.f_time}}</text>
				<view class="mfcl-list">
					<view class="mfcll-content">
						<image :src="item.g_src" mode=""></image>
						<view class="mfcllc-text">
							<text class="mfcllct-price">￥ {{item.g_price}}</text>
							<text>...</text>
						</view>
					</view>
				</view>
			</view>
		</view>
		<uni-popup ref="popup" type="center">
			<view class="mf-popup">
				<view class="mfp-text">
					确定要清空吗？清空后将无法找回，请谨慎操作。
				</view>
				<view class="mfp-button">
					<text @click="handleCancel">取消</text>
					<text @click="handleClear">清空</text>
				</view>
			</view>
		</uni-popup>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				// footTime: [],
				footprintList: []
			};
		},
		onLoad() {
			let that = this
			uni.getStorage({
				key: 'user_login',
				success(res) {
					that.user = res.data
				}
			});
			uni.request({
				url: 'http://localhost:3000/my/footprint',
				data: {
					userId: that.user.user_id
				},
				success: (res) => {
					that.footprintList = res.data.data.sort(function(a, b) {
						let x = a.f_time.toLowerCase();
						let y = b.f_time.toLowerCase();
						if (x < y) {
							return 1;
						}
						if (x > y) {
							return -1;
						}
						return 0;
					})
					// let sevenTime = sortTime.filter(function(item) {
					// 	return item.f_time >= that.getDay(-7)
					// })
					// that.footTime = [...new Set(sevenTime.map(function(item) {
					// 	return item.f_time.substr(0, 10)
					// }))]
				}
			});
		},
		methods: {
			handleBack() {
				uni.switchTab({
					url: '../my/my'
				})
			},
			handleDel() {
				this.$refs.popup.open()
			},
			handleCancel() {
				this.$refs.popup.close()
			},
			handleClear() {
				let that = this
				uni.request({
					url: 'http://localhost:3000/del/my/footprint',
					data: {
						userId: that.user.user_id
					},
					success: (res) => {
						that.$refs.popup.close()
						// that.footTime = []
						that.footprintList = []
					}
				});
			},
			handleFoot(item) {
				uni.request({
					url: 'http://localhost:3000/goods',
					success: (res) => {
						let allGoods = res.data.data
						let currentGood = allGoods.filter(function(i) {
							return i.g_id == item.g_id
						})[0]
						uni.navigateTo({
							url: '../goods-class-detail/goods-class-detail?goods=' + JSON.stringify(currentGood)
						})
					}
				});
			},
			getDay(day) {
				let today = new Date();
				let targetday_milliseconds = today.getTime() + 1000 * 60 * 60 * 24 * day;
				today.setTime(targetday_milliseconds); //注意，这行是关键代码
				let tYear = today.getFullYear();
				let tMonth = today.getMonth();
				let tDate = today.getDate();
				tMonth = this.doHandleMonth(tMonth + 1);
				tDate = this.doHandleMonth(tDate);
				return tYear + "-" + tMonth + "-" + tDate;
			},
			doHandleMonth(month) {
				let m = month;
				if (month.toString().length == 1) {
					m = "0" + month;
				}
				return m;
			}
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
		background: #efefef;
	}

	.my-footprint {
		position: relative;
		background: #efefef;

		.mf-nav {
			/deep/ .uni-navbar--fixed {
				width: 100%;
			}
		}

		.mf-popup {
			background: #fff;
			width: 60%;
			margin: 0 auto;
			padding: 30upx;

			.mfp-text {
				padding: 30upx 0;
			}

			.mfp-button {
				width: 100%;
				color: #1f9de1;
				padding: 30upx 0 0 0;
				display: flex;
				justify-content: space-between;

				text {
					width: 50%;
					display: block;
					text-align: center;
				}
			}
		}

		.mf-content {
			padding: 30upx;

			.mfc-list {
				.mfcl-list {
					padding-top: 30upx;
					display: flex;
					flex-wrap: wrap;

					.mfcll-content {
						width: 33%;
						background: #fff;
						margin-bottom: 30upx;

						image {
							width: 100%;
							height: 160upx;
						}

						.mfcllc-text {
							padding: 15upx;
							display: flex;
							justify-content: space-between;

							.mfcllct-price {
								color: #f00;
							}
						}
					}
				}
			}
		}
	}
</style>
