<template>
	<view class="my-coupon">
		<view class="mc-content">
			<view class="mcc-list" v-if="isHave">
				<text class="mccl-title">平台优惠券</text>
				<view class="mccl-content" v-for="(item,index) in couponLists" :key="index">
					<myCouponTime :lists="item" @useCoupon="handleToUse"></myCouponTime>
				</view>
			</view>
			<view class="mcc-else" v-else>
				<image src="../../static/home-img/zanwushuju.png" mode=""></image>
				<view>暂无数据</view>
			</view>
		</view>
	</view>
</template>

<script>
	import myCouponTime from '../../components/my-coupon-time.vue';
	export default {
		components: {
			myCouponTime
		},
		data() {
			return {
				isHave: true,
				couponLists: []
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
				url: 'http://localhost:3000/my/coupon',
				data: {
					userId: that.user.user_id
				},
				success: (res) => {
					let aaa = res.data.data
					that.couponLists = aaa.sort(function(a, b) {
						let x = a.c_time.toLowerCase();
						let y = b.c_time.toLowerCase();
						if (x < y) {
							return 1;
						}
						if (x > y) {
							return -1;
						}
						return 0;
					})
					if (that.couponLists.length > 0) {
						that.isHave = true
					} else {
						that.isHave = false
					}
				}
			});
		},
		methods: {
			handleToUse(data) {
				uni.switchTab({
					url: '../home/home'
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

	.my-coupon {
		padding: 30upx;
		background: #efefef;

		.mc-content {
			background: #fff;
			border-radius: 15upx;
			padding: 30upx;

			.mcc-list {
				.mccl-content:first-child {
					margin: 0;
				}

				.mccl-content {
					margin-top: 30upx;
				}
			}

			.mcc-else {
				padding: 30upx 0;
				text-align: center;
				background: #efefef;

				image {
					width: 120upx;
					height: 120upx;
				}
			}
		}
	}
</style>
