<template>
	<view class="my-set-account-security-verificationPhone">
		<view class="msasv-phone">
			<text>手机号码</text>
			<input type="number" :value="userPhone" @blur="OnBlurPhone" />
		</view>
		<view class="msasvp-verification-code">
			<view class="msasvp-verificationCode">
				<text>验证码</text>
				<input type="number" :value="verificationCode" placeholder="请输入验证码" @blur="OnBlur" />
			</view>
			<text @click="handleGetVerificationCode" v-if="verifyShow">获取验证码</text>
			<text v-else>{{verifyTip+'s'}}</text>
		</view>
		<button type="warn" @click="handleConfirm">设置完成</button>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				userPhone: "",
				verificationCode: "",
				verifyTip: 60,
				verifyShow: true
			};
		},
		onLoad() {
			let that = this
			uni.getStorage({
				key: 'user_login',
				success(res) {
					that.userPhone = res.data.user_phone
				}
			})
		},
		methods: {
			OnBlurPhone(val) {
				this.userPhone = val
			},
			OnBlur(e) {
				this.verificationCode = e.target.value
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
					let checkPhone = /^1[3|4|5|7|8][0-9]{9}$/
					if (checkPhone.test(this.userPhone) == true) {
						this.timedown(60)
						uni.showToast({
							title: '验证码发送成功',
							icon: 'none',
							duration: 1000
						})
					} else {
						uni.showToast({
							title: '请输入正确的手机号码',
							icon: 'none',
							duration: 1000
						})
					}
				} else {
					uni.showToast({
						title: '请输入手机号码',
						icon: 'none',
						duration: 1000
					})
				}
			},
			handleConfirm() {
				if (this.verificationCode !== "") {
					uni.navigateBack();
				} else {
					uni.showToast({
						title: '请输入验证码',
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

	.my-set-account-security-verificationPhone {
		.msasv-phone {
			padding: 20upx 30upx;
			border-bottom: 1upx solid #666;
			display: flex;
			align-items: center;
			color: #000;
			background: #fff;
			margin-bottom: 30upx;

			text {
				width: 25%;
			}

			/deep/ input {
				padding: 10upx;
			}
		}

		.msasvp-verification-code {
			position: relative;

			.msasvp-verificationCode {
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

			>text {
				display: block;
				position: absolute;
				right: 30upx;
				top: 50%;
				transform: translateY(-50%);
				color: #f00;
			}
		}

		button {
			width: 90%;
			position: absolute;
			left: 50%;
			transform: translateX(-50%);
			margin-top: 40upx;
		}
	}
</style>
