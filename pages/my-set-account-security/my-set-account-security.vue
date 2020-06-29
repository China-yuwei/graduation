<template>
	<view class="my-set-account-security">
		<view class="msas-list" @click="handleChangePwd">
			<image src="../../static/my-img/queren.png" mode="" class="msas-list-img"></image>
			<view class="msas-list-text">
				<text>修改登录密码</text>
				<text class="msas-list-text-content">建议您定期更改密码以保护账户安全</text>
			</view>
			<image src="../../static/my-img/youjiantou.png" mode=""></image>
		</view>
		<view class="msas-list" @click="handleVerificationPhone">
			<image src="../../static/my-img/jinggao.png" mode="" class="msas-list-img"></image>
			<view class="msas-list-text">
				<text>手机验证</text>
				<text class="msas-list-text-content">手机号可用于账号登录，快速找回密码、支付密码、接受账户余额变动等通知。</text>
			</view>
			<image src="../../static/my-img/youjiantou.png" mode=""></image>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {

			};
		},
		methods: {
			handleChangePwd() {
				uni.navigateTo({
					url: '../my-set-account-security-change-pwd/my-set-account-security-change-pwd'
				});
			},
			handleVerificationPhone() {
				uni.navigateTo({
					url: '../my-set-account-security-verificate-phone/my-set-account-security-verificate-phone'
				});
			}
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
		background: #E9E9E9;
	}

	.my-set-account-security {
		.msas-list {
			padding: 30upx;
			border-top: 1upx solid #666;
			background: #fff;
			display: flex;
			justify-content: space-between;
			align-items: center;

			image {
				width: 40upx;
				height: 40upx;
			}

			.msas-list-img {
				width: 80upx;
				height: 80upx;
			}

			.msas-list-text {
				width: calc(75%);
				display: flex;
				flex-direction: column;

				text {
					font-size: 36upx;
					padding: 20upx;
				}

				.msas-list-text-content {
					font-size: 28upx;
				}
			}
		}
	}
</style>
