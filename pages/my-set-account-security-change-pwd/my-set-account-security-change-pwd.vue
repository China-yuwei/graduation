<template>
	<view class="my-set-account-security-changePwd">
		<view class="my-set-address-list">
			<text>初始密码</text>
			<input type="password" placeholder="请输入初始密码" @blur="getInitialPassword" maxlength="20" />
		</view>
		<view class="my-set-address-list">
			<text>登录密码</text>
			<input type="password" placeholder="请输入登录密码" @blur="getNewPwd" maxlength="20" />
		</view>
		<view class="my-set-address-list">
			<text>确认密码</text>
			<input type="password" placeholder="请确认登录密码" @blur="getConfirmPwd" maxlength="20" />
		</view>
		<view class="msasvp-warnInfo">
			<image src="../../static/my-img/warnInfo.png" mode=""></image>
			<text>登录密码长度为6-20个字符，建议由字母、数字和字符两种以上组合</text>
		</view>
		<button type="warn" @click="handleConfirm">设置完成</button>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				initialPwd: "",
				newPwd: "",
				confirmPwd: "",
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
			getInitialPassword(e) {
				this.initialPwd = e.target.value
			},
			getNewPwd(e) {
				this.newPwd = e.target.value
			},
			getConfirmPwd(e) {
				this.confirmPwd = e.target.value
			},
			handleConfirm() {
				let that = this
				if (that.initialPwd != "") {
					if (that.initialPwd == that.user.user_password) {
						if (that.newPwd && that.newPwd == that.confirmPwd) {
							that.user.user_password = that.newPwd
							uni.request({
								url: 'http://localhost:3000/modify/userPassword',
								data: {
									userPassword: that.user.user_password,
									userId: that.user.user_id
								},
								success: (res) => {
									uni.setStorage({
										key: 'user_login',
										data: that.user,
									});
									uni.navigateBack()
								}
							});
						} else {
							uni.showToast({
								title: '密码不一致',
								icon: 'none',
								duration: 1000
							})
						}
					} else {
						uni.showToast({
							title: '初始密码错误',
							icon: 'none',
							duration: 1000
						})
					}
				} else {
					uni.showToast({
						title: '请输入初始密码',
						icon: 'none',
						duration: 1000
					})
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

	.my-set-account-security-changePwd {
		.my-set-address-list {
			padding: 20upx 30upx;
			border-bottom: 1upx solid #666;
			display: flex;
			align-items: center;
			color: #000;
			background: #fff;

			text {
				width: 25%;
			}

			/deep/ input {
				padding: 10upx;
			}
		}

		.msasvp-warnInfo {
			display: flex;
			align-items: center;
			padding: 30upx;
			font-size: 28upx;
			color: #f00;

			image {
				width: 40upx;
				height: 40upx;
				margin-right: 20upx;
			}
		}

		button {
			width: 90%;
			position: absolute;
			left: 50%;
			transform: translateX(-50%);
		}
	}
</style>
