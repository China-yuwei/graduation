<template>
	<view class="my-coupon-time" name="myCouponTime">
		<view class="mcclc-left">
			￥<text>{{lists.c_money}}</text>
		</view>
		<view class="mcclc-center">
			<text>满{{lists.c_full}}减{{lists.c_money}}</text>
			<text class="mcclc-center-time">{{lists.c_time}}至{{outTime}}</text>
		</view>
		<view class="mccle-right">
			<text @click="handleToUse">去使用</text>
		</view>
	</view>
</template>

<script>
	export default {
		name: "myCouponTime",
		props: {
			lists: {}
		},
		data() {
			return {

			};
		},
		computed: {
			outTime() {
				let that = this
				return that.getDay(that.lists.c_date)
			}
		},
		methods: {
			handleToUse() {
				this.$emit("useCoupon", this.lists.c_id)
			},
			getDay(day) {
				let today = new Date();
				let targetday_milliseconds = today.getTime() + 1000 * 60 * 60 * 24 * day;
				today.setTime(targetday_milliseconds); //注意，这行是关键代码
				let tYear = today.getFullYear();
				let tMonth = today.getMonth();
				let tDate = today.getDate();
				tMonth = this.doHandleMonth(tMonth + 1);
				tDate = this.doHandleMonth(tDate);
				return tYear + "-" + tMonth + "-" + tDate;
			},
			doHandleMonth(month) {
				let m = month;
				if (month.toString().length == 1) {
					m = "0" + month;
				}
				return m;
			}
		}
	}
</script>

<style lang="less">
	.my-coupon-time {
		color: #f00;
		display: flex;

		.mcclc-left {
			background: #efefef;
			padding-left: 15upx;
			width: 180upx;
			border-radius: 15upx;
			display: flex;
			align-items: center;
			justify-content: flex-start;

			text {
				font-size: 60upx;
			}
		}

		.mcclc-center {
			padding: 15upx 15upx;
			background: #efefef;
			border-radius: 15upx;
			flex: 1;
			display: flex;
			flex-direction: column;

			.mcclc-center-time {
				font-size: 28upx;
				padding-top: 15upx;
			}
		}

		.mccle-right {
			background: #efefef;
			padding-left: 15upx;
			width: 180upx;
			border-radius: 15upx;
			display: flex;
			align-items: center;
			justify-content: center;

			text {
				background: #f00;
				color: #fff;
				border-radius: 45upx;
				padding: 10upx 15upx;
			}
		}
	}
</style>
