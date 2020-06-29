<template>
	<view class="my-sharing">
		<text>分享好友注册成功即可领取超值大礼包</text>
		<view class="ms-button">
			<image src="../../static/signIn-img/weixin.png" mode=""></image>
			<image src="../../static/signIn-img/qq.png" mode=""></image>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {

			};
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
		background: #efefef;
	}

	.my-sharing {
		text-align: center;

		text {
			display: block;
			padding: 30upx;
		}

		.ms-button {
			display: flex;
			align-items: center;
			width: 100%;
			justify-content: space-around;
			padding: 30upx 0;

			image {
				width: 80upx;
				height: 80upx;
			}

		}
	}
</style>
