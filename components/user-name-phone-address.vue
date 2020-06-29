<template>
	<view name="userNamePhoneAddress" class="user-name-phone-address">
		<view class="user-name-phone">
			<text>{{address.address_user}}</text>
			<text>{{address.address_phone}}</text>
		</view>
		<view class="user-address">
			<image src="/static/shoppingCar-img/location.png" mode=""></image>
			<text>{{address.address_provence}}-{{address.address_house}}</text>
		</view>
	</view>
</template>

<script>
	export default {
		name: "userNamePhoneAddress",
		props:{
			address:{}
		},
		data() {
			return {
				userName: "user01",
				userPhone: "13111111111",
				userAddress: "四川省成都市双流县    xx镇xx小区1-1-0101"
			};
		}
	}
</script>

<style lang="less">
	.user-name-phone-address {
		padding: 30upx;
		background: #fff;

		.user-name-phone {
			font-size: 40upx;
			margin-bottom: 20upx;
			text{
				margin-right: 30upx;
			}
		}

		.user-address {
			color: #666;
			font-size: 32upx;

			image {
				width: 40upx;
				height: 40upx;
				vertical-align: middle;
			}
			text{
				vertical-align: middle;
			}
		}
	}
</style>
