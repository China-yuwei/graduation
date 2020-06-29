<template>
	<view class="admin-goods-add">
		<view class="age-list">
			<text>商品名：</text>
			<input type="text" placeholder="请填写商品名" @blur="getGoodName" />
		</view>
		<view class="age-list">
			<text>商品种类：</text>
			<picker @change="bindPickerChange" :range="classArray">
				<view class="agel-picker">
					<view class="uni-input" :style="classStyle">{{classPickerText}}</view>
					<image src="../../static/my-img/youjiantou.png" mode=""></image>
				</view>
			</picker>
		</view>
		<view class="age-list">
			<text>商品类别：</text>
			<picker @change="bindPickerChangeC" :range="classChildArray">
				<view class="agel-picker">
					<view class="uni-input" :style="classChildStyle">{{classChildPickerText}}</view>
					<image src="../../static/my-img/youjiantou.png" mode=""></image>
				</view>
			</picker>
		</view>
		<view class="age-list">
			<text>所属店铺：</text>
			<picker @change="bindPickerChangeS" :range="shopArray">
				<view class="agel-picker">
					<view class="uni-input" :style="shopStyle">{{shopPickerText}}</view>
					<image src="../../static/my-img/youjiantou.png" mode=""></image>
				</view>
			</picker>
		</view>
		<view class="age-list">
			<text>商品描述：</text>
			<input type="text" placeholder="请填写商品描述" @blur="getGoodIntroduce" />
		</view>
		<view class="age-list">
			<text>商品价格：</text>
			<input type="text" placeholder="请填写商品价格" @blur="getGoodPrice" />
		</view>
		<view class="age-list">
			<text>折扣价：</text>
			<input type="text" placeholder="请填写商品折扣价" @blur="getGoodDiscount" />
		</view>
		<view class="age-list">
			<text>兑换积分：</text>
			<input type="number" placeholder="请填写兑换积分" @blur="getGoodIntegral" />
		</view>
		<view class="age-list">
			<text>库存：</text>
			<input type="number" placeholder="请填写商品库存" @blur="getGoodNum" />
		</view>
		<view class="age-list-img">
			<text>商品图片：</text>
			<view class="ageli-b" @click="handleImg">十</view>
			<image :src="goodSrc" mode=""></image>
		</view>
		<view class="age-button">
			<button type="warn" @click="handlePreservation">保存</button>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				goodSrc: "",
				classArray: [],
				classPickerText: "请选择商品种类",
				classStyle: "color: grey;",
				classChildArray: [],
				classChildStyle: "color: grey;",
				classChildPickerText: "请选择商品所属类别",
				shopArray: [],
				shopStyle: "color: grey;",
				shopPickerText: "请选择店铺",
				good: {}
			};
		},
		onLoad() {
			let that = this
			uni.request({ //选项卡
				url: 'http://localhost:3000/goods/class',
				success: (res) => {
					that.classArray = res.data.data.map(function(item) {
						return item.class_name
					})
				}
			});
			uni.request({ //店铺
				url: 'http://localhost:3000/shops',
				success: (res) => {
					that.shopArray = res.data.data.map(function(item) {
						return item.s_name
					})
				}
			});
		},
		methods: {
			bindPickerChange(e) {
				let that = this
				that.good.class_id = e.target.value + 1
				that.classPickerText = that.classArray[e.target.value]
				that.classStyle = "color: #000;"
				uni.request({
					url: 'http://localhost:3000/goods/class/child',
					success: (res) => {
						that.classChildArray = res.data.data.filter(function(item) {
							return item.class_id == that.good.class_id
						}).map(function(item) {
							return item.c_name
						})
					}
				});
			},
			bindPickerChangeC(e) {
				this.good.c_id = e.target.value + 1
				this.classChildPickerText = this.classChildArray[e.target.value]
				this.classChildStyle = "color: #000;"
			},
			bindPickerChangeS(e) {
				this.good.shop_id = e.target.value + 1
				this.shopPickerText = this.shopArray[e.target.value]
				this.shopStyle = "color: #000;"
			},
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
				if (Object.keys(that.good).length == 0) {
					uni.showToast({
						title: '请填写商品信息',
						icon: 'none',
						duration: 1000
					})
				} else {
					if (that.good.g_integral == undefined) {
						that.good.g_integral = 0
					}
					if (that.good.g_num == undefined) {
						that.good.g_num = 0
					}
					uni.request({
						url: 'http://localhost:3000/add/goods',
						data: {
							classId: that.good.class_id,
							CId: that.good.c_id,
							shopId: that.good.shop_id,
							className: that.classPickerText,
							goodsName: that.good.g_name,
							goodsIntroduce: that.good.g_introduce,
							goodsSrc: that.goodSrc,
							goodsPrice: that.good.g_price,
							goodsDiscount: that.good.g_discount,
							goodsIntegral: that.good.g_integral,
							goodsNum: that.good.g_num,
							goodsBuyNum: 0
						},
						success: (res) => {
							uni.navigateBack()
						}
					})
				}
			}
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
		background: #efefef;
	}

	.admin-goods-add {
		padding: 0 0 30upx 0;
		background: #efefef;

		.age-list {
			background: #fff;
			border-bottom: 1upx solid #666;
			display: flex;
			align-items: center;
			padding: 30upx;

			picker {
				flex: 1;

				.agel-picker {
					display: flex;
					align-items: center;
					justify-content: space-between;

					image {
						width: 40upx;
						height: 40upx;
					}
				}
			}

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
				margin-right: 30upx;
			}
		}

		.age-button {
			width: 90%;
			margin: 30upx auto 0;
		}
	}
</style>
