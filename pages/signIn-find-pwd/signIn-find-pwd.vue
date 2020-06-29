<template>
	<view class="signIn-find-pwd">
		<view class="sic-user">
			<image src="../../static/signIn-img/user.png" mode=""></image>
			<input type="number" :value="userPhone" placeholder="请输入手机号" @input="getUserPhone" />
		</view>
		<view class="sic-password">
			<view class="sicp-left">
				<input class="sicp-left-input" type="number" :value="userVerificationCode" placeholder="请输入验证码" @input="getUserVerificationCode" />
			</view>
			<text @click="handleGetVerificationCode" v-if="verifyShow">获取验证码</text>
			<text v-else>{{verifyTip+'s'}}</text>
		</view>
		<button type="warn" @click="handleSignIn">下一步</button>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				userPhone: "",
				userVerificationCode: "",
				verifyTip: 60,
				verifyShow: true,
				getUserInfo: []
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
		},
		methods: {
			getUserPhone(e) {
				this.userPhone = e.target.value
			},
			getUserVerificationCode(e) {
				this.userVerificationCode = e.target.value
			},
			timedown(num) {
				let that = this;
				if (num == 0) {
					that.verifyShow = true; // 是否显示获取验证码
					return clearTimeout();
				} else {
					that.verifyShow = false; // 是否显示获取验证码
					setTimeout(function() {
						that.verifyTip = num - 1
						that.timedown(num - 1);
					}, 1000); //定时每秒减一  
				}
			},
			handleGetVerificationCode() {
				if (this.userPhone !== "") {
					let regPhone = /^[1][3,4,5,7,8][0-9]{9}$/;
					if (regPhone.test(this.userPhone) == true) {
						this.timedown(60)
						uni.showToast({
							title: '验证码发送成功',
							icon: 'none',
							duration: 1000
						})
					} else {
						uni.showToast({
							title: '请输入正确的手机号',
							icon: 'none',
							duration: 1000
						})
					}
				} else {
					uni.showToast({
						title: '请输入手机号',
						icon: 'none',
						duration: 1000
					})
				}
			},
			handleSignIn() {
				let that = this
				let getUserPhone = that.getUserInfo.filter(function(item, index) {
					return that.userPhone == item.user_phone
				})
				if (getUserPhone.length !== 0) {
					if (that.userVerificationCode == 123456) {
						uni.navigateTo({
							url: '../my-info-pwd/my-info-pwd?id=' + getUserPhone[0].user_id
						})
					} else {
						uni.showToast({
							title: '验证码错误',
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
			}
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
		background: #efefef;
	}

	.signIn-find-pwd {
		padding: 60upx 30upx 0;

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

		button {
			border-radius: 30upx;
			margin-top: 60upx;
		}
	}
</style>
