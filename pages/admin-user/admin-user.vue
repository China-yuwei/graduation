<template>
	<view class="admin-user">
		<view class="au-list" v-for="(item,index) in user" :key="index" @click="handleUser(item)">
			<text>{{item.user_name}}</text>
			<image src="../../static/my-img/youjiantou.png" mode=""></image>
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
		onLoad() {
			let that = this
			uni.request({
				url: 'http://localhost:3000/login/user',
				success: (res) => {
					that.user = res.data.data
				}
			});
		},
		methods: {
			handleUser(item) {
				uni.navigateTo({
					url: '../admin-user-detail/admin-user-detail?id=' + item.user_id
				})
			}
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
		background: #efefef;
	}

	.admin-user {
		padding: 30upx 0;
		background: #efefef;

		.au-list:first-child {
			margin: 0;
		}

		.au-list {
			display: flex;
			justify-content: space-between;
			align-items: center;
			padding: 30upx;
			background: #fff;
			margin-top: 30upx;

			image {
				width: 40upx;
				height: 40upx;
			}
		}
	}
</style>
