<template>
	<view class="my-integral">
		<view class="mi-top">
			<view class="mit-title">
				<image src="../../static/my-img/integral.png" mode=""></image>
				<text>{{integral}}</text>
			</view>
			<view class="mit-text">
				<text>当前剩余可用积分</text>
				<text @click="handleSign">{{isSign}}</text>
			</view>
		</view>
		<view class="mi-content">
			<text>积分明细</text>
			<view class="mic-tab">
				<home-tab id="tabbar" :values="items" :stickyTop="108" :current="current" @clickItem="onClickItem"></home-tab>
			</view>
			<view class="mic-tab-content">
				<view class="mictc-list" v-if="current == 0">
					<view class="mictcl-content" v-for="(item,index) in integralList" :key="index">
						<myIntegralAll :lists="item"></myIntegralAll>
					</view>
					<text>暂无更多数据</text>
				</view>
				<view class="mictc-list" v-else-if="current == 1">
					<view class="mictcl-content" v-for="(item,index) in integralGet" :key="index">
						<view class="mictclc-left">
							<text>{{item.i_name}}</text>
							<text class="mictclcl-time">{{item.i_time}}</text>
						</view>
						<view class="mictclc-right">
							+{{item.i_num}}
						</view>
					</view>
					<text>暂无更多数据</text>
				</view>
				<view class="mictc-list" v-else-if="current == 2">
					<view class="mictcl-content" v-for="(item,index) in integralPay" :key="index">
						<view class="mictclc-left">
							<text>{{item.i_name}}</text>
							<text class="mictclcl-time">{{item.i_time}}</text>
						</view>
						<view class="mictclc-right">
							-{{item.i_num}}
						</view>
					</view>
					<text>暂无更多数据</text>
				</view>
				<view class="mictc-list" v-else>
					<view class="mictcl-content" v-for="(item,index) in integralOut" :key="index">
						<view class="mictclc-left">
							<text>{{item.i_name}}</text>
							<text class="mictclcl-time">{{item.i_time}}</text>
						</view>
						<view class="mictclc-right">
							-{{item.i_num}}
						</view>
					</view>
					<text>暂无更多数据</text>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	import homeTab from '../../components/home-tab.vue';
	import myIntegralAll from '../../components/my-integral-all.vue'
	export default {
		components: {
			homeTab,
			myIntegralAll
		},
		data() {
			return {
				items: ["全部", "收入", "支出", "过期"],
				current: 0,
				integralGet: [],
				integralPay: [],
				integralOut: [],
				integralList: [],
				isSign: "签到"
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
				url: 'http://localhost:3000/my/integral',
				data: {
					userId: that.user.user_id
				},
				success: (res) => {
					// 获取用户积分
					that.integralList = res.data.data
					// 按时间排序
					that.integralList = that.integralList.sort(function(a, b) {
						let x = a.i_time.toLowerCase();
						let y = b.i_time.toLowerCase();
						if (x < y) {
							return 1;
						}
						if (x > y) {
							return -1;
						}
						return 0;
					})

					// 当前时间格式转换
					let crtTime = new Date()
					let nowTime = that.dateFtt("yyyy-MM-dd hh:mm:ss", crtTime)
					// 上一次签到时间
					if(that.integralList.length > 0){
						let lastTime = that.integralList.filter(function(item) {
							return item.i_id == 1
						})
						// 签到日期比较
						let nowDate = nowTime.substr(0, 10)
						let lastDate = lastTime[0].i_time.substr(0, 10)
						if (lastDate == nowDate) {
							this.isSign = "已签到"
						} else {
							this.isSign = "签到"
						}
					}
				}
			});
		},
		computed: {
			integral() {
				let that = this
				let negative = 0
				let right = 0
				that.integralList.forEach(function(item) {
					if (item.i_id == 1) {
						return right += item.i_num
					} else {
						return negative += item.i_num
					}
				})
				return right - negative
			}
		},
		methods: {
			onClickItem(index) { //选项卡
				if (this.current !== index) {
					this.current = index;
					if (index == 1) {
						this.integralGet = this.integralList.filter(function(item) {
							return item.i_id == 1
						})
					}
					if (index == 2) {
						this.integralPay = this.integralList.filter(function(item) {
							return item.i_id == 3
						})
					}
					if (index == 3) {
						this.integralOut = this.integralList.filter(function(item) {
							return item.i_id == 2
						})
					}
				}
			},
			handleSign() {
				let that = this
				// 当前时间格式转换
				let crtTime = new Date()
				let nowTime = that.dateFtt("yyyy-MM-dd hh:mm:ss", crtTime)
				uni.request({
					url: 'http://localhost:3000/add/my/integral',
					data: {
						userId: that.user.user_id,
						integralId: 1,
						integralName: "签到赠送积分",
						integralNum: 10,
						integralTime: nowTime
					},
					success: (res) => {
						that.isSign = "已签到"
						// that.integral += 10
						that.integralList.unshift({
							i_name: "签到赠送积分",
							i_num: 10,
							i_id: 1,
							i_time: nowTime
						})
					}
				})
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
		background: linear-gradient(to bottom, #efefef, #fff);
	}

	.my-integral {
		.mi-top {
			display: flex;
			flex-direction: column;
			align-items: center;
			justify-content: center;
			background: #67c23a;
			padding: 60upx 0 120upx;

			.mit-title {
				display: flex;
				align-items: center;
				color: #fff;
				font-size: 90upx;
				padding-bottom: 30upx;

				image {
					width: 90upx;
					height: 90upx;
					margin-right: 30upx;
				}
			}

			.mit-text {
				width: 75%;
				display: flex;
				align-items: center;
				justify-content: space-between;

				text {
					display: block;
					padding: 15upx 30upx;
					border: 1upx solid #fff;
					border-radius: 45upx;
					color: #fff;
				}
			}
		}

		.mi-content {
			width: 95%;
			background: #fff;
			margin: -60upx auto 0;
			border-radius: 30upx;
			padding-bottom: 30upx;

			>text {
				display: block;
				padding: 30upx 0 0 30upx;
			}

			.mic-tab {
				/deep/ .home-tab-control {
					.home-tab-control-item {
						width: 25%;
						text-align: center;
					}
				}
			}
		}

		.mic-tab-content {
			.mictc-list {
				>text {
					display: block;
					padding: 30upx 0 0 30upx;
					text-align: center;
					color: #666;
				}

				.mictcl-content {
					padding: 30upx;
					border-bottom: 1upx solid #efefef;
					display: flex;
					justify-content: space-between;
					align-items: center;

					.mictclc-left {
						display: flex;
						flex-direction: column;

						.mictclcl-time {
							color: #666;
							padding-top: 15upx;
						}
					}

					.mictclc-right {
						color: #f00;
					}
				}
			}
		}
	}
</style>
