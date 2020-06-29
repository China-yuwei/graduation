<template>
	<view class="admin-goods-edit">
		<view class="age-list">
			<text>商品名：</text>
			<input type="text" :value="good.g_name" @blur="getGoodName" />
		</view>
		<view class="age-list">
			<text>商品描述：</text>
			<input type="text" :value="good.g_introduce" @blur="getGoodIntroduce" />
		</view>
		<view class="age-list">
			<text>商品价格：</text>
			<input type="text" :value="good.g_price" @blur="getGoodPrice" />
		</view>
		<view class="age-list">
			<text>折扣价：</text>
			<input type="text" :value="good.g_discount" @blur="getGoodDiscount" />
		</view>
		<view class="age-list">
			<text>兑换积分：</text>
			<input type="text" :value="good.g_integral" @blur="getGoodIntegral" />
		</view>
		<view class="age-list">
			<text>库存：</text>
			<input type="text" :value="good.g_num" @blur="getGoodNum" />
		</view>
		<view class="age-list-img">
			<text>商品图片：</text>
			<image :src="goodSrc" mode=""></image>
			<view class="ageli-b" @click="handleImg">十</view>
		</view>
		<view class="age-button">
			<button type="warn" @click="handlePreservation">保存</button>
			<button type="warn" @click="handleCancel">取消</button>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				good: [],
				goodSrc: ""
			};
		},
		onLoad(options) {
			let that = this
			that.good = JSON.parse(options.good)
			that.goodSrc = that.good.g_src
		},
		methods: {
			getGoodName(e) {
				this.good.g_name = e.target.value
			},
			getGoodIntroduce(e) {
				this.good.g_introduce = e.target.value
			},
			getGoodPrice(e) {
				this.good.g_price = e.target.value
			},
			getGoodDiscount(e) {
				this.good.g_discount = e.target.value
			},
			getGoodIntegral(e) {
				this.good.g_integral = e.target.value
			},
			getGoodNum(e) {
				this.good.g_num = e.target.value
			},
			handleImg() {
				let that = this
				uni.chooseImage({
					sourceType: ["camera", "album"],
					sizeType: ["compressed", "original"],
					count: 1,
					success: (res) => {
						that.goodSrc = "../../static/images/new/" + res.tempFiles[0].name
					}
				});
			},
			handlePreservation() {
				let that = this
				if (that.good.g_name == "") {
					uni.showToast({
						title: '请填写商品名称',
						icon: 'none',
						duration: 1000
					})
				} else if (that.good.g_introduce == "") {
					uni.showToast({
						title: '请填写商品描述',
						icon: 'none',
						duration: 1000
					})
				} else if (that.good.g_price == "") {
					uni.showToast({
						title: '请填写商品价格',
						icon: 'none',
						duration: 1000
					})
				} else if (that.good.g_num == "") {
					uni.showToast({
						title: '请填写商品库存',
						icon: 'none',
						duration: 1000
					})
				} else {
					uni.request({
						url: 'http://localhost:3000/edit/goods',
						data: {
							goodsId: that.good.g_id,
							goodsName: that.good.g_name,
							goodsIntroduce: that.good.g_introduce,
							goodsSrc: that.goodSrc,
							goodsPrice: that.good.g_price,
							goodsDiscount: that.good.g_discount,
							goodsIntegral: that.good.g_integral,
							goodsNum: that.good.g_num
						},
						success: (res) => {
							uni.navigateBack()
						}
					})
				}
			},
			handleCancel() {
				uni.navigateBack();
			}
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
		background: #efefef;
	}

	.admin-goods-edit {
		.age-list {
			background: #fff;
			border-bottom: 1upx solid #666;
			display: flex;
			align-items: center;
			padding: 30upx;

			>text {
				width: 24%;
				padding-right: 30upx;
				font-size: 32upx;
			}

			input {
				flex: 1;
			}
		}

		.age-list-img {
			background: #fff;
			border-bottom: 1upx solid #666;
			padding: 30upx;
			display: flex;
			align-items: center;

			image {
				width: 160upx;
				height: 160upx;
				border-radius: 30upx;
			}

			.ageli-b {
				width: 160upx;
				height: 160upx;
				border-radius: 30upx;
				background: #efefef;
				color: #fff;
				font-size: 96upx;
				font-weight: 700;
				text-align: center;
				line-height: 160upx;
				margin-left: 30upx;
			}
		}

		.age-button {
			width: 90%;
			position: absolute;
			bottom: 30upx;
			left: 50%;
			transform: translateX(-50%);

			button {
				margin-top: 30upx;
			}
		}
	}
</style>
