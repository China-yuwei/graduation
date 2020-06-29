<template>
	<view class="admin-user-detail">
		<view class="aud-list">
			<text>用户头像</text>
			<image :src="user.user_headImg" mode=""></image>
		</view>
		<view class="aud-list">
			<text>用户名</text>
			<text>{{user.user_name}}</text>
		</view>
		<view class="aud-list">
			<text>用户手机号</text>
			<text>{{user.user_phone}}</text>
		</view>
		<view class="aud-list">
			<text>用户性别</text>
			<text>{{user.user_sex}}</text>
		</view>
		<view class="aud-list">
			<text>用户类别</text>
			<text>{{user.user_type}}</text>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				user: []
			};
		},
		onLoad(options) {
			let that = this
			uni.request({
				url: 'http://localhost:3000/login/user',
				success: (res) => {
					let getData = res.data.data
					that.user = getData.filter(function(item) {
						return item.user_id == options.id
					})[0]
				}
			});
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
		background: #efefef;
	}

	.admin-user-detail {
		padding: 30upx 0;
		background: #efefef;

		.aud-list:first-child {
			margin: 0;
		}

		.aud-list {
			background: #fff;
			padding: 30upx;
			margin-top: 30upx;
			display: flex;
			align-items: center;
			justify-content: space-between;

			image {
				width: 90upx;
				height: 90upx;
				border-radius: 60%;
			}
		}
	}
</style>
