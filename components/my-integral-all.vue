<template>
	<view name="myIntegralAll" class="my-integral-all">
		<view class="mictclc-left">
			<text>{{lists.i_name}}</text>
			<text class="mictclcl-time">{{lists.i_time}}</text>
		</view>
		<view class="mictclc-right">
			{{allNum}}
		</view>
	</view>
</template>

<script>
	export default {
		name: "myIntegralAll",
		props: {
			lists: {}
		},
		data() {
			return {

			};
		},
		computed: {
			allNum() {
				let text = ""
				if (this.lists.i_id == 1) {
					return text = "+" + this.lists.i_num
				} else {
					return text = "-" + this.lists.i_num
				}
			}
		}
	}
</script>

<style lang="less">
	.my-integral-all {
		width: 100%;
		display: flex;
		justify-content: space-between;
		align-items: center;

		.mictclc-left {
			display: flex;
			flex-direction: column;

			.mictclcl-time {
				color: #999;
				padding-top: 15upx;
			}
		}

		.mictclc-right {
			color: #f00;
		}
	}
</style>
