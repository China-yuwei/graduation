<!-- 首页-消息-通知消息 -->
<template>
	<view class="home-myInfo-notice">
		<view class="home-myInfo-content" v-for="(item,index) in infoLists" :key="index" @click="handleInfo(item)">
			<image :src="item.fi_src" mode=""></image>
			<view class="hmc-content">
				<view class="hmcc-top">
					<text class="hmcct-title">{{item.fi_name}}</text>
					<text>{{item.fi_time}}</text>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				user: [],
				infoLists: []
			};
		},
		onLoad() {
			let that = this
			uni.getStorage({
				key: 'user_login',
				success(res) {
					that.user = res.data
				}
			});
			uni.request({
				url: 'http://localhost:3000/find/info',
				data: {
					userId: that.user.user_id
				},
				success: (res) => {
					let allInfo = res.data.data
					that.infoLists = allInfo.filter(function(item) {
						return item.fi_status == "未读" && item.fi_type == "通知信息"
					})
				}
			});
		},
		methods: {
			handleInfo(item) {
				uni.navigateTo({
					url: '../home-info-detail/home-info-detail?id=' + item.fi_id
				})
			}
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
		// background: #efefef;
	}

	.home-myInfo-notice {

		.home-myInfo-content {
			padding: 40upx;
			border-bottom: 1upx solid #666;
			display: flex;
			justify-content: space-between;
			align-items: center;

			image {
				width: 160upx;
				height: 160upx;
			}

			.hmc-content {
				height: 160upx;
				flex: 1;
				padding-left: 40upx;
				font-size: 32upx;
				color: #666;
				display: flex;
				flex-direction: column;
				justify-content: space-between;

				.hmcc-top {
					height: 100%;
					display: flex;
					flex-direction: column;
					justify-content: space-between;
					// align-items: center;
					padding: 0 0 10upx 0;

					.hmcct-title {
						font-size: 40upx;
						color: #000;
					}
				}

				.hmc-in {
					width: 100%;
					display: -webkit-box;
					-webkit-box-orient: vertical;
					-webkit-line-clamp: 1;
					overflow: hidden;
				}
			}
		}
	}
</style>
