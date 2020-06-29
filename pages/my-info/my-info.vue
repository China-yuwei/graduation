<template>
	<view class="my-info">
		<view class="mpd-list" @click="handleMyHead">
			<text>头像</text>
			<view class="mpd-list-content">
				<image :src="user.user_headImg" mode="" class="mpd-list-content-img"></image>
				<image src="../../static/my-img/youjiantou.png" mode=""></image>
			</view>
		</view>
		<view class="mpd-list" @click="handleMyNickName">
			<text>用户名</text>
			<view class="mpd-list-content">
				<text>{{user.user_name}}</text>
				<image src="../../static/my-img/youjiantou.png" mode=""></image>
			</view>
		</view>
		<!-- <view class="mpd-list" @click="handleMyPwd">
			<text>密码</text>
			<view class="mpd-list-content">
				<image src="../../static/my-img/youjiantou.png" mode=""></image>
			</view>
		</view> -->
		<view class="mpd-list" @click="handleMySex">
			<text>性别</text>
			<view class="mpd-list-content">
				<text>{{user.user_sex}}</text>
				<image src="../../static/my-img/youjiantou.png" mode=""></image>
			</view>
		</view>
		<view class="mpd-list" @click="handleMyLevel">
			<text>用户类别</text>
			<view class="mpd-list-content">
				<text>{{user.user_type}}</text>
				<image src="../../static/my-img/youjiantou.png" mode=""></image>
			</view>
		</view>
		<uni-popup ref="popup" type="center">
			<view class="hss-popup" @click="handleBoy">男</view>
			<view class="hss-popup" @click="handleGirl">女</view>
		</uni-popup>
	</view>
</template>

<script>
	import {
		pathToBase64,
		base64ToPath
	} from '../../js_sdk/gsq-image-tools/image-tools/index.js'
	export default {
		data() {
			return {
				user: []
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
				let that = this
				uni.chooseImage({
					sourceType: ["camera", "album"],
					sizeType: ["compressed", "original"],
					count: 1,
					success: (res) => {
						that.user.user_headImg = "../../static/images/new/" + res.tempFiles[0].name
						uni.request({
							url: "http://localhost:3000/modify/userHeadImg",
							data: {
								userId: that.user.user_id,
								userHeadImg: that.user.user_headImg
							},
							success: (res) => {
								uni.setStorage({
									key: 'user_login',
									data: that.user,
								});
							}
						})
					}
				});
			},
			handleMyLevel() {
				let that = this
				that.user.user_type = "普通用户"
				uni.request({
					url: 'http://localhost:3000/modify/userType',
					data: {
						userId: that.user.user_id,
						userType: that.user.user_type
					},
					success: (res) => {
						uni.setStorage({
							key: 'user_login',
							data: that.user,
						});
					}
				});
			},
			handleMyNickName() {
				uni.navigateTo({
					url: '../my-info-name/my-info-name'
				})
			},
			handleMySex() {
				this.$refs.popup.open()
			},
			handleBoy() {
				let that = this
				that.user.user_sex = "男"
				uni.request({
					url: 'http://localhost:3000/modify/userSex',
					data: {
						userId: that.user.user_id,
						userSex: that.user.user_sex
					},
					success: (res) => {
						uni.setStorage({
							key: 'user_login',
							data: that.user,
						});
					}
				});
				that.$refs.popup.close()
			},
			handleGirl() {
				let that = this
				that.user.user_sex = "女"
				uni.request({
					url: 'http://localhost:3000/modify/userSex',
					data: {
						userId: that.user.user_id,
						userSex: that.user.user_sex
					},
					success: (res) => {
						uni.setStorage({
							key: 'user_login',
							data: that.user,
						});
					}
				});
				that.$refs.popup.close()
			},
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
		background: #efefef;
	}

	.my-info {
		font-size: 36upx;

		.mpd-list {
			background: #fff;
			padding: 30upx;
			border-bottom: 1upx solid #666;
			display: flex;
			justify-content: space-between;
			align-items: center;

			.mpd-list-content {
				display: flex;
				align-items: center;

				image {
					width: 40upx;
					height: 40upx;
					margin-left: 20upx;
				}

				.mpd-list-content-img {
					width: 90upx;
					height: 90upx;
					border-radius: 60%;
				}
			}
		}

		/deep/ .uni-popup__wrapper-box {
			background: #efefef;
			width: 85%;
			border-radius: 30upx;

			.hss-popup:first-child {
				margin-bottom: 30upx;
			}

			.hss-popup {
				background: #fff;
				padding: 30upx 0;
				text-align: center;
				color: #ff0000;
				border-radius: 30upx;
			}
		}
	}
</style>
