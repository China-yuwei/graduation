<template>
	<view class="my-follow">
		<uni-nav-bar class="mf-nav" left-icon="back" title="我的关注" :fixed="true" background-color="#67C23A" color="#fff"
		 @clickLeft="handleBack">
			<view slot="right" v-if="show" @click="handleManage">管理</view>
			<view slot="right" v-else @click="handleManage">完成</view>
		</uni-nav-bar>
		<view class="mf-content" v-if="show">
			<view class="mfc-content">
				<view class="mfcc-list" v-for="(item,index) in followLists" :key="index" @click="handleGoods(item)">
					<image :src="item.shop_icon" mode=""></image>
					<view class="mfccl-right">
						<text class="mfcclr-name">{{item.shop_name}}</text>
						<view class="mffcclr-list">
							<image :src="item.s_bg" mode=""></image>
							<image :src="item.s_bga" mode=""></image>
							<image :src="item.s_bgb" mode=""></image>
							<image :src="item.s_bgc" mode=""></image>
						</view>
					</view>
				</view>
			</view>
		</view>
		<view class="mf-content" v-else>
			<view class="mfc-content">
				<view class="mfc-content-b">
					<view class="mfcc-list" v-for="(item,index) in followLists" :key="index">
						<checkbox-group @change="handleToSelect(item)">
							<checkbox class="scgcb-check" :checked="item.isSelected" />
						</checkbox-group>
						<image :src="item.shop_icon" mode="" @click="handleGoods(item)"></image>
						<view class="mfccl-right" @click="handleGoods(item)">
							<text class="mfcclr-name">{{item.shop_name}}</text>
							<view class="mffcclr-list">
								<image :src="item.s_bg" mode=""></image>
								<image :src="item.s_bga" mode=""></image>
								<image :src="item.s_bgb" mode=""></image>
								<image :src="item.s_bgc" mode=""></image>
							</view>
						</view>
					</view>
				</view>
				<view class="mfcc-bottom">
					<checkbox-group @change="selectedall">
						<checkbox class="scbm-left-check" :checked="allSelected" />
					</checkbox-group>
					<view class="mfccb-num">
						已选 <text>{{selectedNum}}</text> 件商品
					</view>
					<view class="mfccb-del" @click="handleDel">
						删除
					</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				show: true,
				imgLists: ["../../static/images01/myInfo01.jpg", "../../static/images01/myInfo01.jpg",
					"../../static/images01/myInfo01.jpg", "../../static/images01/myInfo01.jpg"
				],
				selectedNum: 0,
				selectedArray: [],
				isSelected: true, //是否选中
				allSelected: false, //是否全选
				followLists: []
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
				url: 'http://localhost:3000/my/follow',
				data: {
					userId: that.user.user_id
				},
				success: (res) => {
					that.followLists = res.data.data
				}
			});
		},
		methods: {
			handleBack() {
				uni.switchTab({
					url: '../my/my'
				})
			},
			handleManage() {
				this.show = !this.show
			},
			handleGoods(item) {
				uni.navigateTo({
					url: '../home-swiper-shop/home-swiper-shop?id=' + item.shop_id
				});
			},
			handleToSelect(item) {
				item.isSelected = !item.isSelected
				if (!item.isSelected) {
					this.allSelected = false
				} else {
					const test = this.followLists.every(item => {
						return item.isSelected === true
					})
					if (test) {
						this.allSelected = true
					} else {
						this.allSelected = false
					}
				}
				this.selectedArray = this.followLists.filter(function(item) {
					return item.isSelected == true
				})
				this.selectedNum = this.selectedArray.length
			},
			selectedall() {
				this.allSelected = !this.allSelected
				if (this.allSelected) {
					this.followLists.map(item => {
						item.isSelected = true
					})
					this.selectedNum = this.followLists.length
					this.selectedArray = this.followLists
				} else {
					this.followLists.map(item => {
						item.isSelected = false
					})
					this.selectedNum = 0
					this.selectedArray = []
				}
			},
			handleDel() {
				let that = this
				let fId = that.selectedArray.map(function(item) {
					return item.f_id
				})
				let fLists = that.selectedArray.map(function(item) {
					return item
				})
				for (let i = 0; i < fId.length; i++) {
					uni.request({
						url: 'http://localhost:3000/del/my/follow',
						data: {
							favoritesId: fId[i]
						},
						success: (res) => {
							let index = that.followLists.indexOf(fLists[i])
							that.followLists.splice(index, 1)
							that.selectedNum = 0
							that.selectedArray = []
							uni.showToast({
								title: "删除成功",
								icon: "none",
								duration: 1000
							})
						}
					});
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

	.my-follow {
		position: relative;

		.mf-nav {
			/deep/ .uni-navbar--fixed {
				width: 100%;
			}
		}

		.mf-content {
			// margin-top: 124upx;

			.mfc-content {
				.mfc-content-b {
					margin-bottom: 120upx;
				}

				.mfcc-list:first-child {
					margin-top: 0;
				}

				.mfcc-list {
					padding: 30upx;
					display: flex;
					justify-content: space-between;
					align-items: center;
					background: #fff;
					margin-top: 30upx;

					>image {
						width: 25%;
						height: 160upx;
						margin-right: 30upx;
						border-radius: 90upx;
					}

					.mfccl-right {
						flex: 1;
						display: flex;
						flex-direction: column;
						justify-content: space-between;

						.mfcclr-name {
							padding-bottom: 30upx;
						}

						.mffcclr-list {
							display: flex;
							justify-content: space-between;
							flex-wrap: wrap;

							image {
								width: 90upx;
								height: 120upx;
								border-radius: 15upx;
							}
						}
					}
				}

				.mfcc-bottom {
					background: #efefef;
					display: flex;
					align-items: center;
					justify-content: space-between;
					position: fixed;
					bottom: 0;
					width: 100%;

					checkbox-group {
						margin-left: 30upx;
					}

					.mfccb-num {
						color: #666;

						text {
							color: #f00;
						}
					}

					.mfccb-del {
						width: 50%;
						background: #f00;
						color: #fff;
						text-align: center;
						padding: 30upx 0;
					}
				}
			}
		}

		/deep/ checkbox-group {
			margin-right: 30upx;

			.uni-checkbox-input {
				border-radius: 45upx;
			}
		}
	}
</style>
