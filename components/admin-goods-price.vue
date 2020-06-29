<template>
	<view class="admin-goods-price" name="adminGoodsPrice">
		<view class="agp-price" v-if="isDiscount">
			<text class="agpp-old">￥{{list.g_price}}</text>
			<text class="agpp-new">￥{{price}}</text>
		</view>
		<view class="agp-price" v-else>
			<text class="agpp-new">￥{{price}}</text>
		</view>
		<view class="agp-integral">
			{{integral}}
		</view>
		<view class="agp-num">
			<text>已售：{{list.g_buy_num}}</text>
			<text>库存：{{list.g_num}}</text>
		</view>
	</view>
</template>

<script>
	export default {
		name: 'adminGoodsPrice',
		props: {
			list: {}
		},
		data() {
			return {
				isDiscount: true
			};
		},
		computed: {
			price() {
				let that = this
				let text = null
				if (that.list.g_discount == null || that.list.g_discount == "") {
					that.isDiscount = false
					text = that.list.g_price
				} else {
					that.isDiscount = true
					text = that.list.g_discount
				}
				return text
			},
			integral() {
				let that = this
				let text = null
				if (that.list.g_integral == null || that.list.g_integral == 0) {
					text = "当前商品不可用积分兑换"
				} else {
					text = "可用" + that.list.g_integral + "积分兑换"
				}
				return text
			}
		}
	}
</script>

<style lang="less">
	.admin-goods-price {
		.agp-price {
			text-align: right;

			.agpp-new {
				color: #f00;
				font-size: 48upx;
			}

			.agpp-old {
				text-decoration: line-through;
			}
		}

		.agp-integral {
			text-align: right;
			font-size: 32upx;
			padding: 10upx 0;
		}

		.agp-num {
			display: flex;
			justify-content: space-between;
			align-items: center;

			text {
				font-size: 32upx;
				color: #666;
			}
		}
	}
</style>
