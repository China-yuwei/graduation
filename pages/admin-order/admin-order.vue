<template>
	<view class="admin-order">
		<scroll-view scroll-x="true" :show-scrollbar="isScrollbar">
			<home-tab id="tabbar" :values="items" :stickyTop="108" :current="current" @clickItem="onClickItem"></home-tab>
		</scroll-view>
		<view class="ao-all">
			<view class="ao-content" v-if="current == 0">
				<view class="aoa-list" v-for="(item,index) in orderLists" :key="index">
					<text>{{item.o_type}}</text>
					<view class="aoal-content">
						<image :src="item.g_src" mode=""></image>
						<view class="aoalc-right">
							<text>{{item.g_name}}</text>
							<view class="aoalcr-center">
								<text class="aoalcrc-price">￥{{item.g_price}}</text>
								<text class="aoalcrc-num">x{{item.g_num}}</text>
							</view>
							<view class="aoalc-time">
								{{item.o_time}}
							</view>
						</view>
					</view>
				</view>
			</view>
			<view class="ao-content" v-if="current == 1">
				<view class="aoa-list" v-for="(item,index) in orderLists" :key="index">
					<text>{{item.o_type}}</text>
					<view class="aoal-content">
						<image :src="item.g_src" mode=""></image>
						<view class="aoalc-right">
							<text>{{item.g_name}}</text>
							<view class="aoalcr-center">
								<text class="aoalcrc-price">￥{{item.g_price}}</text>
								<text class="aoalcrc-num">x{{item.g_num}}</text>
							</view>
							<view class="aoalc-time">
								{{item.o_time}}
							</view>
						</view>
					</view>
				</view>
			</view>
			<view class="ao-content" v-if="current == 2">
				<view class="aoa-list" v-for="(item,index) in orderLists" :key="index">
					<text>{{item.o_type}}</text>
					<view class="aoal-content">
						<image :src="item.g_src" mode=""></image>
						<view class="aoalc-right">
							<text>{{item.g_name}}</text>
							<view class="aoalcr-center">
								<text class="aoalcrc-price">￥{{item.g_price}}</text>
								<text class="aoalcrc-num">x{{item.g_num}}</text>
							</view>
							<view class="aoalc-time">
								{{item.o_time}}
							</view>
						</view>
					</view>
				</view>
			</view>
			<view class="ao-content" v-if="current == 3">
				<view class="aoa-list" v-for="(item,index) in orderLists" :key="index">
					<text>{{item.o_type}}</text>
					<view class="aoal-content">
						<image :src="item.g_src" mode=""></image>
						<view class="aoalc-right">
							<text>{{item.g_name}}</text>
							<view class="aoalcr-center">
								<text class="aoalcrc-price">￥{{item.g_price}}</text>
								<text class="aoalcrc-num">x{{item.g_num}}</text>
							</view>
							<view class="aoalc-time">
								{{item.o_time}}
							</view>
						</view>
					</view>
				</view>
			</view>
			<view class="ao-content" v-if="current == 4">
				<view class="aoa-list" v-for="(item,index) in orderLists" :key="index">
					<text>{{item.o_type}}</text>
					<view class="aoal-content">
						<image :src="item.g_src" mode=""></image>
						<view class="aoalc-right">
							<text>{{item.g_name}}</text>
							<view class="aoalcr-center">
								<text class="aoalcrc-price">￥{{item.g_price}}</text>
								<text class="aoalcrc-num">x{{item.g_num}}</text>
							</view>
							<view class="aoalc-time">
								{{item.o_time}}
							</view>
						</view>
					</view>
				</view>
			</view>
			<view class="ao-content" v-if="current == 5">
				<view class="aoa-list" v-for="(item,index) in orderLists" :key="index">
					<text>{{item.o_type}}</text>
					<view class="aoal-content">
						<image :src="item.g_src" mode=""></image>
						<view class="aoalc-right">
							<text>{{item.g_name}}</text>
							<view class="aoalcr-center">
								<text class="aoalcrc-price">￥{{item.g_price}}</text>
								<text class="aoalcrc-num">x{{item.g_num}}</text>
							</view>
							<view class="aoalc-time">
								{{item.o_time}}
							</view>
						</view>
					</view>
				</view>
			</view>
			<view class="ao-content" v-if="current == 6">
				<view class="aoa-list" v-for="(item,index) in orderLists" :key="index">
					<text>{{item.o_type}}</text>
					<view class="aoal-content">
						<image :src="item.g_src" mode=""></image>
						<view class="aoalc-right">
							<text>{{item.g_name}}</text>
							<view class="aoalcr-center">
								<text class="aoalcrc-price">￥{{item.g_price}}</text>
								<text class="aoalcrc-num">x{{item.g_num}}</text>
							</view>
							<view class="aoalc-time">
								{{item.o_time}}
							</view>
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
				items: ["全部", "待付款", "待发货", "待收货", "待评价", "已成功", "已关闭"], //选项卡列表
				current: 0, //选项卡点击的current
				isScrollbar: false, //是否显示滚动条
				orderLists: [],
				allOrder: []
			};
		},
		onLoad() {
			let that = this
			uni.request({ //选项卡
				url: 'http://localhost:3000/admin/order',
				success: (res) => {
					let getData = res.data.data
					that.allOrder = getData.sort(function(a, b) {
						let x = a.o_time.toLowerCase();
						let y = b.o_time.toLowerCase();
						if (x < y) {
							return 1;
						}
						if (x > y) {
							return -1;
						}
						return 0;
					})
					that.orderLists = that.allOrder
				}
			});
		},
		methods: {
			onClickItem(index) {
				let that = this
				if (that.current !== index) {
					that.current = index;
				}
				if (that.current == 0) {
					that.orderLists = that.allOrder
				}
				if (that.current == 1) {
					that.orderLists = that.allOrder.filter(function(item) {
						return item.o_type == "待付款"
					})
				}
				if (that.current == 2) {
					that.orderLists = that.allOrder.filter(function(item) {
						return item.o_type == "待发货"
					})
				}
				if (that.current == 3) {
					that.orderLists = that.allOrder.filter(function(item) {
						return item.o_type == "待收货"
					})
				}
				if (that.current == 4) {
					that.orderLists = that.allOrder.filter(function(item) {
						return item.o_type == "待评价"
					})
				}
				if (that.current == 5) {
					that.orderLists = that.allOrder.filter(function(item) {
						return item.o_type == "已成功"
					})
				}
				if (that.current == 6) {
					that.orderLists = that.allOrder.filter(function(item) {
						return item.o_type == "已关闭"
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

	.admin-order {
		/deep/ uni-scroll-view {
			position: fixed;
			top: 44px;
			z-index: 100;
		}

		.ao-all {
			margin-top: 124upx;
			background: #efefef;

			.ao-content {
				padding: 30upx;

				.aoa-list:first-child {
					margin: 0;
				}

				.aoa-list {
					background: #fff;
					padding: 30upx;
					margin-top: 30upx;
					border-radius: 15upx;

					.aoal-content {
						padding-top: 30upx;
						display: flex;
						align-items: center;

						>image {
							width: 30%;
							height: 180upx;
							margin-right: 30upx;
							border-radius: 15upx;
						}

						.aoalc-right {
							flex: 1;
							display: flex;
							flex-direction: column;
							justify-content: space-between;

							.aoalcr-center {
								padding: 10upx 0;
								display: flex;
								justify-content: space-between;
								align-items: center;

								.aoalcrc-price {
									font-size: 32upx;
									color: #333;
								}

								.aoalcrc-num {
									font-size: 32upx;
									color: #999;
								}
							}

							.aoalc-time {
								font-size: 32upx;
								color: #999;
								// text-align: right;
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
