<template>
	<view class="my-personal-data-name">
		<view class="mpdn-input">
			<text>用户名</text>
			<input type="text" :value="user.user_name" @input="getUserName" />
		</view>
		<view class="mpdn-text">
			注意：与网站业务或卖家品牌冲突的名称，网站有权收回
		</view>
		<button type="warn" @click="handleSure">保存</button>
	</view>
</template>

<script>
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
			getUserName(e) {
				this.user.user_name = e.target.value
			},
			handleSure() {
				let that = this
				uni.request({
					url: 'http://localhost:3000/modify/userName',
					data: {
						userId: that.user.user_id,
						userName: that.user.user_name
					},
					success: (res) => {
						uni.setStorage({
							key: 'user_login',
							data: that.user
						});
						uni.navigateBack({
							// delta: 1
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
		background: #E9E9E9;
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
