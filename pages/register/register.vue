<template>
	<view class="register">
		<view class="sic-user">
			<input type="number" :value="userPhone" placeholder="请输入手机号" @input="getUserPhone" />
		</view>
		<view class="sic-password">
			<view class="sicp-left">
				<input class="sicp-left-input" type="password" :value="userVerificationCode" placeholder="请输入密码" @input="getUserVerificationCode" />
			</view>
		</view>
		<view class="sign-in-agree">
			登录即表明同意<text @click="handleSignInAgreement">{{signInAgreement}}</text>和<text @click="handleSignInPrivacy">{{signInPrivacy}}</text>
		</view>
		<button type="warn" @click="handleSignIn" :disabled="isDisabled">注册并登录</button>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				signInAgreement: " 服务协议 ",
				signInPrivacy: " 隐私声明 ",
				userPhone: "",
				userVerificationCode: "",
				verifyTip: 60,
				verifyShow: true,
				isDisabled: true,
				userInfo: []
			};
		},
		onLoad() {
			uni.request({
				url: 'http://localhost:3000/login/user',
				success: (res) => {
					this.userInfo = res.data.data
				}
			});
		},
		methods: {
			getUserPhone(e) {
				this.userPhone = e.target.value
			},
			getUserVerificationCode(e) {
				this.userVerificationCode = e.target.value
				if (this.userPhone && this.userVerificationCode) {
					this.isDisabled = false
				}
			},
			handleSignIn() {
				let that = this
				let getUser = that.userInfo.filter(function(item, index) {
					return that.userPhone == item.user_phone
				})
				let regPhone = /^[1][3,4,5,7,8][0-9]{9}$/;
				if (regPhone.test(this.userPhone) == true) {
					if (getUser.length == 0) {
						uni.request({
							url: 'http://localhost:3000/register',
							data: {
								userPhone: that.userPhone,
								userPassword: that.userVerificationCode
							},
							success: (res) => {
								uni.request({
									url: 'http://localhost:3000/login/user',
									success: (res) => {
										let getNewUser = res.data.data.filter(function(item, index) {
											return item.user_phone == that.userPhone
										})
										getNewUser[0].user_name = "新用户"
										getNewUser[0].user_type = "普通用户"
										getNewUser[0].user_sex = "男"
										getNewUser[0].user_headImg = "../../static/my-img/my-head.png"
										uni.setStorage({
											key: 'user_login',
											data: getNewUser[0]
										});
										uni.switchTab({
											url: '../my/my'
										});
									}
								});
							}
						});
					} else {
						uni.showToast({
							title: '账号已存在',
							icon: 'none',
							duration: 2000
						})
					}
				} else {
					uni.showToast({
						title: '请输入正确的手机号',
						icon: 'none',
						duration: 1000
					})
				}
			},
			handleSignInAgreement() {
				uni.navigateTo({
					url: '../signIn-service-agreement/signIn-service-agreement'
				});
			},
			handleSignInPrivacy() {
				uni.navigateTo({
					url: '../signIn-privacy-statement/signIn-privacy-statement'
				});
			}
		}
	}
</script>

<style lang="less">
	.register {
		padding: 60upx 30upx 0;

		.sic-user {
			border-bottom: 1upx solid #f00;
			padding: 30upx 0;
		}

		.sic-password {
			border-bottom: 1upx solid #f00;
			padding: 30upx 0;
			display: flex;
			align-items: center;
			justify-content: space-between;

			>text {
				font-size: 32upx;
				color: #f00;
			}
		}

		.sign-in-agree {
			font-size: 30upx;
			color: #666;
			padding: 40upx 0;

			text {
				color: #1f9de1;
			}
		}

		button {
			border-radius: 30upx;
		}
	}
</style>
