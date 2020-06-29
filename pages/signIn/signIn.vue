<template>
	<view class="sign-in">
		<view class="sign-in-image">
			<image src="../../static/signIn-img/logo.png" mode=""></image>
			<text>茶</text>
		</view>
		<view class="sign-in-user" v-if="msgSignIn">
			<view class="sic-user">
				<image src="../../static/signIn-img/user.png" mode=""></image>
				<input type="text" :value="user" placeholder="用户名/手机号" @input="getUser" />
			</view>
			<view class="sic-password">
				<view class="sicp-left">
					<image v-if="hidePwdUser" src="../../static/signIn-img/see.png" mode="" @click="handleHidePwdUser"></image>
					<image v-else src="../../static/signIn-img/no-see.png" mode="" @click="handleShowPwdUser"></image>
					<input :type="passwordType" :value="userPwd" placeholder="请输入密码" @input="getUserPwd" />
				</view>
				<text @click="handleForgetPwd">忘记密码</text>
			</view>
		</view>
		<view class="sign-in-user" v-else>
			<view class="sic-user">
				<image src="../../static/signIn-img/user.png" mode=""></image>
				<input type="text" :value="admin" placeholder="管理员" @input="getAdmin" />
			</view>
			<view class="sic-password">
				<view class="sicp-left">
					<image v-if="hidePwdAdmin" src="../../static/signIn-img/see.png" mode="" @click="handleHidePwdA"></image>
					<image v-else src="../../static/signIn-img/no-see.png" mode="" @click="handleShowPwdA"></image>
					<input :type="passwordTypeA" :value="adminPwd" placeholder="请输入密码" @input="getAdminPwd" />
				</view>
			</view>
		</view>
		<view class="sign-in-agree">
			登录即表明同意<text @click="handleSignInAgreement">{{signInAgreement}}</text>和<text @click="handleSignInPrivacy">{{signInPrivacy}}</text>
		</view>
		<button type="warn" @click="handleSignIn" :disabled="isDisabled">登录</button>
		<view class="sign-in-style">
			<text v-if="msgSignInText" @click="handleMsgSignIn">切换至管理员登录</text>
			<text v-else @click="handlePwdSignIn">切换至用户登录</text>
			<text v-if="msgSignInText" @click="handleRegister">注册</text>
		</view>
		<view class="sign-in-other" v-if="msgSignInText">
			<view class="sio-wechat" @click="handleWechat">
				<image src="../../static/signIn-img/weixin.png" mode="" class="sio-w-img"></image>
				<text>微信账户快速登录</text>
			</view>
			<view class="sio-wechat" @click="handleQQ">
				<image src="../../static/signIn-img/qq.png" mode="" class="sio-q-img"></image>
				<text>QQ账户快速登录</text>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				msgSignIn: true, //显示管理员登录或者用户登录页面
				user: "", //输入的用户名
				hidePwdUser: true, //密码是否可见
				passwordType: "password", //密码type
				userPwd: "", //输入的密码
				admin: "", //管理员
				hidePwdAdmin: true,
				passwordTypeA: "password",
				adminPwd: "", //输入的验证码
				signInAgreement: " 服务协议 ",
				signInPrivacy: " 隐私声明 ",
				isDisabled: true, //是否禁用登录按钮
				msgSignInText: true, //显示密码登录或者管理员登录文字
				getUserInfo: [], //存储从后台获取的用户数据
				getAdminInfo: []
			};
		},
		onLoad() {
			let that = this
			uni.request({
				url: 'http://localhost:3000/login/user',
				success: (res) => {
					that.getUserInfo = res.data.data
				}
			})
			uni.request({
				url: 'http://localhost:3000/login/admin',
				success: (res) => {
					that.getAdminInfo = res.data.data
				}
			})
		},
		methods: {
			getUser(e) { //获取用户输入的用户名或手机号码
				this.user = e.target.value
			},
			handleHidePwdUser() { //密码不可见，点击切换为可见
				this.hidePwdUser = false
				this.passwordType = "text"
			},
			handleShowPwdUser() { //密码可见，点击切换为不可见
				this.hidePwdUser = true
				this.passwordType = "password"
			},
			getUserPwd(e) { //获取用户输入的密码
				this.userPwd = e.target.value
				if (this.user && this.userPwd) {
					this.isDisabled = false
				}
			},
			handleForgetPwd() { //找回密码
				uni.navigateTo({
					url: '../signIn-find-pwd/signIn-find-pwd'
				});
			},
			getAdmin(e) { //获取管理员
				this.admin = e.target.value
			},
			handleHidePwdA() { //密码不可见，点击切换为可见
				this.hidePwdAdmin = false
				this.passwordTypeA = "text"
			},
			handleShowPwdA() { //密码可见，点击切换为不可见
				this.hidePwdAdmin = true
				this.passwordTypeA = "password"
			},
			getAdminPwd(e) { //获取
				this.adminPwd = e.target.value
				if (this.admin && this.adminPwd) {
					this.isDisabled = false
				}
			},
			handleSignInAgreement() { //服务协议
				uni.navigateTo({
					url: '../signIn-service-agreement/signIn-service-agreement'
				});
			},
			handleSignInPrivacy() { //隐私声明
				uni.navigateTo({
					url: '../signIn-privacy-statement/signIn-privacy-statement'
				});
			},
			handleSignIn() { //登录
				let that = this
				if (that.msgSignIn == true) {
					let getUser = that.getUserInfo.filter(function(item, index) {
						return that.user == item.user_name || that.user == item.user_phone
					})
					let getUserPwd = getUser.filter(function(item, index) {
						return that.userPwd == item.user_password
					})
					if (getUser.length !== 0) {
						if (getUserPwd.length !== 0) {
							uni.setStorage({
								key: 'user_login',
								data: getUserPwd[0]
							});
							uni.switchTab({
								url: '../my/my'
							});
						} else {
							uni.showToast({
								title: '密码错误',
								icon: 'none',
								duration: 2000
							})
						}
					} else {
						uni.showToast({
							title: '用户不存在',
							icon: 'none',
							duration: 2000
						})
					}
				} else {
					let getAdminAdmin = that.getAdminInfo.filter(function(item, index) {
						return that.admin == item.admin_name
					})
					let getAdminAdminPwd = getAdminAdmin.filter(function(item, index) {
						return that.adminPwd == item.admin_password
					})
					if (getAdminAdmin.length !== 0) {
						if (getAdminAdminPwd.length !== 0) {
							uni.setStorage({
								key: 'user_login',
								data: getAdminAdminPwd[0]
							});
							uni.switchTab({
								url: '../my/my'
							});
						} else {
							uni.showToast({
								title: '密码错误',
								icon: 'none',
								duration: 2000
							})
						}
					} else {
						uni.showToast({
							title: '管理员不存在',
							icon: 'none',
							duration: 2000
						})
					}
				}
			},
			handleMsgSignIn() { //默认密码登录页面，点击切换为验证码登录页面
				this.msgSignIn = false
				this.msgSignInText = false
				if (this.userPhone && this.userVerificationCode) {
					this.isDisabled = false
				} else {
					this.isDisabled = true
				}
			},
			handlePwdSignIn() { //验证码登录页面，点击切换为密码登录页面
				this.msgSignIn = true
				this.msgSignInText = true
				if (this.user && this.userPwd) {
					this.isDisabled = false
				} else {
					this.isDisabled = true
				}
			},
			handleRegister() { //注册
				uni.navigateTo({
					url: '../register/register'
				});
			},
			handleWechat() { //微信登录
				uni.showToast({
					title: '因安全性原因，暂不支持微信登录',
					icon: 'none',
					duration: 2000
				})
			},
			handleQQ() { //QQ登录
				uni.showToast({
					title: '因安全性原因，暂不支持QQ登录',
					icon: 'none',
					duration: 2000
				})
			}
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
	}

	.sign-in {
		height: 100%;
		position: relative;
		padding: 0 30upx;

		.sign-in-image {
			display: flex;
			flex-direction: column;
			align-items: center;
			justify-content: center;

			image {
				width: 480upx;
				height: 240upx;
			}

			text {
				position: absolute;
				top: 16%;
				font-size: 60upx;
			}
		}

		.sign-in-user {
			margin-top: 60upx;

			.sic-user {
				border-bottom: 1upx solid #f00;
				padding: 30upx 0;
				display: flex;
				align-items: center;

				image {
					width: 40upx;
					height: 40upx;
					margin-right: 30upx;
				}
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

				.sicp-left {
					display: flex;

					.sicp-left-input {
						margin-left: 70upx;
					}

					image {
						width: 40upx;
						height: 40upx;
						margin-right: 30upx;
					}
				}
			}
		}

		.sign-in-agree {
			font-size: 30upx;
			color: #666;
			padding: 30upx 0;

			text {
				color: #1f9de1;
			}
		}

		button {
			border-radius: 30upx;
		}

		.sign-in-style {
			display: flex;
			justify-content: space-between;
			padding: 30upx 0 0 0;
			font-size: 36upx;
		}

		.sign-in-other {
			position: absolute;
			bottom: 30upx;
			left: 50%;
			transform: translateX(-50%);

			.sio-wechat {
				background: #f7f7f7;
				border-radius: 60upx;
				padding: 20upx;
				display: flex;
				align-items: center;
				margin-bottom: 30upx;

				text {
					margin: 0 30upx;
					white-space: nowrap;
				}

				image {
					width: 40upx;
					height: 40upx;
				}

				.sio-w-img {
					padding: 20upx;
					border-radius: 60%;
					background: #009a00;
				}

				.sio-q-img {
					padding: 12upx;
					border-radius: 60%;
					background: #1d4f9a;
				}
			}
		}
	}
</style>
