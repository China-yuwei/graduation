<template>
	<view class="my-envelope-balance">
		<uni-nav-bar class="meb-nav" left-icon="back" right-text="支出明细" title="我的红包" :fixed="true" background-color="#67C23A"
		 color="#fff" @clickLeft="handleBack" @clickRight="handleItemized">
		</uni-nav-bar>
		<view class="mebi-top">
			<image :src="user.user_headImg" mode=""></image>
			<text>{{user.user_name}}的红包余额</text>
			<text class="mebit-total">{{totalMoney}}</text>
			<text class="mebit-get" @click="handleGet">领取今日红包</text>
			<view class="mebi-top-content">
				<view class="mebitc-left">
					<text class="mebitcl-num">{{totalMoney}}</text>
					<text>红包总额</text>
				</view>
				<view class="mebitc-left">
					<text class="mebitcl-num">{{totalNum}}</text>
					<text>红包个数</text>
				</view>
			</view>
		</view>
		<view class="mebi-content">
			<view class="mebi-content-list" v-if="isHave">
				<view class="mebicl-content" v-for="(item,index) in envelopeListsIn" :key="index">
					<view class="mebicl-content-left">
						<text>{{item.e_name}}</text>
						<text class="mebiclcl-title">{{item.e_time}}</text>
					</view>
					<text>{{item.e_money}}元</text>
				</view>
			</view>
			<view class="mebi-content-else" v-else>
				<image src="../../static/home-img/zanwushuju.png" mode=""></image>
				<view>暂无数据</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				headImg: "../../static/my-img/my-head.png",
				isHave: true,
				envelopeListsIn: [],
				envelopeListsOut: [],
				user: []
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
				url: 'http://localhost:3000/my/envelope',
				data: {
					userId: that.user.user_id
				},
				success: (res) => {
					let aaa = res.data.data
					that.envelopeListsIn = aaa.filter(function(item) {
						return item.e_type == "1"
					})
					that.envelopeListsOut = aaa.filter(function(item) {
						return item.e_type == "0"
					})
					that.envelopeListsIn = that.envelopeListsIn.sort(function(a, b) {
						let x = a.e_time.toLowerCase();
						let y = b.e_time.toLowerCase();
						if (x < y) {
							return 1;
						}
						if (x > y) {
							return -1;
						}
						return 0;
					})
					if (that.envelopeListsIn.length > 0) {
						that.isHave = true
					} else {
						that.isHave = false
					}
				}
			});
		},
		computed: {
			totalNum() {
				if (this.envelopeListsIn) {
					return this.envelopeListsIn.length
				} else {
					return 0
				}
			},
			totalMoney() {
				let total = 0
				let totalIn = 0
				let totalOut = 0
				this.envelopeListsIn.forEach(function(item) {
					let eMoneyIn = Number(item.e_money)
					totalIn = totalIn + eMoneyIn
				})
				this.envelopeListsOut.forEach(function(item) {
					let eMoneyOut = Number(item.e_money)
					totalOut = totalOut + eMoneyOut
				})
				total = (totalIn * 100 - totalOut * 100) / 100
				return total.toFixed(2)
			}
		},
		methods: {
			handleBack() {
				uni.navigateBack()
			},
			handleItemized() {
				uni.navigateTo({
					url: '../my-envelope-balance-itemized/my-envelope-balance-itemized'
				})
			},
			handleGet() {
				let that = this
				// 当前时间格式转换
				let crtTime = new Date()
				let nowTime = that.dateFtt("yyyy-MM-dd hh:mm:ss", crtTime)
				let M = ((Math.floor(Math.random() * 100)) / 100).toFixed(2)
				if (that.envelopeListsIn.length > 0) {
					// 领取日期比较
					let lastDate = that.envelopeListsIn[0].e_time.substr(0, 10)
					let nowDate = nowTime.substr(0, 10)
					if (lastDate == nowDate) {
						uni.showToast({
							title: "今日已领取，请明天再来",
							icon: 'none',
							duration: 1000
						})
					} else {
						uni.request({
							url: 'http://localhost:3000/add/my/envelope',
							data: {
								userId: that.user.user_id,
								envelopeType: 1,
								envelopeName: "每日领取红包",
								envelopeNum: M,
								envelopeTime: nowTime
							},
							success: (res) => {
								that.isHave = true
								that.envelopeListsIn.unshift({
									e_name: "每日领取红包",
									e_money: M,
									e_type: 1,
									e_time: nowTime
								})
							}
						})
					}
				} else {
					uni.request({
						url: 'http://localhost:3000/add/my/envelope',
						data: {
							userId: that.user.user_id,
							envelopeType: 1,
							envelopeName: "每日领取红包",
							envelopeNum: M,
							envelopeTime: nowTime
						},
						success: (res) => {
							that.isHave = true
							that.envelopeListsIn.unshift({
								e_name: "每日领取红包",
								e_money: M,
								e_type: 1,
								e_time: nowTime
							})
						}
					})
				}
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
		background: #efefef;
	}

	.my-envelope-balance {
		.meb-nav {
			/deep/ .uni-navbar--fixed {
				width: 100%;
			}
		}

		.mebi-top {
			padding: 30upx 30upx 60upx;
			background: #67C23A;
			display: flex;
			flex-direction: column;
			align-items: center;
			color: #fff;

			image {
				width: 120upx;
				height: 120upx;
				border-radius: 15upx;
				padding-bottom: 30upx;
			}

			.mebit-total {
				font-size: 80upx;
				padding: 30upx 0;
			}

			.mebit-get {
				border: 1upx solid #fff;
				padding: 10upx 30upx;
				border-radius: 30upx;
			}

			.mebi-top-content {
				width: 100%;
				display: flex;
				justify-content: space-around;
				align-items: center;

				.mebitc-left {
					display: flex;
					flex-direction: column;
					align-items: center;

					.mebitcl-num {
						font-size: 60upx;
					}
				}
			}
		}

		.mebi-content {
			width: 95%;
			margin: -30upx auto;
			background: #fff;
			border-radius: 15upx;

			.mebi-content-list {
				padding: 0 30upx;

				.mebicl-content {
					display: flex;
					justify-content: space-between;
					align-items: center;
					border-bottom: 1upx solid #efefef;
					padding: 20upx 0;

					.mebicl-content-left {
						display: flex;
						flex-direction: column;

						.mebiclcl-title {
							padding-top: 20upx;
							color: #666;
							font-size: 28upx;
						}
					}
				}
			}

			.mebi-content-else {
				padding: 30upx 0;
				text-align: center;

				image {
					width: 120upx;
					height: 120upx;
				}
			}
		}
	}
</style>
