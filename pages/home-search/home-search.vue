<!-- 首页-搜索 -->
<template>
	<view class="home-search">
		<view class="hot-search" :style="isShowNear">
			<view class="hs-text">
				<text>最近搜索</text>
				<text @click="handleDel">清空</text>
			</view>
			<view class="hot-search-goods">
				<text v-for="(item,index) in nearSearch" :key="index" @click="handleNearGoods(index)">{{item}}</text>
			</view>
		</view>
		<view class="hot-search" :style="isShowHot">
			<view class="hs-text">
				<text>热搜</text>
			</view>
			<view class="hot-search-goods">
				<text v-for="(item,index) in hotSearch" :key="index" @click="handleGoods(index)">{{item}}</text>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				searchValue: "",
				nearSearch: [],
				hotSearch: [],
				isShowNear: "display: none;",
				isShowHot: "display: none;",
				user: []
			};
		},
		onShow() {
			let that = this
			uni.getStorage({
				key: 'user_login',
				success(res) {
					that.user = res.data
					uni.request({
						url: 'http://localhost:3000/home/nearSearch',
						data: {
							userId: that.user.user_id
						},
						success: (res) => {
							if (res.data.data.length !== 0) {
								that.isShowNear = "display: block;"
								let word = res.data.data.map(function(item) {
									return item.search_keyword
								})
								that.nearSearch = [...new Set(word)]
							}
						}
					});
				},
			})
			uni.request({
				url: 'http://localhost:3000/home/search',
				success: (res) => {
					if (res.data.data.length !== 0) {
						that.isShowHot = "display: block;"
						let word = res.data.data.map(function(item) {
							return item.search_keyword
						})
						that.hotSearch = [...new Set(word)]
					}
				}
			});
		},
		methods: {
			handleGoods(index) {
				let that = this
				uni.request({
					url: 'http://localhost:3000/home/to/search',
					data: {
						userId: that.user.user_id,
						inputKeyword: that.hotSearch[index]
					},
					success: (res) => {
						uni.navigateTo({
							url: '../home-search-goods/home-search-goods?key=' + that.hotSearch[index]
						})
					}
				});
			},
			handleNearGoods(index) {
				let that = this
				uni.request({
					url: 'http://localhost:3000/home/to/search',
					data: {
						userId: that.user.user_id,
						inputKeyword: that.nearSearch[index]
					},
					success: (res) => {
						uni.navigateTo({
							url: '../home-search-goods/home-search-goods?key=' + that.nearSearch[index]
						})
					}
				});
			},
			handleDel() {
				uni.request({
					url: 'http://localhost:3000/del/nearSearch',
					data: {
						userId: this.user.user_id
					},
					success: (res) => {
						this.isShowNear = "display: none;"
					}
				});
			}
		},
		onNavigationBarSearchInputChanged(val) {
			this.searchValue = val.text
		},
		onNavigationBarButtonTap() {
			let that = this
			uni.request({
				url: 'http://localhost:3000/home/to/search',
				data: {
					userId: that.user.user_id,
					inputKeyword: that.searchValue
				},
				success: (res) => {
					uni.navigateTo({
						url: '../home-search-goods/home-search-goods?key=' + that.searchValue
					})
				}
			});
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
	}

	.home-search {
		height: 100%;
		padding: 30upx;
		background: #efefef;

		.hot-search {
			background: #fff;
			border-radius: 16upx;
			padding: 30upx;
			font-size: 40upx;
			margin-bottom: 30upx;

			.hs-text {
				display: flex;
				justify-content: space-between;
			}

			.hot-search-goods {

				text {
					display: inline-block;
					padding: 15upx;
					background: #efefef;
					margin: 30upx 30upx 0 0;
					border-radius: 12upx;
					font-size: 36upx;
				}
			}
		}
	}
</style>
