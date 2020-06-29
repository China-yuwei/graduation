<template>
	<view class="my-special-sale">
		<scroll-view scroll-x="true" :show-scrollbar="isScrollbar">
			<home-tab id="tabbar" :values="items" :stickyTop="108" :current="current" @clickItem="onClickItem"></home-tab>
		</scroll-view>
		<view class="mb-content">
			<view class="mbc-content" v-if="current == 0">
				<view class="mbcc-list" v-for="(item,index) in currentGoods" :key="index" @click="handleGoods(item)">
					<image :src="item.g_src" mode=""></image>
					<view class="mbccl-right">
						<text class="mbcclr-in">{{item.g_introduce}}</text>
						<text class="mbcclr-num">已售{{item.g_buy_num}}</text>
						<view class="mbcclr-bottom">
							<text>{{item.des}}</text>
							<view class="mbcclrb-price">
								￥<text>{{item.g_discount}}</text>
								<text class="mbcclrb-oldPrice">￥{{item.g_price}}</text>
							</view>
						</view>
					</view>
				</view>
			</view>
			<view class="mbc-content" v-else-if="current == 1">
				<view class="mbcc-content">
					<view class="mbcc-list" v-for="(item,index) in currentGoods" :key="index" @click="handleGoods(item)">
						<image :src="item.g_src" mode=""></image>
						<text class="mbcclr-in">{{item.g_introduce}}</text>
						<view class="mbcclr-bottom">
							<view class="mbcclrb-price">
								￥<text>{{item.g_price}}</text>
							</view>
							<text class="mbcclrb-num">已售{{item.g_buy_num}}件</text>
						</view>
					</view>
				</view>
			</view>
			<view class="mbc-content" v-else-if="current == 2">
				<view class="mbcc-content">
					<view class="mbcc-list" v-for="(item,index) in currentGoods" :key="index" @click="handleGoods(item)">
						<image :src="item.g_src" mode=""></image>
						<text class="mbcclr-in">{{item.g_introduce}}</text>
						<view class="mbcclr-bottom">
							<view class="mbcclrb-price">
								￥<text>{{item.g_price}}</text>
							</view>
							<text class="mbcclrb-num">已售{{item.g_buy_num}}件</text>
						</view>
					</view>
				</view>
			</view>
			<view class="mbc-content" v-else-if="current == 3">
				<view class="mbcc-content">
					<view class="mbcc-list" v-for="(item,index) in currentGoods" :key="index" @click="handleGoods(item)">
						<image :src="item.g_src" mode=""></image>
						<text class="mbcclr-in">{{item.g_introduce}}</text>
						<view class="mbcclr-bottom">
							<view class="mbcclrb-price">
								￥<text>{{item.g_price}}</text>
							</view>
							<text class="mbcclrb-num">已售{{item.g_buy_num}}件</text>
						</view>
					</view>
				</view>
			</view>
			<view class="mbc-content" v-else-if="current == 4">
				<view class="mbcc-content">
					<view class="mbcc-list" v-for="(item,index) in currentGoods" :key="index" @click="handleGoods(item)">
						<image :src="item.g_src" mode=""></image>
						<text class="mbcclr-in">{{item.g_introduce}}</text>
						<view class="mbcclr-bottom">
							<view class="mbcclrb-price">
								￥<text>{{item.g_price}}</text>
							</view>
							<text class="mbcclrb-num">已售{{item.g_buy_num}}件</text>
						</view>
					</view>
				</view>
			</view>
			<view class="mbc-content" v-else-if="current == 5">
				<view class="mbcc-content">
					<view class="mbcc-list" v-for="(item,index) in currentGoods" :key="index" @click="handleGoods(item)">
						<image :src="item.g_src" mode=""></image>
						<text class="mbcclr-in">{{item.g_introduce}}</text>
						<view class="mbcclr-bottom">
							<view class="mbcclrb-price">
								￥<text>{{item.g_price}}</text>
							</view>
							<text class="mbcclrb-num">已售{{item.g_buy_num}}件</text>
						</view>
					</view>
				</view>
			</view>
			<view class="mbc-content" v-else-if="current == 6">
				<view class="mbcc-content">
					<view class="mbcc-list" v-for="(item,index) in currentGoods" :key="index" @click="handleGoods(item)">
						<image :src="item.g_src" mode=""></image>
						<text class="mbcclr-in">{{item.g_introduce}}</text>
						<view class="mbcclr-bottom">
							<view class="mbcclrb-price">
								￥<text>{{item.g_price}}</text>
							</view>
							<text class="mbcclrb-num">已售{{item.g_buy_num}}件</text>
						</view>
					</view>
				</view>
			</view>
			<view class="mbc-content" v-else-if="current == 7">
				<view class="mbcc-content">
					<view class="mbcc-list" v-for="(item,index) in currentGoods" :key="index" @click="handleGoods(item)">
						<image :src="item.g_src" mode=""></image>
						<text class="mbcclr-in">{{item.g_introduce}}</text>
						<view class="mbcclr-bottom">
							<view class="mbcclrb-price">
								￥<text>{{item.g_price}}</text>
							</view>
							<text class="mbcclrb-num">已售{{item.g_buy_num}}件</text>
						</view>
					</view>
				</view>
			</view>
			<view class="mbc-content" v-else-if="current == 8">
				<view class="mbcc-content">
					<view class="mbcc-list" v-for="(item,index) in currentGoods" :key="index" @click="handleGoods(item)">
						<image :src="item.g_src" mode=""></image>
						<text class="mbcclr-in">{{item.g_introduce}}</text>
						<view class="mbcclr-bottom">
							<view class="mbcclrb-price">
								￥<text>{{item.g_price}}</text>
							</view>
							<text class="mbcclrb-num">已售{{item.g_buy_num}}件</text>
						</view>
					</view>
				</view>
			</view>
			<view class="mbc-content" v-else-if="current == 9">
				<view class="mbcc-content">
					<view class="mbcc-list" v-for="(item,index) in currentGoods" :key="index" @click="handleGoods(item)">
						<image :src="item.g_src" mode=""></image>
						<text class="mbcclr-in">{{item.g_introduce}}</text>
						<view class="mbcclr-bottom">
							<view class="mbcclrb-price">
								￥<text>{{item.g_price}}</text>
							</view>
							<text class="mbcclrb-num">已售{{item.g_buy_num}}件</text>
						</view>
					</view>
				</view>
			</view>
			<view class="mbc-content" v-else-if="current == 10">
				<view class="mbcc-content">
					<view class="mbcc-list" v-for="(item,index) in currentGoods" :key="index" @click="handleGoods(item)">
						<image :src="item.g_src" mode=""></image>
						<text class="mbcclr-in">{{item.g_introduce}}</text>
						<view class="mbcclr-bottom">
							<view class="mbcclrb-price">
								￥<text>{{item.g_price}}</text>
							</view>
							<text class="mbcclrb-num">已售{{item.g_buy_num}}件</text>
						</view>
					</view>
				</view>
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
				items: ["精选"], //选项卡列表
				current: 0, //选项卡点击的current
				isScrollbar: false, //是否显示滚动条
				currentGoods: [],
				allGoods: []
			};
		},
		onLoad() {
			let that = this
			uni.request({
				url: 'http://localhost:3000/goods/class',
				success: (res) => {
					let item = res.data.data.map(function(item) {
						return item.class_name
					})
					that.items = that.items.concat(item)
				}
			});
			uni.request({
				url: 'http://localhost:3000/goods',
				success: (res) => {
					let all = res.data.data
					that.allGoods = all.filter(function(item) {
						return item.g_discount != null
					})
					that.currentGoods = that.allGoods
				}
			});
		},
		methods: {
			onClickItem(index) { //选项卡
				let that = this
				if (that.current !== index) {
					that.current = index;
				}
				if (that.current == 0) {
					that.currentGoods = that.allGoods
				}
				if (that.current == 1) {
					that.currentGoods = that.allGoods.filter(function(item) {
						return item.class_id == 1
					})
				}
				if (that.current == 2) {
					that.currentGoods = that.allGoods.filter(function(item) {
						return item.class_id == 2
					})
				}
				if (that.current == 3) {
					that.currentGoods = that.allGoods.filter(function(item) {
						return item.class_id == 3
					})
				}
				if (that.current == 4) {
					that.currentGoods = that.allGoods.filter(function(item) {
						return item.class_id == 4
					})
				}
				if (that.current == 5) {
					that.currentGoods = that.allGoods.filter(function(item) {
						return item.class_id == 5
					})
				}
				if (that.current == 6) {
					that.currentGoods = that.allGoods.filter(function(item) {
						return item.class_id == 6
					})
				}
				if (that.current == 7) {
					that.currentGoods = that.allGoods.filter(function(item) {
						return item.class_id == 7
					})
				}
				if (that.current == 8) {
					that.currentGoods = that.allGoods.filter(function(item) {
						return item.class_id == 8
					})
				}
				if (that.current == 9) {
					that.currentGoods = that.allGoods.filter(function(item) {
						return item.class_id == 9
					})
				}
				if (that.current == 10) {
					that.currentGoods = that.allGoods.filter(function(item) {
						return item.class_id == 10
					})
				}
			},
			handleGoods(item) {
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

	.my-special-sale {
		background: #efefef;

		.mb-content {
			.mbc-content {
				padding: 0 30upx 30upx;

				.mbcc-list {
					margin-top: 30upx;
					background: #fff;
					border-radius: 15upx;
					display: flex;
					align-items: center;

					image {
						width: 30%;
						height: 280upx;
						border-radius: 15upx;
					}

					.mbccl-right {
						height: 280upx;
						flex: 1;
						padding: 0 30upx;
						display: flex;
						flex-direction: column;
						justify-content: space-between;

						.mbcclr-in {
							padding: 15upx 0;
							overflow: hidden;
							text-overflow: ellipsis;
							display: -webkit-box;
							-webkit-line-clamp: 2;
							-webkit-box-orient: vertical;
						}

						.mbcclr-num {
							color: #f00;
							font-size: 28upx;
						}

						.mbcclr-bottom {
							margin: 15upx 0;
							padding-left: 15upx;
							text-align: center;
							background: #efefef;
							border-radius: 45upx;
							display: flex;
							justify-content: space-between;
							align-items: center;

							.mbcclrb-price {
								min-width: 200upx;
								color: #fff;
								background: #67c23a;
								border-radius: 45upx;
								padding: 20upx 30upx;

								.mbcclrb-oldPrice {
									font-size: 28upx;
									text-decoration: line-through;
									padding-left: 15upx;
								}
							}
						}
					}
				}

				.mbcc-content {
					display: flex;
					flex-wrap: wrap;
					justify-content: space-between;

					.mbcc-list {
						width: 48%;
						background: #fff;
						border-radius: 15upx;
						display: flex;
						flex-direction: column;

						image {
							width: 100%;
							height: 300upx;
							padding-bottom: 15upx;
							border-radius: 15upx;
						}

						.mbcclr-in {
							overflow: hidden;
							text-overflow: ellipsis;
							display: -webkit-box;
							-webkit-line-clamp: 2;
							-webkit-box-orient: vertical;
							padding: 0 15upx;
						}

						.mbcclr-bottom {
							width: 100%;
							padding: 15upx 0;
							display: flex;
							flex-direction: column;
							align-items: flex-start;

							.mbcclrb-price {
								background: #f00;
								color: #fff;
								border-radius: 15upx;
								padding: 0 30upx;
								margin: 0 15upx;

								text {
									font-size: 60upx;
								}
							}

							.mbcclrb-num {
								display: block;
								padding: 15upx;
								color: #f00;
							}
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
