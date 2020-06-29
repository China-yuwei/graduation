<template>
	<view class="my-shop">
		<home-tab id="tabbar" :values="items" :stickyTop="108" :current="current" @clickItem="onClickItem"></home-tab>
		<view class="ms-content">
			<view class="msc-tab" v-if="current == 0">
				<swiper class="swiper" :indicator-dots="indicatorDots" :autoplay="autoplay" :interval="interval" :duration="duration"
				 :circular="circular">
					<swiper-item class="msct-swiper" v-for="(item,index) in fShopsLists" :key="index" @click="handleImg(item)">
						<image :src="item.s_bg" mode=""></image>
						<view class="msct-swiper-content">
							<view class="msctsc-name"><text>{{item.s_title}}</text></view>
							<text class="msctsc-in">{{item.s_introduce}}</text>
							<view class="mscts-shop">
								<image src="/../static/goodsClass-img/dianpu.png" mode=""></image>
								<text>{{item.s_name}}</text>
							</view>
							<view class="mscts-img">
								<image :src="item.s_bga" mode=""></image>
								<image :src="item.s_bgb" mode=""></image>
								<image :src="item.s_bgc" mode=""></image>
							</view>
						</view>
					</swiper-item>
				</swiper>
				<view class="msct-name">
					超多人收藏的店铺!
				</view>
				<view class="my-shop-ms">
					<scroll-view scroll-x="true" :show-scrollbar="isScrollbar">
						<view class="mbct-img" v-for="(item,index) in fShopsLists" :key="index" @click="handleImg(item)">
							<view class="ms-scroll-title">
								<image :src="item.s_icon" mode=""></image>
								<view class="msst-name">
									<text class="msst-name-shop">{{item.s_name}}</text>
									<view class="msst-name-spe">
										<text>{{item.s_p}}</text>
										<text>{{item.s_y}}</text>
										<text>{{item.s_v}}</text>
									</view>
								</view>
							</view>
							<view class="ms-scroll-img">
								<image :src="item.s_bga" mode=""></image>
								<image :src="item.s_bgb" mode=""></image>
							</view>
						</view>
					</scroll-view>
				</view>
				<view class="msct-list-content">
					<view class="msct-list" v-for="(item,index) in fShopsLists" :key="index">
						<view class="msctl-title">
							<view class="msctlt-left">
								<image :src="item.s_icon" mode=""></image>
								<view class="msctltl-name">
									<text class="msctltl-name-shop">{{item.s_name}}</text>
									<view class="msctltl-name-spe">
										<text>{{item.s_p}}</text>
										<text>{{item.s_y}}</text>
										<text>{{item.s_v}}</text>
									</view>
								</view>
							</view>
							<view class="msctlt-right" @click="handleImg(item)">
								<text>进店</text>
								<image src="../../static/my-img/you.png" mode=""></image>
							</view>
						</view>
						<view class="msctl-center">
							<image src="../../static/goodsClass-img/dianpu.png" mode=""></image>
							<text>经营：{{item.s_run}}</text>
						</view>
						<view class="msctl-img">
							<image :src="item.s_bg" mode=""></image>
							<view class="msctli-img">
								<image :src="item.s_bga" mode=""></image>
								<image :src="item.s_bgb" mode=""></image>
							</view>
						</view>
					</view>
				</view>
			</view>
			<view class="msc-tab" v-else-if="current == 1">
				<view class="msctttt">
					<view class="msct-list" v-for="(item,index) in fShopsLists" :key="index">
						<view class="msctl-title">
							<view class="msctlt-left">
								<image :src="item.s_icon" mode=""></image>
								<view class="msctltl-name">
									<text class="msctltl-name-shop">{{item.s_name}}</text>
									<view class="msctltl-name-spe">
										<text>{{item.s_p}}</text>
										<text>{{item.s_y}}</text>
										<text>{{item.s_v}}</text>
									</view>
								</view>
							</view>
							<view class="msctlt-right" @click="handleImg(item)">
								<text>进店</text>
								<image src="../../static/my-img/you.png" mode=""></image>
							</view>
						</view>
						<view class="msctl-center">
							<image src="../../static/goodsClass-img/dianpu.png" mode=""></image>
							<text>经营：{{item.s_run}}</text>
						</view>
						<view class="msctl-img">
							<image :src="item.s_bg" mode=""></image>
							<view class="msctli-img">
								<image :src="item.s_bga" mode=""></image>
								<image :src="item.s_bgb" mode=""></image>
							</view>
						</view>
					</view>
				</view>
			</view>
			<view class="msc-tab" v-else-if="current == 2">
				<view class="msctttt">
					<view class="msct-list" v-for="(item,index) in fShopsLists" :key="index">
						<view class="msctl-title">
							<view class="msctlt-left">
								<image :src="item.s_icon" mode=""></image>
								<view class="msctltl-name">
									<text class="msctltl-name-shop">{{item.s_name}}</text>
									<view class="msctltl-name-spe">
										<text>{{item.s_p}}</text>
										<text>{{item.s_y}}</text>
										<text>{{item.s_v}}</text>
									</view>
								</view>
							</view>
							<view class="msctlt-right" @click="handleImg(item)">
								<text>进店</text>
								<image src="../../static/my-img/you.png" mode=""></image>
							</view>
						</view>
						<view class="msctl-center">
							<image src="../../static/goodsClass-img/dianpu.png" mode=""></image>
							<text>经营：{{item.s_run}}</text>
						</view>
						<view class="msctl-img">
							<image :src="item.s_bg" mode=""></image>
							<view class="msctli-img">
								<image :src="item.s_bga" mode=""></image>
								<image :src="item.s_bgb" mode=""></image>
							</view>
						</view>
					</view>
				</view>
			</view>
			<view class="msc-tab" v-else-if="current == 3">
				<view class="msctttt">
					<view class="msct-list" v-for="(item,index) in fShopsLists" :key="index">
						<view class="msctl-title">
							<view class="msctlt-left">
								<image :src="item.s_icon" mode=""></image>
								<view class="msctltl-name">
									<text class="msctltl-name-shop">{{item.s_name}}</text>
									<view class="msctltl-name-spe">
										<text>{{item.s_p}}</text>
										<text>{{item.s_y}}</text>
										<text>{{item.s_v}}</text>
									</view>
								</view>
							</view>
							<view class="msctlt-right" @click="handleImg(item)">
								<text>进店</text>
								<image src="../../static/my-img/you.png" mode=""></image>
							</view>
						</view>
						<view class="msctl-center">
							<image src="../../static/goodsClass-img/dianpu.png" mode=""></image>
							<text>经营：{{item.s_run}}</text>
						</view>
						<view class="msctl-img">
							<image :src="item.s_bg" mode=""></image>
							<view class="msctli-img">
								<image :src="item.s_bga" mode=""></image>
								<image :src="item.s_bgb" mode=""></image>
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
				items: ["推荐", "热销店", "品牌店", "全部"], //选项卡列表
				current: 0, //选项卡点击的current
				indicatorDots: true,
				autoplay: true,
				circular: true,
				interval: 2000,
				duration: 500,
				isScrollbar: false,
				allShops: [],
				fShopsLists: []
			};
		},
		onLoad() {
			let that = this
			uni.request({
				url: 'http://localhost:3000/shops',
				success: (res) => {
					that.allShops = res.data.data.sort(function(a, b) {
						let x = a.s_person;
						let y = b.s_person;
						if (x < y) {
							return 1;
						}
						if (x > y) {
							return -1;
						}
						return 0;
					})
					that.fShopsLists = that.allShops.slice(0, 3)
				}
			});
		},
		methods: {
			onClickItem(index) { //选项卡
				let that = this
				if (this.current !== index) {
					this.current = index;
				}
				if(that.current == 0){
					that.fShopsLists = that.allShops.slice(0, 3)
				}
				if(that.current == 1){
					that.fShopsLists = that.allShops.filter(function(item){
						return item.s_person >= 20
					})
				}
				if(that.current == 2){
					that.fShopsLists = that.allShops.filter(function(item){
						return item.s_p == "品牌"
					})
				}
				if(that.current == 3){
					that.fShopsLists = that.allShops
				}
			},
			handleImg(item) {
				uni.navigateTo({
					url: '../home-swiper-shop/home-swiper-shop?id=' + item.shop_id
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

	.my-shop {
		background: #efefef;

		/deep/ .home-tab-control {
			.home-tab-control-item {
				width: 25%;
				text-align: center;
			}
		}

		.ms-content {
			.msc-tab {
				/deep/ .swiper {
					height: 400upx;

					.msct-swiper {
						position: relative;

						>image {
							width: 100%;
						}

						.msct-swiper-content {
							height: 80%;
							width: 80%;
							position: absolute;
							left: 30upx;
							top: 30upx;
							display: flex;
							flex-direction: column;
							justify-content: space-between;

							.msctsc-name {
								margin-left: -30upx;

								text {
									background: #67c23a;
									padding: 15upx 30upx;
									border-top-right-radius: 45upx;
									border-bottom-right-radius: 45upx;
								}
							}

							.msctsc-in {
								color: #fff;
								overflow: hidden;
								text-overflow: ellipsis;
								white-space: nowrap;
							}

							.mscts-shop {
								color: #fff;
								display: flex;
								align-items: center;

								image {
									width: 40upx;
									height: 40upx;
									margin-right: 30upx;
								}
							}

							.mscts-img {
								display: flex;

								image {
									width: 120upx;
									height: 120upx;
									border-radius: 15upx;
									margin-right: 15upx;
								}
							}
						}
					}
				}

				.msct-name {
					padding: 30upx;
				}

				.my-shop-ms {
					padding: 0 30upx;

					/deep/ uni-scroll-view {

						.uni-scroll-view-content {
							display: flex;

							.mbct-img:last-child {
								margin-right: 0;
							}

							.mbct-img {
								min-width: 400upx;
								background: #fff;
								border-radius: 15upx;
								margin-right: 30upx;
								padding: 30upx;

								.ms-scroll-title {
									padding-bottom: 30upx;
									display: flex;
									align-items: center;

									image {
										width: 90upx;
										height: 90upx;
										margin-right: 15upx;
										border-radius: 45upx;
									}

									.msst-name {
										display: flex;
										flex-direction: column;

										.msst-name-shop {
											overflow: hidden;
											text-overflow: ellipsis;
											white-space: nowrap;
										}

										.msst-name-spe {
											text {
												background: #f00;
												color: #fff;
												font-size: 28upx;
											}
										}
									}
								}

								.ms-scroll-img {
									display: flex;
									justify-content: space-between;

									image {
										width: 48%;
										height: 150upx;
										border-radius: 15upx;
									}
								}
							}
						}
					}
				}

				.msct-list-content {
					padding: 0 30upx 30upx;
				}
				.msctttt{
					padding: 0 30upx 30upx;
				}
				.msct-list {
					margin-top: 30upx;
					background: #fff;
					border-radius: 15upx;
					padding: 30upx;
				
					.msctl-title {
						display: flex;
						align-items: center;
						justify-content: space-between;
				
						.msctlt-left {
							display: flex;
							align-items: center;
				
							image {
								width: 90upx;
								height: 90upx;
								margin-right: 15upx;
								border-radius: 45upx;
							}
				
							.msctltl-name {
								display: flex;
								flex-direction: column;
				
								.msctltl-name-shop {
									overflow: hidden;
									text-overflow: ellipsis;
									white-space: nowrap;
								}
				
								.msctltl-name-spe {
									text {
										background: #f00;
										color: #fff;
										font-size: 28upx;
									}
								}
							}
						}
				
						.msctlt-right {
							background: #f00;
							color: #fff;
							padding: 10upx 20upx 10upx 40upx;
							border-radius: 45upx;
				
							image {
								width: 40upx;
								height: 40upx;
								margin-left: 15upx;
								vertical-align: middle;
							}
						}
					}
				
					.msctl-center {
						margin: 30upx 0;
						padding: 30upx;
						background: #efefef;
						border-radius: 15upx;
						display: flex;
						align-items: center;
				
						image {
							width: 40upx;
							height: 40upx;
							margin-right: 15upx;
						}
				
						text {
							width: 90%;
							overflow: hidden;
							white-space: nowrap;
							text-overflow: ellipsis;
						}
					}
				
					.msctl-img {
						display: flex;
						align-items: center;
				
						>image {
							width: 60%;
							height: 200upx;
							margin-right: 30upx;
						}
				
						.msctli-img {
							flex: 1;
							display: flex;
							flex-direction: column;
							align-items: center;
				
							image {
								width: 90%;
								height: 100upx;
							}
						}
					}
				}
			}
		}
	}
</style>
