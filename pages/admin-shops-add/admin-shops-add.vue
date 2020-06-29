<template>
	<view class="admin-shops-add">
		<view class="age-list">
			<text>商家名称：</text>
			<input type="text" placeholder="请填写商家名称" @blur="getShopName" />
		</view>
		<view class="age-list">
			<text>商家简介：</text>
			<input type="text" placeholder="请填写商家简介" @blur="getShopTitle" />
		</view>
		<view class="age-list">
			<text>商家描述：</text>
			<input type="text" placeholder="请填写商家描述" @blur="getShopI" />
		</view>
		<view class="age-list">
			<text>经营商品：</text>
			<input type="text" placeholder="请填写经营商品" @blur="getShopRun" />
		</view>
		<view class="age-list">
			<text>商家电话：</text>
			<input type="text" placeholder="请填写商家电话" @blur="getShopPhone" />
		</view>
		<view class="age-list">
			<text>商家地址：</text>
			<input type="text" placeholder="请填写商家地址" @blur="getShopAddress" />
		</view>
		<view class="age-list">
			<text>开店时间：</text>
			<input type="text" placeholder="请填写开店时间" @blur="getShopTime" />
		</view>
		<view class="age-list-img">
			<text>商家icon：</text>
			<view class="ageli-b" @click="handleIcon">十</view>
			<image :src="shopIcon" mode=""></image>
		</view>
		<view class="age-list-img">
			<text>商家背景：</text>
			<view class="ageli-b" @click="handleBg">十</view>
			<image :src="shopBg" mode=""></image>
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
				shop: {},
				shopIcon: "",
				shopBg: ""
			};
		},
		methods: {
			getShopName(e) {
				this.shop.s_name = e.target.value
			},
			getShopPhone(e) {
				this.shop.s_phone = e.target.value
			},
			getShopAddress(e) {
				this.shop.s_address = e.target.value
			},
			getShopTime(e) {
				this.shop.s_time = e.target.value
			},
			getShopI(e) {
				this.shop.s_introduce = e.target.value
			},
			getShopTitle(e) {
				this.shop.s_title = e.target.value
			},
			getShopRun(e) {
				this.shop.s_run = e.target.value
			},
			handleIcon() {
				let that = this
				uni.chooseImage({
					sourceType: ["camera", "album"],
					sizeType: ["compressed", "original"],
					count: 1,
					success: (res) => {
						that.shopIcon = "../../static/images/new/" + res.tempFiles[0].name
					}
				});
			},
			handleBg() {
				let that = this
				uni.chooseImage({
					sourceType: ["camera", "album"],
					sizeType: ["compressed", "original"],
					count: 1,
					success: (res) => {
						that.shopBg = "../../static/images/new/" + res.tempFiles[0].name
					}
				});
			},
			handlePreservation() {
				let that = this
				if (Object.keys(that.shop).length == 0) {
					uni.showToast({
						title: '请填写商家信息',
						icon: 'none',
						duration: 1000
					})
				} else {
					uni.request({
						url: 'http://localhost:3000/add/shops',
						data: {
							shopsName: that.shop.s_name,
							shopsPhone: that.shop.s_phone,
							shopsAddress: that.shop.s_address,
							shopsTime: that.shop.s_time,
							shopsIntroduce: that.shop.s_introduce,
							shopsRun: that.shop.s_run,
							shopsTitle: that.shop.s_title,
							shopsIcon: that.shopIcon,
							shopsBg: that.shopBg
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

	.admin-shops-add {
		background: #efefef;

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
				margin-right: 30upx;
			}
		}

		.age-button {
			width: 90%;
			margin: 30upx auto 0;
		}
	}
</style>
