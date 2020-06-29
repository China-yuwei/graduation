<template>
	<view class="my-set">
		<view class="my-set-user" @click="handleMyHead">
			<view class="msu-left">
				<image :src="user.user_headImg" mode=""></image>
				<view class="my-head-user">
					<text class="my-head-username">{{user.user_name}}</text>
					<text>{{user.user_type}}</text>
				</view>
			</view>
			<image src="../../static/my-img/youjiantou.png" mode=""></image>
		</view>
		<!-- <my-set-list></my-set-list> -->
		<view class="my-set-list">
			<view class="mst" v-for="(item,index) in textLists" :key="index" @click="handleClick(index)">
				<text>{{item}}</text>
				<image src="../../static/my-img/youjiantou.png" mode=""></image>
			</view>
		</view>
		<button type="warn" @click="handleSignOut">退出登录</button>
		<uni-popup ref="popup" type="bottom">
			<view class="popup-sure">
				<text>确定退出登录吗？</text>
				<button @click="confirmSignOut">确定</button>
			</view>
			<button @click="cancelSignOut">取消</button>
		</uni-popup>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				user: [],
				textLists: ["我的收货地址", "账户安全", "问题反馈", "关于我们"]
			};
		},
		onShow() {
			let that = this
			uni.getStorage({
				key: 'user_login',
				success(res) {
					that.user = res.data
				}
			})
		},
		methods: {
			handleMyHead() {
				uni.navigateTo({
					url: '../my-info/my-info'
				});
			},
			handleSignOut() {
				this.$refs.popup.open()
			},
			confirmSignOut() {
				this.$refs.popup.close()
				uni.removeStorage({
					key: 'user_login'
				});
				uni.switchTab({
					url: '../home/home'
				});
			},
			cancelSignOut() {
				this.$refs.popup.close()
			},
			handleClick(index) {
				switch (index) {
					case 0:
						uni.navigateTo({
							url: '../my-set-address/my-set-address'
						});
						break;
					case 1:
						uni.navigateTo({
							url: '../my-set-account-security/my-set-account-security'
						});
						break;
					case 2:
						uni.navigateTo({
							url: '../my-set-problem-feedback/my-set-problem-feedback'
						});
						break;
					case 3:
						uni.navigateTo({
							url: '../my-set-about-us/my-set-about-us'
						});
						break;
					default:
						break;
				}
			}
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
		background: #efefef;
	}

	.my-set {
		position: relative;
		height: 100%;

		>button {
			width: 90%;
			position: absolute;
			bottom: 40upx;
			left: 50%;
			transform: translateX(-50%);
		}

		.my-set-user {
			background: #fff;
			padding: 30upx;
			border-top: 1upx solid #666;
			border-bottom: 1upx solid #666;
			display: flex;
			align-items: center;
			justify-content: space-between;

			image {
				width: 40upx;
				height: 40upx;
			}

			.msu-left {
				display: flex;
				align-items: center;

				image {
					border-radius: 60%;
					width: 120upx;
					height: 120upx;
					margin-right: 30upx;
				}

				.my-head-user {
					display: flex;
					flex-direction: column;
					color: #666;

					.my-head-username {
						font-size: 60upx;
						color: #000;
					}
				}
			}
		}

		.my-set-list {
			.mst {
				background: #fff;
				padding: 30upx;
				display: flex;
				align-items: center;
				justify-content: space-between;
				border-bottom: 1upx solid #666;
				margin-top: 20upx;

				image {
					width: 40upx;
					height: 40upx;
				}
			}

		}

		/deep/ .uni-popup__wrapper-box {
			width: 90%;
			margin: 0 auto;

			.popup-sure {
				background: #fff;
				text-align: center;
				border-radius: 10upx;
				margin-bottom: 30upx;

				text {
					display: block;
					padding: 30upx 0;
					border-bottom: 1upx solid #666;
				}

				button {
					background: #fff;
					color: red;
					border-radius: 10upx;
				}
			}

			>button {
				border-radius: 10upx;
				background: #fff;
				margin: 30upx 0;
			}
		}
	}
</style>
