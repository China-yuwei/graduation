<template>
	<view class="my-footprint">
		<uni-nav-bar class="mf-nav" left-icon="back" right-icon="trash" title="我的浏览" :fixed="true" background-color="#67C23A"
		 color="#fff" @clickLeft="handleBack" @clickRight="handleDel">
		</uni-nav-bar>
		<view class="mf-content">
			<view class="home-myInfo-content" v-for="(item,index) in infoLists" :key="index" @click="handleInfoDetail(item)">
				<text>{{item.fi_s_time}}</text>
				<view class="hmccccc">
					<image :src="item.fi_src" mode=""></image>
					<view class="hmc-content">
						<view class="hmcc-top">
							<text class="hmcct-title">{{item.fi_name}}</text>
							<text>{{item.fi_time}}</text>
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
				infoLists: [],
				user: []
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
				url: 'http://localhost:3000/find/info',
				data: {
					userId: that.user.user_id
				},
				success: (res) => {
					let all = res.data.data
					that.infoLists = all.filter(function(item) {
						return item.fi_status == "已读" && item.fi_type == "通知信息"
					})
				}
			});
		},
		methods: {
			handleBack() {
				uni.switchTab({
					url: '../find/find'
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
				for (let i = 0; i < that.infoLists.length; i++) {
					uni.request({
						url: 'http://localhost:3000/del/find/info/all',
						data: {
							fiId: that.infoLists[i].fi_id
						},
						success: (res) => {
							that.$refs.popup.close()
							that.infoLists = []
						}
					});
				}
			},
			handleInfoDetail(item) {
				uni.navigateTo({
					url: '../home-info-detail/home-info-detail?id=' + item.fi_id
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
			.home-myInfo-content {
				>text {
					display: block;
					padding: 30upx 30upx 0 30upx;
				}

				.hmccccc {
					padding: 30upx;
					display: flex;
					justify-content: space-between;
					align-items: center;

					image {
						width: 160upx;
						height: 160upx;
					}

					.hmc-content {
						height: 160upx;
						flex: 1;
						padding-left: 40upx;
						font-size: 32upx;
						color: #666;
						display: flex;
						flex-direction: column;
						justify-content: space-between;

						.hmcc-top {
							height: 100%;
							display: flex;
							flex-direction: column;
							justify-content: space-between;
							// align-items: center;
							padding: 0 0 10upx 0;

							.hmcct-title {
								font-size: 40upx;
								color: #000;
							}
						}
					}
				}
			}
		}
	}
</style>
