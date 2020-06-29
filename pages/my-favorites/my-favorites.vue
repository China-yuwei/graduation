<template>
	<view class="my-favorites">
		<uni-nav-bar class="mf-nav" left-icon="back" title="我的收藏" :fixed="true" background-color="#67C23A" color="#fff"
		 @clickLeft="handleBack">
			<view slot="right" v-if="show" @click="handleManage">管理</view>
			<view slot="right" v-else @click="handleManage">完成</view>
		</uni-nav-bar>
		<view class="mf-tab">
			<home-tab id="tabbar" :values="items" :stickyTop="108" :current="current" @clickItem="onClickItem"></home-tab>
		</view>
		<view class="mf-content" v-if="show">
			<view class="mfc-content" v-if="current == 0">
				<view class="mfcc-list" v-for="(item,index) in favorityLists" :key="index" @click="handleGoods(item)">
					<image :src="item.g_src" mode=""></image>
					<view class="mfccl-right">
						<text class="mfcclr-name">{{item.g_name}}</text>
						<text class="mfcclr-price">￥ {{item.g_price}}</text>
					</view>
				</view>
			</view>
			<view class="" v-else>
				暂无数据
			</view>
		</view>
		<view class="mf-content" v-else>
			<view class="mfc-content" v-if="current == 0">
				<view class="mfc-content-b">
					<view class="mfcc-list" v-for="(item,index) in favorityLists" :key="index">
						<checkbox-group @change="handleToSelect(item)">
							<checkbox class="scgcb-check" :checked="item.isSelected" />
						</checkbox-group>
						<image :src="item.g_src" mode="" @click="handleGoods(item)"></image>
						<view class="mfccl-right" @click="handleGoods(item)">
							<text class="mfcclr-name">{{item.g_name}}</text>
							<text class="mfcclr-price">￥ {{item.g_price}}</text>
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
			<view class="" v-else>
				暂无数据
			</view>
		</view>
	</view>
</template>

<script>
	import homeTab from '../../components/home-tab.vue';
	export default {
		components: {
			homeTab
		},
		data() {
			return {
				show: true,
				items: ["商品", "内容"],
				current: 0,
				selectedNum: 0,
				selectedArray: [],
				isSelected: true, //是否选中
				allSelected: false, //是否全选
				user: [],
				favorityLists: []
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
				url: 'http://localhost:3000/my/favorites',
				data: {
					userId: that.user.user_id
				},
				success: (res) => {
					that.favorityLists = res.data.data
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
			onClickItem(index) { //选项卡
				if (this.current !== index) {
					this.current = index;
				}
			},
			handleGoods(item) {
				uni.request({
					url: 'http://localhost:3000/goods',
					success: (res) => {
						let allGoods = res.data.data
						let currentGood = allGoods.filter(function(i) {
							return i.g_id == item.g_id
						})[0]
						uni.navigateTo({
							url: '../goods-class-detail/goods-class-detail?goods=' + JSON.stringify(currentGood)
						})
					}
				});
			},
			handleToSelect(item) {
				item.isSelected = !item.isSelected
				if (!item.isSelected) {
					this.allSelected = false
				} else {
					const test = this.favorityLists.every(item => {
						return item.isSelected === true
					})
					if (test) {
						this.allSelected = true
					} else {
						this.allSelected = false
					}
				}
				this.selectedArray = this.favorityLists.filter(function(item) {
					return item.isSelected == true
				})
				this.selectedNum = this.selectedArray.length
			},
			selectedall() {
				this.allSelected = !this.allSelected
				if (this.allSelected) {
					this.favorityLists.map(item => {
						item.isSelected = true
					})
					this.selectedNum = this.favorityLists.length
					this.selectedArray = this.favorityLists
				} else {
					this.favorityLists.map(item => {
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
						url: 'http://localhost:3000/del/my/favorites',
						data: {
							favoritesId: fId[i]
						},
						success: (res) => {
							let index = that.favorityLists.indexOf(fLists[i])
							that.favorityLists.splice(index, 1)
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
	.my-favorites {
		position: relative;

		.mf-nav {
			/deep/ .uni-navbar--fixed {
				width: 100%;
			}
		}

		.mf-tab {
			width: 100%;
			position: fixed;
			top: 44px;
			background: #fff;
			z-index: 10;

			/deep/ .home-tab-control {
				width: 100%;

				.home-tab-control-item {
					width: 50%;
					text-align: center;
				}
			}
		}

		.mf-content {
			margin-top: 124upx;

			.mfc-content {
				.mfc-content-b {
					margin-bottom: 120upx;
				}

				.mfcc-list {
					padding: 30upx;
					display: flex;
					justify-content: space-between;
					align-items: center;

					image {
						width: 25%;
						height: 160upx;
						margin-right: 30upx;
					}

					.mfccl-right {
						height: 160upx;
						flex: 1;
						display: flex;
						flex-direction: column;
						justify-content: space-between;

						.mfcclr-name {
							overflow: hidden;
							text-overflow: ellipsis;
							display: -webkit-box;
							-webkit-line-clamp: 2;
							-webkit-box-orient: vertical;
							font-size: 32upx;
							padding-bottom: 30upx;
						}

						.mfcclr-price {
							color: #f00;
						}
					}
				}

				.mfcc-bottom {
					background: #E9E9E9;
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
