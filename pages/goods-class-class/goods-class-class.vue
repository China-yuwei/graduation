<template>
	<view class="goods-class-class" :style="isMove">
		<uni-nav-bar class="gcc-nav" left-icon="back" :title="title" :fixed="true" background-color="#67C23A" color="#fff"
		 @clickLeft="handleBack">
		</uni-nav-bar>
		<scroll-view scroll-x="true" :show-scrollbar="isScrollbar">
			<home-tab id="tabbar" :values="items" :stickyTop="108" :current="current" @clickItem="onClickItem"></home-tab>
		</scroll-view>
		<view class="gcc-title">
			<view class="gcct-left">
				<text @click="handleSynthesisSort" :style="synthesisStyle">综合</text>
				<text @click="handleSalesSort" :style="salesStyle">销量</text>
				<view class="gcctl-price">
					<text>价格</text>
					<view class="gcctlp-img">
						<image src="../../static/goodsClass-img/shangsanjiaoxin.png" mode="" v-if="isColor" @click="handlePriceLowToHigh"></image>
						<image src="../../static/goodsClass-img/shangsanjiaoxing.png" mode="" v-else></image>
						<image src="../../static/goodsClass-img/xiasanjiaoxin.png" v-if="isColors" mode="" @click="handlePriceHighToLow"></image>
						<image src="../../static/goodsClass-img/xiasanjiaoxing.png" mode="" v-else></image>
					</view>
				</view>
				<image src="../../static/my-img/erweima.png" v-if="permutations" mode=""></image>
				<image src="../../static/my-img/icon-test.png" v-else mode=""></image>
			</view>
			<view class="gcct-right">
				<text>筛选</text>
				<image src="../../static/my-img/bianjidizhi.png" mode="" @click="handleDrawer"></image>
			</view>
		</view>
		<view class="gcc-content">
			<view class="home-goods-introduce-list" v-for="(item,index) in currentGoods" :key="index" @click="handleG(item)">
				<image :src="item.g_src" mode=""></image>
				<view class="hgi-center">
					<text class="hgi-center-introduce">
						<text class="hgi-center-text-y">{{item.shopsSignY}}</text>
						<text class="hgi-center-text-v">{{item.shopsSignV}}</text>
						{{item.g_introduce}}
					</text>
				</view>
				<view class="hgi-ad">
					<view class="hgi-ad-type">
						<text>{{item.type}}</text>
						<text>{{item.del}}</text>
					</view>
					<text class="hgi-ad-address">{{item.address}}</text>
				</view>
				<view class="hgi-bottom">
					<text class="hgi-bottom-price">￥ {{item.g_price}}</text>
					<text class="hgi-bottom-num">{{item.g_buy_num}} 人付款</text>
				</view>
			</view>
		</view>
		<uni-drawer class="gcc-drawer" ref="drawer" :mask="true" mode="right" :maskClick="false" @close="closeDrawer">
			<scroll-view scroll-y="true">
				<view class="gccd-content" v-for="(item,index) in drawerLists" :key="index">
					<text>{{item.name}}</text>
					<view class="gccdc-lists">
						<view class="gccdcl-list" :style="choseText" v-for="(it,idx) in item.children" :key="idx" @click="handleText(it)">
							<text>{{it.value}}</text>
						</view>
					</view>
				</view>
				<view class="gccd-bottom">

				</view>
			</scroll-view>
		</uni-drawer>
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
				items: [], //选项卡列表
				current: 0, //选项卡点击的current
				isScrollbar: false, //是否显示滚动条
				title: "分类", //导航标题
				permutations: true, //排列方式
				synthesisStyle: "color: #f00;", //综合排序样式
				salesStyle: "color: #333;", //销量排序样式
				isColor: true, //价格低到高
				isColors: true, //价格高到底
				maskClick: false, //点击遮罩不可以关闭抽屉
				isMove: "",
				choseText: "",
				contentLists: [],
				allGoods: [],
				currentGoods: [],
				allShops: [],
				currentShops: [],
				drawerLists: [{
					name: "保质期",
					children: [{
						value: "3个月"
					}, {
						value: "6个月"
					}, {
						value: "12个月"
					}, {
						value: "18个月"
					}, {
						value: "24个月"
					}, {
						value: "36个月"
					}, {
						value: "长期保存"
					}, ]
				}, {
					name: "生产工艺",
					children: [{
						value: "生茶"
					}, {
						value: "熟茶"
					}]
				}, {
					name: "形状",
					children: [{
						value: "饼茶"
					}, {
						value: "砖茶"
					}, {
						value: "沱茶"
					}, {
						value: "青桔"
					}, {
						value: "老茶头"
					}, {
						value: "散茶"
					}]
				}, {
					name: "包装种类",
					children: [{
						value: "盒装"
					}, {
						value: "袋装"
					}, {
						value: "散装"
					}, {
						value: "礼盒装"
					}, {
						value: "常规"
					}, {
						value: "棉纸包装"
					}]
				}, {
					name: "年份",
					children: [{
						value: "1年以下"
					}, {
						value: "1年"
					}, {
						value: "2年"
					}, {
						value: "3年"
					}, {
						value: "3-5年"
					}, {
						value: "5-10年"
					}, {
						value: "10年以上"
					}]
				}, {
					name: "茶区",
					children: [{
						value: "临沧茶区"
					}, {
						value: "勐海茶区"
					}, {
						value: "普洱茶区"
					}, {
						value: "易武茶区"
					}, {
						value: "其他茶区"
					}]
				}, {
					name: "储藏方式",
					children: [{
						value: "干燥"
					}, {
						value: "通风"
					}, {
						value: "避光"
					}]
				}]
			};
		},
		onLoad(options) {
			let that = this
			uni.request({
				url: 'http://localhost:3000/goods/class/child',
				success: (res) => {
					that.contentLists = res.data.data
					let good = that.contentLists.filter(function(item) {
						return item.c_id == options.id
					})
					that.title = good[0].c_name
					that.items = that.contentLists.map(function(item) {
						return item.c_name
					})
					that.current = that.items.indexOf(that.title)
					let cId = that.items.indexOf(that.title) + 1
					uni.request({
						url: 'http://localhost:3000/goods',
						success: (res) => {
							that.allGoods = res.data.data
							that.currentGoods = that.allGoods.filter(function(item) {
								return item.c_id == cId
							})
						}
					});
				}
			});
		},
		methods: {
			handleBack() {
				uni.navigateBack()
			},
			onClickItem(index) { //选项卡
				let that = this
				if (that.current !== index) {
					that.current = index;
				}
				that.title = that.items[index]
				let cId = that.items.indexOf(that.title) + 1
				uni.request({
					url: 'http://localhost:3000/goods',
					success: (res) => {
						that.allGoods = res.data.data
						that.currentGoods = that.allGoods.filter(function(item) {
							return item.c_id == cId
						})
					}
				});
			},
			handleSynthesisSort() { //综合排序
				this.salesStyle = "color:#333;"
				this.isColor = true
				this.isColors = true
				this.synthesisStyle = "color:#f00;"
			},
			handleSalesSort() { //销量排序
				this.synthesisStyle = "color:#333;"
				this.isColor = true
				this.isColors = true
				this.salesStyle = "color:#f00;"
				this.currentGoods = this.currentGoods.sort(function(a, b) {
					let x = a.g_buy_num;
					let y = b.g_buy_num;
					if (x < y) {
						return 1;
					}
					if (x > y) {
						return -1;
					}
					return 0;
				})
			},
			handlePriceLowToHigh() { //价格低到高
				this.salesStyle = "color:#333;"
				this.synthesisStyle = "color:#333;"
				this.isColors = true
				this.isColor = false
				this.currentGoods = this.currentGoods.sort(function(a, b) {
					let x = Number(a.g_price);
					let y = Number(b.g_price);
					if (x < y) {
						return -1;
					}
					if (x > y) {
						return 1;
					}
					return 0;
				})
			},
			handlePriceHighToLow() { //价格高到低
				this.salesStyle = "color:#333;"
				this.synthesisStyle = "color:#333;"
				this.isColor = true
				this.isColors = false
				this.currentGoods = this.currentGoods.sort(function(a, b) {
					let x = Number(a.g_price);
					let y = Number(b.g_price);
					if (x < y) {
						return 1;
					}
					if (x > y) {
						return -1;
					}
					return 0;
				})
			},
			handleDrawer() {
				this.$refs.drawer.open()
				this.isMove = "position:fixed;"
			},
			closeDrawer() {
				this.isMove = ""
			},
			handleText(it) {
				console.log(309, it.value)
				// this.choseText = "background:#f00;color:#fff"
			},
			handleG(item) {
				uni.navigateTo({
					url: '../goods-class-detail/goods-class-detail?goods=' + JSON.stringify(item)
				})
			}
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
		background: #efefef;
	}

	.goods-class-class {
		background: #efefef;

		.gcc-nav {
			/deep/ .uni-navbar--fixed {
				width: 100%;
			}
		}

		.gcc-title {
			padding: 30upx;
			display: flex;
			align-items: center;
			justify-content: space-between;

			.gcct-right {
				display: flex;
				align-items: center;
				border-left: 4upx solid #666;
				padding: 0 0 0 30upx;

				image {
					width: 40upx;
					height: 40upx;
					margin-left: 15upx;
				}
			}

			.gcct-left {
				flex: 1;
				padding: 0 30upx 0 0;
				display: flex;
				align-items: center;
				justify-content: space-between;
				color: #666;

				.gcctl-price {
					display: flex;
					align-items: center;

					.gcctlp-img {
						display: flex;
						flex-direction: column;

						image {
							width: 30upx;
							height: 15upx;
							margin-bottom: 10upx;
						}

						image:last-child {
							margin: 0;
						}
					}
				}

				>image {
					width: 40upx;
					height: 40upx;
				}
			}
		}

		.gcc-content {
			padding: 0 15upx;
			display: flex;
			flex-wrap: wrap;
			justify-content: space-between;

			.home-goods-introduce-list {
				width: 48%;
				display: flex;
				flex-direction: column;
				align-items: center;
				background: #fff;
				border-radius: 16upx;
				margin-bottom: 30upx;

				image {
					border-radius: 16upx;
					width: 100%;
					height: 360upx;
				}

				.hgi-center {
					padding: 30upx 10upx;

					.hgi-center-introduce {
						font-size: 32upx;
						overflow: hidden;
						text-overflow: ellipsis;
						display: -webkit-box;
						-webkit-line-clamp: 2;
						-webkit-box-orient: vertical;

						.hgi-center-text-y {
							background: #ff0000;
							border-radius: 8upx;
							color: #fff;
							font-size: 30upx;
							margin-right: 15upx;
						}

						.hgi-center-text-v {
							background: #ff0000;
							color: #fff;
							font-size: 30upx;
							border-radius: 8upx;
						}
					}
				}

				.hgi-ad {
					width: 100%;
					display: flex;
					justify-content: space-between;

					.hgi-ad-type {
						text {
							color: #fff;
							background: #f00;
							border-radius: 15upx;
						}
					}

					.hgi-ad-address {
						color: #666;
						border: 1upx solid #666;
						border-radius: 15upx;
					}
				}

				.hgi-bottom {
					width: 100%;
					padding: 0 10upx;
					display: flex;
					justify-content: space-between;
					align-items: flex-end;

					.hgi-bottom-price {
						color: #ff0000;
						font-size: 40upx;
					}

					.hgi-bottom-num {
						color: #666666;
						font-size: 24upx;
						// padding-left: 30upx;
					}
				}
			}
		}

		.gcc-drawer {
			/deep/ uni-scroll-view {
				height: 100%;
			}

			/deep/ .uni-drawer__content {
				width: 80%;

				.gccd-content {
					padding: 30upx;

					.gccdc-lists {
						display: flex;
						flex-wrap: wrap;
						justify-content: space-between;

						.gccdcl-list {
							width: 30%;
							background: #efefef;
							text-align: center;
							padding: 15upx 0;
							margin-top: 30upx;
							border-radius: 15upx;
						}
					}
				}
			}
		}
	}

	/deep/.uni-scroll-view {
		// background-color: #E9E9E9;
		background: #fff;
	}

	/deep/.uni-scroll-view::-webkit-scrollbar {
		/* 隐藏滚动条，但依旧具备可以滚动的功能 */
		display: none
	}
</style>
