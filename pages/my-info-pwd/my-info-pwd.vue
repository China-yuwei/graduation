<template>
	<view class="my-personal-data-name">
		<view class="mpdn-input">
			<text>密码</text>
			<input type="password" :value="userPwd" placeholder="请输入密码" @input="getUserPwd" />
		</view>
		<view class="mpdn-text">
			注意：请妥善保管密码!
		</view>
		<button type="warn" @click="handleSure">保存</button>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				user: [],
				userPwd: ""
			};
		},
		onLoad(options) {
			let that = this
			uni.request({
				url: 'http://localhost:3000/login/user',
				success: (res) => {
					let allUser = res.data.data
					that.user = allUser.filter(function(item){
						return item.user_id == options.id
					})[0]
				}
			})
		},
		methods: {
			getUserPwd(e) {
				this.user.user_password = e.target.value
			},
			handleSure() {
				let that = this
				uni.request({
					url: 'http://localhost:3000/modify/userPassword',
					data: {
						userPassword: that.user.user_password,
						userId: that.user.user_id
					},
					success: (res) => {
						uni.showToast({
							title: '密码设置成功，请重新登录',
							icon: 'none',
							duration: 1000
						});
						uni.navigateTo({
							url: '../signIn/signIn'
						})
					}
				});
			}
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
		background: #efefef;
	}

	.my-personal-data-name {
		padding: 30upx 0;

		.mpdn-input {
			background: #fff;
			padding: 30upx;
			display: flex;
			align-items: center;

			input {
				flex: 1;
				padding: 0 0 0 30upx;
			}
		}

		.mpdn-text {
			padding: 30upx;
		}

		button {
			border-radius: 30upx;
			width: 85%;
		}
	}
</style>
