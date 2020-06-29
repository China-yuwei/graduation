<!-- 首页-消息-交易物流 -->
<template>
	<view class="home-myInfo-logistics">
		<view class="hml-content" v-for="(item,index) in orderLists" :key="index" @click="handleLogistics(item)">
			<text>{{item.o_type}}</text>
			<view class="hmlc-content">
				<image :src="item.g_src" mode=""></image>
				<view class="hmlc-content-text">
					<text class="hmlc-content-name">
						{{item.g_name}}
					</text>
					<view class="hmlccn-p">
						<text>￥ <text style="color: #f00; font-size: 48upx;"> {{item.g_price}} </text></text>
						<text>x{{item.g_num}}</text>
					</view>
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
				logisticsLists: [],
				orderLists: []
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
					that.logisticsLists = allInfo.filter(function(item) {
						return item.fi_type == "物流消息" && item.fi_status == "已读"
					})
					for (let i = 0; i < that.logisticsLists.length; i++) {
						uni.request({
							url: 'http://localhost:3000/my/order',
							data: {
								userId: that.user.user_id
							},
							success: (res) => {
								let allOrder = res.data.data
								let order = allOrder.filter(function(item) {
									return item.o_id == that.logisticsLists[i].o_id
								})
								that.orderLists = that.orderLists.concat(order)
							}
						});
					}
				}
			});
		},
		methods: {
			handleLogistics(item) {
				uni.navigateTo({
					url: '../shopping-car-order-detail/shopping-car-order-detail?id=' + item.o_id
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

	.home-myInfo-logistics {
		padding: 40upx;

		.hml-content {
			background: #fff;
			border-radius: 20upx;
			padding: 20upx;
			margin-bottom: 40upx;

			>text {
				font-size: 40upx;
			}

			.hmlc-content {
				background: #efefef;
				display: flex;
				margin: 20upx 0;

				image {
					width: 200upx;
					height: 200upx;
					border-radius: 20upx;
				}

				.hmlc-content-text {
					width: calc(70%);
					display: flex;
					flex-direction: column;
					justify-content: space-between;
					padding-left: 30upx;
					font-size: 28upx;
					color: #666;

					.hmlc-content-name {
						font-size: 32upx;
						color: #000;
						display: -webkit-box;
						-webkit-box-orient: vertical;
						-webkit-line-clamp: 2;
						overflow: hidden;
					}

					.hmlccn-p {
						display: flex;
						justify-content: space-between;
						align-items: center;
					}
				}
			}
		}
	}
</style>
