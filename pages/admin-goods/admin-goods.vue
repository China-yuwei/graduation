<template>
	<view class="admin-goods">
		<scroll-view scroll-x="true" :show-scrollbar="isScrollbar">
			<home-tab id="tabbar" :values="items" :stickyTop="108" :current="current" @clickItem="onClickItem"></home-tab>
		</scroll-view>
		<view class="ag-all">
			<view class="aga-content" v-if="current == 0">
				<view class="agac-list" v-for="(item,index) in currentGoods" :key="index">
					<view class="agacl-title">
						<text>{{item.g_name}}</text>
						<view class="agaclt-icon">
							<image src="../../static/my-img/bianjidizhi.png" mode="" @click="handleEdit(item)"></image>
							<image src="../../static/my-img/shanchu.png" mode="" @click="handleDelete(item)"></image>
						</view>
					</view>
					<view class="agacl-center">
						<image :src="item.g_src" mode=""></image>
						<view class="agaclc-right">
							<text>{{item.g_introduce}}</text>
							<adminGoodsPrice :list="item"></adminGoodsPrice>
						</view>
					</view>
				</view>
			</view>
			<view class="aga-content" v-else-if="current == 1">
				<view class="agac-list" v-for="(item,index) in currentGoods" :key="index">
					<view class="agacl-title">
						<text>{{item.g_name}}</text>
						<view class="agaclt-icon">
							<image src="../../static/my-img/bianjidizhi.png" mode="" @click="handleEdit(item)"></image>
							<image src="../../static/my-img/shanchu.png" mode="" @click="handleDelete(item)"></image>
						</view>
					</view>
					<view class="agacl-center">
						<image :src="item.g_src" mode=""></image>
						<view class="agaclc-right">
							<text>{{item.g_introduce}}</text>
							<adminGoodsPrice :list="item"></adminGoodsPrice>
						</view>
					</view>
				</view>
			</view>
			<view class="aga-content" v-else-if="current == 2">
				<view class="agac-list" v-for="(item,index) in currentGoods" :key="index">
					<view class="agacl-title">
						<text>{{item.g_name}}</text>
						<view class="agaclt-icon">
							<image src="../../static/my-img/bianjidizhi.png" mode="" @click="handleEdit(item)"></image>
							<image src="../../static/my-img/shanchu.png" mode="" @click="handleDelete(item)"></image>
						</view>
					</view>
					<view class="agacl-center">
						<image :src="item.g_src" mode=""></image>
						<view class="agaclc-right">
							<text>{{item.g_introduce}}</text>
							<adminGoodsPrice :list="item"></adminGoodsPrice>
						</view>
					</view>
				</view>
			</view>
			<view class="aga-content" v-else-if="current == 3">
				<view class="agac-list" v-for="(item,index) in currentGoods" :key="index">
					<view class="agacl-title">
						<text>{{item.g_name}}</text>
						<view class="agaclt-icon">
							<image src="../../static/my-img/bianjidizhi.png" mode="" @click="handleEdit(item)"></image>
							<image src="../../static/my-img/shanchu.png" mode="" @click="handleDelete(item)"></image>
						</view>
					</view>
					<view class="agacl-center">
						<image :src="item.g_src" mode=""></image>
						<view class="agaclc-right">
							<text>{{item.g_introduce}}</text>
							<adminGoodsPrice :list="item"></adminGoodsPrice>
						</view>
					</view>
				</view>
			</view>
			<view class="aga-content" v-else-if="current == 4">
				<view class="agac-list" v-for="(item,index) in currentGoods" :key="index">
					<view class="agacl-title">
						<text>{{item.g_name}}</text>
						<view class="agaclt-icon">
							<image src="../../static/my-img/bianjidizhi.png" mode="" @click="handleEdit(item)"></image>
							<image src="../../static/my-img/shanchu.png" mode="" @click="handleDelete(item)"></image>
						</view>
					</view>
					<view class="agacl-center">
						<image :src="item.g_src" mode=""></image>
						<view class="agaclc-right">
							<text>{{item.g_introduce}}</text>
							<adminGoodsPrice :list="item"></adminGoodsPrice>
						</view>
					</view>
				</view>
			</view>
			<view class="aga-content" v-else-if="current == 5">
				<view class="agac-list" v-for="(item,index) in currentGoods" :key="index">
					<view class="agacl-title">
						<text>{{item.g_name}}</text>
						<view class="agaclt-icon">
							<image src="../../static/my-img/bianjidizhi.png" mode="" @click="handleEdit(item)"></image>
							<image src="../../static/my-img/shanchu.png" mode="" @click="handleDelete(item)"></image>
						</view>
					</view>
					<view class="agacl-center">
						<image :src="item.g_src" mode=""></image>
						<view class="agaclc-right">
							<text>{{item.g_introduce}}</text>
							<adminGoodsPrice :list="item"></adminGoodsPrice>
						</view>
					</view>
				</view>
			</view>
			<view class="aga-content" v-else-if="current == 6">
				<view class="agac-list" v-for="(item,index) in currentGoods" :key="index">
					<view class="agacl-title">
						<text>{{item.g_name}}</text>
						<view class="agaclt-icon">
							<image src="../../static/my-img/bianjidizhi.png" mode="" @click="handleEdit(item)"></image>
							<image src="../../static/my-img/shanchu.png" mode="" @click="handleDelete(item)"></image>
						</view>
					</view>
					<view class="agacl-center">
						<image :src="item.g_src" mode=""></image>
						<view class="agaclc-right">
							<text>{{item.g_introduce}}</text>
							<adminGoodsPrice :list="item"></adminGoodsPrice>
						</view>
					</view>
				</view>
			</view>
			<view class="aga-content" v-else-if="current == 7">
				<view class="agac-list" v-for="(item,index) in currentGoods" :key="index">
					<view class="agacl-title">
						<text>{{item.g_name}}</text>
						<view class="agaclt-icon">
							<image src="../../static/my-img/bianjidizhi.png" mode="" @click="handleEdit(item)"></image>
							<image src="../../static/my-img/shanchu.png" mode="" @click="handleDelete(item)"></image>
						</view>
					</view>
					<view class="agacl-center">
						<image :src="item.g_src" mode=""></image>
						<view class="agaclc-right">
							<text>{{item.g_introduce}}</text>
							<adminGoodsPrice :list="item"></adminGoodsPrice>
						</view>
					</view>
				</view>
			</view>
			<view class="aga-content" v-else-if="current == 8">
				<view class="agac-list" v-for="(item,index) in currentGoods" :key="index">
					<view class="agacl-title">
						<text>{{item.g_name}}</text>
						<view class="agaclt-icon">
							<image src="../../static/my-img/bianjidizhi.png" mode="" @click="handleEdit(item)"></image>
							<image src="../../static/my-img/shanchu.png" mode="" @click="handleDelete(item)"></image>
						</view>
					</view>
					<view class="agacl-center">
						<image :src="item.g_src" mode=""></image>
						<view class="agaclc-right">
							<text>{{item.g_introduce}}</text>
							<adminGoodsPrice :list="item"></adminGoodsPrice>
						</view>
					</view>
				</view>
			</view>
			<view class="aga-content" v-else-if="current == 9">
				<view class="agac-list" v-for="(item,index) in currentGoods" :key="index">
					<view class="agacl-title">
						<text>{{item.g_name}}</text>
						<view class="agaclt-icon">
							<image src="../../static/my-img/bianjidizhi.png" mode="" @click="handleEdit(item)"></image>
							<image src="../../static/my-img/shanchu.png" mode="" @click="handleDelete(item)"></image>
						</view>
					</view>
					<view class="agacl-center">
						<image :src="item.g_src" mode=""></image>
						<view class="agaclc-right">
							<text>{{item.g_introduce}}</text>
							<adminGoodsPrice :list="item"></adminGoodsPrice>
						</view>
					</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	import homeTab from '../../components/home-tab.vue';
	import adminGoodsPrice from '../../components/admin-goods-price.vue';
	export default {
		components: {
			homeTab,
			adminGoodsPrice
		},
		data() {
			return {
				items: [], //选项卡列表
				current: 0, //选项卡点击的current
				isScrollbar: false, //是否显示滚动条
				allGoods: [],
				currentGoods: []
			};
		},
		onLoad() {
			let that = this
			uni.request({ //选项卡
				url: 'http://localhost:3000/goods/class',
				success: (res) => {
					let item = res.data.data.map(function(item) {
						return item.class_name
					})
					that.items = that.items.concat(item)
				}
			});
			uni.request({ //商品
				url: 'http://localhost:3000/goods',
				success: (res) => {
					let getData = res.data.data
					that.allGoods = getData.sort(function(a, b) {
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
					that.currentGoods = that.allGoods.filter(function(item) {
						return item.class_id == 1
					})
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
					that.currentGoods = that.allGoods.filter(function(item) {
						return item.class_id == 1
					})
				}
				if (that.current == 1) {
					that.currentGoods = that.allGoods.filter(function(item) {
						return item.class_id == 2
					})
				}
				if (that.current == 2) {
					that.currentGoods = that.allGoods.filter(function(item) {
						return item.class_id == 3
					})
				}
				if (that.current == 3) {
					that.currentGoods = that.allGoods.filter(function(item) {
						return item.class_id == 4
					})
				}
				if (that.current == 4) {
					that.currentGoods = that.allGoods.filter(function(item) {
						return item.class_id == 5
					})
				}
				if (that.current == 5) {
					that.currentGoods = that.allGoods.filter(function(item) {
						return item.class_id == 6
					})
				}
				if (that.current == 6) {
					that.currentGoods = that.allGoods.filter(function(item) {
						return item.class_id == 7
					})
				}
				if (that.current == 7) {
					that.currentGoods = that.allGoods.filter(function(item) {
						return item.class_id == 8
					})
				}
				if (that.current == 8) {
					that.currentGoods = that.allGoods.filter(function(item) {
						return item.class_id == 9
					})
				}
				if (that.current == 9) {
					that.currentGoods = that.allGoods.filter(function(item) {
						return item.class_id == 10
					})
				}
			},
			handleEdit(item) {
				uni.navigateTo({
					url: '../admin-goods-edit/admin-goods-edit?good=' + JSON.stringify(item)
				});
			},
			handleDelete(item) {
				uni.request({ //选项卡
					url: 'http://localhost:3000/del/goods',
					data: {
						goodsId: item.g_id
					},
					success: (res) => {
						uni.showToast({
							title: res.data.data,
							icon: 'none',
							duration: 2000
						})
						this.currentGoods = this.currentGoods.filter(function(i) {
							return i.g_id != item.g_id
						})
					}
				});
			}
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
		background: #efefef;
	}

	.admin-goods {
		/deep/ uni-scroll-view {
			position: fixed;
			top: 44px;
			z-index: 100;
		}

		.ag-all {
			margin-top: 124upx;

			.aga-content {
				background: #efefef;

				.agac-list {
					background: #fff;
					margin-top: 30upx;
					padding: 30upx;

					.agacl-title {
						display: flex;
						justify-content: space-between;
						align-items: center;

						text {
							font-size: 48upx;
						}

						.agaclt-icon {
							image {
								width: 40upx;
								height: 40upx;
								margin-left: 30upx;
							}
						}
					}

					.agacl-center {
						display: flex;
						align-items: center;
						padding-top: 30upx;

						>image {
							width: 30%;
							height: 240upx;
							margin-right: 30upx;
						}

						.agaclc-right {
							flex: 1;
							display: flex;
							flex-direction: column;
							justify-content: space-between;

							>text {
								overflow: hidden;
								text-overflow: ellipsis;
								display: -webkit-box;
								-webkit-line-clamp: 2;
								-webkit-box-orient: vertical;
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
