<!-- 首页-消息 -->
<template>
	<view class="home-myInfo">
		<view class="home-myInfo-head">
			<text>消息</text>
			<view class="home-myInfo-head-title">
				<view class="hmht-left">
					<text>{{num}} 条未读</text>
				</view>
				<view class="hmht-left" @click="handleClean">
					<view class="hmhtl-image">
						<image src="../../static/home-img/clean.png" mode=""></image>
					</view>
					<text>清除未读</text>
				</view>
			</view>
			<view class="home-myInfo-class">
				<view class="hmc-name" @click="handleLogistics">
					<view class="hmcn-logistics">
						<image src="../../static/home-img/wuliu.png" mode=""></image>
					</view>
					<text>交易物流</text>
				</view>
				<view class="hmc-name" @click="handleNotice">
					<view class="hmcn-notice">
						<image src="../../static/home-img/tongzhi.png" mode=""></image>
					</view>
					<text>通知信息</text>
				</view>
			</view>
		</view>
		<view class="home-myInfo-content" v-for="(item,index) in infoLists" :key="index" @click="handleInfo(item)">
			<image :src="item.fi_src" mode=""></image>
			<view class="hmc-content">
				<view class="hmcc-top">
					<text class="hmcct-title">{{item.fi_name}}</text>
					<text>{{item.fi_time}}</text>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				num: 0, //未读消息数
				user: [],
				allInfo: [],
				infoLists: []
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
				url: 'http://localhost:3000/find/info',
				data: {
					userId: that.user.user_id
				},
				success: (res) => {
					that.allInfo = res.data.data
					that.infoLists = that.allInfo.filter(function(item) {
						return item.fi_status == "未读"
					})
					that.num = that.infoLists.length
				}
			});
		},
		methods: {
			handleClean() { //清除未读
				let that = this
				for (let i = 0; i < that.infoLists.length; i++) {
					uni.request({
						url: 'http://localhost:3000/del/find/info',
						data: {
							fiId: that.infoLists[i].fi_id,
							fiStatus: "已读",
							fiPerson: that.infoLists[i].fi_person
						},
						success: (res) => {
							that.num = 0
							that.infoLists = []
						}
					});
				}
			},
			handleInfo(item) { //读取消息
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
						that.num -= 1
						that.infoLists = that.infoLists.filter(function(i) {
							return i.fi_id != item.fi_id
						})
					}
				});
				if (item.fi_type == "通知信息") {
					uni.navigateTo({
						url: '../home-info-detail/home-info-detail?id=' + item.fi_id
					})
				} else {
					uni.navigateTo({
						url: '../shopping-car-order-detail/shopping-car-order-detail?id=' + item.o_id
					})
				}
			},
			handleLogistics() { //交易物流
				uni.navigateTo({
					url: '../home-info-logistics/home-info-logistics'
				});
			},
			handleNotice() { //通知
				uni.navigateTo({
					url: '../home-info-notice/home-info-notice'
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
	.home-myInfo {
		.home-myInfo-head {
			background: #67c23a;
			padding: 60upx 20upx 160upx 20upx;
			position: relative;
			margin-bottom: calc(20%);
			color: #fff;

			>text {
				font-size: 60upx;
			}

			.home-myInfo-head-title {
				display: flex;
				align-items: center;
				padding: 16upx 0;

				.hmht-left {
					display: flex;
					align-items: center;

					.hmhtl-image {
						padding: 8upx;
						background: #67c23a;
						margin: 0 10upx 0 40upx;
						border-radius: 60%;

						image {
							width: 40upx;
							height: 40upx;
						}
					}
				}
			}
		}

		.home-myInfo-class {
			position: absolute;
			width: 90%;
			left: 50%;
			top: 50%;
			transform: translate(-50%, 30%);
			padding: 20upx 0;
			background: #fff;
			border-radius: 20upx;
			box-shadow: 0 10upx 20upx -10upx #000;
			display: flex;
			justify-content: space-around;

			.hmc-name {
				display: flex;
				flex-direction: column;
				justify-content: center;
				align-items: center;

				text {
					margin: 20upx 0 0;
					color: #000;
				}

				.hmcn-logistics {
					background: #67c23a;
					border-radius: 60%;
					padding: 20upx;

					image {
						width: 80upx;
						height: 80upx;
					}
				}

				.hmcn-notice {
					background: #67c23a;
					border-radius: 60%;
					padding: 20upx;

					image {
						width: 80upx;
						height: 80upx;
					}
				}
			}
		}

		.home-myInfo-content {
			padding: 40upx;
			border-bottom: 1upx solid #666;
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
</style>
