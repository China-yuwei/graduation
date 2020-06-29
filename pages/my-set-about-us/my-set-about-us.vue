<template>
	<view class="my-set-about-us">
		<view class="msau-title">
			<image src="../../static/my-img/erweima.png" mode=""></image>
			<text>当前版本：1.0.1</text>
		</view>
		<view class="msau-list" v-for="(item,index) in textLists" :key="index" @click="handleClick(index)">
			<text>{{item}}</text>
			<image src="../../static/my-img/youjiantou.png" mode=""></image>
		</view>
		<view class="msau-text">
			<text>版权所有 ......</text>
			<text>经营许可证：......</text>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				textLists: ["隐私声明", "帮助中心", "服务协议", "客服电话"]
			};
		},
		methods: {
			handleClick(index) {
				switch (index) {
					case 0:
						uni.navigateTo({
							url: '../signIn-privacy-statement/signIn-privacy-statement'
						});
						break;
					case 1:
						uni.navigateTo({
							url: '../my-set-about-us-help-center/my-set-about-us-help-center'
						});
						break;
					case 2:
						uni.navigateTo({
							url: '../signIn-service-agreement/signIn-service-agreement'
						});
						break;
					case 3:
						uni.navigateTo({
							url: '../my-set-about-us-customer-phone/my-set-about-us-customer-phone'
						});
						break;
					default:
						break;
				}
			}
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
	}

	.my-set-about-us {
		height: 100%;
		font-size: 36upx;
		position: relative;

		.msau-title {
			display: flex;
			flex-direction: column;
			justify-content: center;
			align-items: center;
			padding: 30upx;
			border-bottom: 1upx solid #666;

			image {
				width: 120upx;
				height: 120upx;
				margin: 40upx 0;
			}
		}

		.msau-list {
			background: #fff;
			padding: 30upx;
			display: flex;
			align-items: center;
			justify-content: space-between;
			border-bottom: 1upx solid #666;

			image {
				width: 40upx;
				height: 40upx;
			}
		}

		.msau-text {
			display: flex;
			flex-direction: column;
			text-align: center;
			font-size: 28upx;
			position: absolute;
			bottom: 30upx;
			left: 50%;
			transform: translateX(-50%);
		}
	}
</style>
