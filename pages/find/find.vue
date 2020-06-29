<template>
	<view class="find">
		<view class="find-head">
			<view class="my-head-top">
				<text>茶文化</text>
			</view>
			<view class="my-head-bottom">
				<view class="mhb-list" @click="handleBrowse">
					<text>{{seeNum}}</text>
					<text>我的浏览</text>
				</view>
				<view class="mhb-list" @click="handleInfo">
					<text>{{infoNum}}</text>
					<text>未读消息</text>
				</view>
				<view class="mhb-list" @click="handleShare">
					<text>0</text>
					<text>我的分享</text>
				</view>
			</view>
		</view>
		<view class="find-content">
			<view class="fc-list" v-for="(item,index) in findList" :key="index" @click="handleF(item)">
				<image :src="item.f_icon" mode=""></image>
				<text>{{item.f_name}}</text>
			</view>
		</view>
		<view class="find-bottom">
			<view class="home-myInfo-content" v-for="(item,index) in infoLists" :key="index" @click="handleInfoDetail(item)">
				<image :src="item.fi_src" mode=""></image>
				<view class="hmc-content">
					<view class="hmcc-top">
						<text class="hmcct-title">{{item.fi_name}}</text>
						<text>{{item.fi_time}}</text>
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
				findList: [],
				user: [],
				infoLists: [],
				infoNum: 0,
				seeNum: 0
			};
		},
		onShow() {
			let that = this
			uni.request({
				url: 'http://localhost:3000/find',
				success: (res) => {
					that.findList = res.data.data
				}
			});
			uni.getStorage({
				key: 'user_login',
				success(res) {
					if (res.data.admin_id > 0) {
						that.user.user_id = 0
					} else {
						that.user = res.data
						uni.request({
							url: 'http://localhost:3000/find/info',
							data: {
								userId: that.user.user_id
							},
							success: (res) => {
								let all = res.data.data
								that.infoLists = all.filter(function(item) {
									return item.fi_status == "未读" && item.fi_type == "通知信息"
								})
								that.infoNum = that.infoLists.length
								let aaa = all.filter(function(item) {
									return item.fi_status == "已读" && item.fi_type == "通知信息"
								})
								that.seeNum = aaa.length
							}
						});
					}
				},
				fail() {
					uni.navigateTo({
						url: '../signIn/signIn'
					});
				}
			})
		},
		methods: {
			handleBrowse() {
				uni.navigateTo({
					url: '../find-browse/find-browse'
				})
			},
			handleInfo() {
				uni.navigateTo({
					url: '../find-info/find-info'
				})
			},
			handleShare() {
				uni.showToast({
					icon: 'none',
					title: '暂时不能查看分享',
					duration: 1000
				})
			},
			handleF(item) {
				uni.navigateTo({
					url: '../find-class-info/find-class-info?id=' + item.find_id
				})
			},
			handleInfoDetail(item) {
				let that = this
				let crtTime = new Date()
				let nowTime = that.dateFtt("yyyy-MM-dd hh:mm:ss", crtTime)
				uni.request({
					url: 'http://localhost:3000/del/find/info',
					data: {
						fiId: item.fi_id,
						fiStatus: "已读",
						fiPerson: item.fi_person + 1,
						fiSTime: nowTime
					},
					success: (res) => {
						that.infoNum -= 1
						that.seeNum += 1
						that.infoLists = that.infoLists.filter(function(i) {
							return i.fi_id != item.fi_id
						})
						uni.navigateTo({
							url: '../home-info-detail/home-info-detail?id=' + item.fi_id
						})
					}
				});
			},
			dateFtt(fmt, date) {
				let newDate = {
					"M+": date.getMonth() + 1, //月份 
					"d+": date.getDate(), //日 
					"h+": date.getHours(), //小时 
					"m+": date.getMinutes(), //分 
					"s+": date.getSeconds(), //秒 
				};
				if (/(y+)/.test(fmt))
					fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
				for (let k in newDate)
					if (new RegExp("(" + k + ")").test(fmt))
						fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (newDate[k]) : (("00" + newDate[k]).substr(("" + newDate[k])
							.length)));
				return fmt;
			}
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
		// background: #efefef;
	}

	.find {
		// background: #efefef;

		.find-head {
			padding: 30upx;
			background: #67c23a;
			color: #fff;

			.my-head-top {
				font-size: 60upx;
			}

			.my-head-bottom {
				display: flex;
				justify-content: space-evenly;

				.mhb-list {
					padding: 45upx 30upx 0 30upx;
					display: flex;
					flex-direction: column;
					justify-content: space-around;
					align-items: center;

					text {
						padding: 0 0 15upx 0;
					}
				}
			}
		}

		.find-content {
			padding: 0 30upx 30upx;
			display: flex;
			// justify-content: space-between;
			flex-wrap: wrap;
			background: #fff;

			.fc-list {
				width: 25%;
				padding-top: 30upx;
				display: flex;
				flex-direction: column;
				justify-content: center;
				align-items: center;

				image {
					width: 120upx;
					height: 120upx;
				}

				text {
					font-size: 30upx;
					padding-top: 10upx;
				}
			}
		}

		.find-bottom {
			margin-bottom: 120upx;

			.home-myInfo-content {
				padding: 40upx;
				border-top: 1upx solid #666;
				display: flex;
				justify-content: space-between;
				align-items: center;

				image {
					width: 160upx;
					height: 160upx;
				}

				.hmc-content {
					height: 160upx;
					flex: 1;
					padding-left: 40upx;
					font-size: 32upx;
					color: #666;
					display: flex;
					flex-direction: column;
					justify-content: space-between;

					.hmcc-top {
						height: 100%;
						display: flex;
						flex-direction: column;
						justify-content: space-between;
						// align-items: center;
						padding: 0 0 10upx 0;

						.hmcct-title {
							font-size: 40upx;
							color: #000;
						}
					}
				}
			}
		}
	}
</style>
