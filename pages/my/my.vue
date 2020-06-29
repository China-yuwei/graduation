<template>
	<view class="my">
		<view class="my-my" v-if="isUser">
			<view class="my-head">
				<view class="my-head-top">
					<view class="my-head-left">
						<image :src="user.user_headImg" mode="" @click="handleMyHead"></image>
						<view class="my-head-user">
							<text class="my-head-username">{{user.user_name}}</text>
							<text>{{user.user_type}}</text>
						</view>
					</view>
					<view class="my-head-right">
						<view class="my-head-set" @click="handleSet">
							<image src="../../static/my-img/set.png" mode=""></image>
							<text>设置</text>
						</view>
						<view class="my-head-set" @click="handleContact">
							<image src="../../static/my-img/contact.png" mode=""></image>
							<text>联系客服</text>
						</view>
					</view>
				</view>
				<view class="my-head-bottom">
					<view class="mhb-list" @click="handleMyFavorites">
						<text>{{favorityNum}}</text>
						<text>收藏</text>
					</view>
					<view class="mhb-list" @click="handleMyFollow">
						<text>{{followNum}}</text>
						<text>关注</text>
					</view>
					<view class="mhb-list" @click="handleMyFootprint">
						<text>{{footprintNum}}</text>
						<text>足迹</text>
					</view>
					<view class="mhb-list" @click="handleMyIntegral">
						<text>{{integralNum}}</text>
						<text>积分</text>
					</view>
				</view>
				<view class="my-head-recommend">
					<view class="my-head-recommend-content" @click="handleMyIntegral">
						<image src="../../static/my-img/intergral.png" mode=""></image>
						<view class="mhrc-text">
							<text>玩转积分</text>
							<text class="mhrc-text-color">积分商城兑换</text>
						</view>
					</view>
					<view class="my-head-recommend-line"></view>
					<view class="my-head-recommend-content" @click="handleMyEnvelopes">
						<image src="../../static/my-img/hongbao.png" mode=""></image>
						<view class="mhrc-text">
							<text>每日红包</text>
							<text class="mhrc-text-color">立即领取现金</text>
						</view>
					</view>
				</view>
			</view>
			<view class="my-content">
				<view class="my-order">
					<view class="my-order-title">
						<text>我的订单</text>
						<view class="my-order-title-seeAll" @click="handleSeeAllOrder">
							<text>查看全部订单</text>
							<image src="../../static/my-img/youjiantou.png" mode=""></image>
						</view>
					</view>
					<view class="my-order-content">
						<view class="moc-list" v-for="(item,index) in myOrderLists" :key="index" @click="handleMyOrder(index)">
							<image :src="item.myOrderListsSrc" mode=""></image>
							<text>{{item.myOrderListsName}}</text>
						</view>
					</view>
				</view>
				<view class="my-tool">
					<text>我的工具箱</text>
					<view class="my-tool-content">
						<view class="mtc-list" v-for="(item,index) in myToolList" :key="index" @click="handleMyTool(index)">
							<image :style="item.tool_background" :src="item.tool_src" mode=""></image>
							<text>{{item.tool_name}}</text>
						</view>
					</view>
				</view>
				<view class="my-boutique" v-for="(item,index) in myContentList" :key="index" @click="handleMy(index)">
					<view class="my-boutique-title">
						<view class="my-boutique-title-left">
							<image :src="item.my_icon" :style="item.my_icon_bg" mode=""></image>
							<text>{{item.my_name}}</text>
							<text class="mbtl-recommend" :style="item.my_color">推荐</text>
						</view>
						<view class="my-boutique-title-right">
							<text>{{item.my_title}}</text>
							<image src="../../static/my-img/youjiantou.png" mode=""></image>
						</view>
					</view>
					<view class="my-boutique-content">
						<view class="mbc-left">
							<image :src="item.my_src01" mode=""></image>
							<text :style="item.my_text">{{item.my_in}}</text>
						</view>
						<view class="mbc-right">
							<image :src="item.my_src02" mode=""></image>
							<image :src="item.my_src03" mode=""></image>
							<image :src="item.my_src04" mode=""></image>
							<image :src="item.my_src05" mode=""></image>
						</view>
					</view>
				</view>
			</view>
		</view>
		<view class="admin" v-else>
			<view class="admin-head">
				<text>{{admin.admin_name}}</text>
				<image src="../../static/admin-img/tuichu.png" mode="" @click="handleQuit"></image>
			</view>
			<view class="admin-content">
				<view class="admin-tool">
					<view class="at-title">工具箱</view>
					<view class="at-content">
						<view class="atc-list" v-for="(item,index) in adminToolList" :key="index" @click="handleAdminTool(index)">
							<image :style="item.at_background" :src="item.at_icon" mode=""></image>
							<text>{{item.at_name}}</text>
						</view>
					</view>
				</view>
				<view class="admin-order">
					<view class="ao-title">数据统计</view>
					<view class="ao-content">
						<view class="aoc-list">
							<text>{{adminAllOrder}}</text>
							<text>全部订单</text>
						</view>
						<view class="aoc-list">
							<text>{{adminWaitPay}}</text>
							<text>待付款</text>
						</view>
						<view class="aoc-list">
							<text>{{adminWaitSend}}</text>
							<text>待发货</text>
						</view>
						<view class="aoc-list">
							<text>{{adminWaitGet}}</text>
							<text>待收货</text>
						</view>
						<view class="aoc-list">
							<text>{{adminWaitAppraisals}}</text>
							<text>待评价</text>
						</view>
						<view class="aoc-list">
							<text>{{adminHasOver}}</text>
							<text>已完成</text>
						</view>
						<view class="aoc-list">
							<text>{{adminHasOut}}</text>
							<text>已关闭</text>
						</view>
						<view class="aoc-list">
							<text>{{adminBackChange}}</text>
							<text>退换</text>
						</view>
					</view>
					<view class="ao-c-m">
						<view class="aoc-list">
							<text>{{adminOrderNum}}</text>
							<text>成交数</text>
						</view>
						<view class="aoc-list">
							<text>{{adminOrderNumM}}</text>
							<text>本月成交数</text>
						</view>
						<view class="aoc-list">
							<text>{{adminOrderNumToday}}</text>
							<text>今日成交数</text>
						</view>
						<view class="aoc-list">
							<text>{{adminOrderMoney}}</text>
							<text>成交额</text>
						</view>
						<view class="aoc-list">
							<text>{{adminOrderMoneyM}}</text>
							<text>本月成交额</text>
						</view>
						<view class="aoc-list">
							<text>{{adminOrderMoneyToday}}</text>
							<text>今日成交额</text>
						</view>
					</view>
				</view>
			</view>
			<uni-popup ref="adminPopup" type="center">
				<view class="popup-sure">
					<text>确定退出登录吗？</text>
					<button @click="handleAdminConfirm">确定</button>
				</view>
				<button @click="handleAdminCancle">取消</button>
			</uni-popup>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				isUser: true,
				myOrderLists: [{ //我的订单列表
					myOrderListsSrc: "../../static/my-img/moban.png",
					myOrderListsName: "待付款"
				}, {
					myOrderListsSrc: "../../static/my-img/daifahuo.png",
					myOrderListsName: "待发货"
				}, {
					myOrderListsSrc: "../../static/my-img/daishouhuo.png",
					myOrderListsName: "待收货"
				}, {
					myOrderListsSrc: "../../static/my-img/pingjia-tianchong.png",
					myOrderListsName: "待评价"
				}, {
					myOrderListsSrc: "../../static/my-img/shouhoufuwuicon.png",
					myOrderListsName: "已成功"
				}],
				user: [],
				admin: [],
				myToolList: [], //我的工具箱
				myContentList: [],
				favorityNum: 0,
				followNum: 0,
				footprintNum: 0,
				integralNum: 0,
				adminToolList:[],
				adminAllOrder: 0,
				adminWaitPay: 0,
				adminWaitSend: 0,
				adminWaitGet: 0,
				adminWaitAppraisals: 0,
				adminHasOver: 0,
				adminHasOut: 0,
				adminBackChange: 0,
				adminOrderNum: 0,
				adminOrderNumM: 0,
				adminOrderNumToday: 0,
				adminOrderMoney: 0,
				adminOrderMoneyM: 0,
				adminOrderMoneyToday: 0,
			};
		},
		onShow() {
			let that = this
			uni.getStorage({
				key: 'user_login',
				success(res) {
					if (res.data.admin_id > 0) {
						that.isUser = false
						that.admin = res.data
						uni.request({
							url: 'http://localhost:3000/admin/tool',
							success: (res) => {
								that.adminToolList = res.data.data
							}
						});
						uni.request({
							url: 'http://localhost:3000/admin/order',
							success: (res) => {
								let getAllOrder = res.data.data
								that.adminAllOrder = getAllOrder.length
								that.adminWaitPay = getAllOrder.filter(function(item){
									return item.o_type == "待付款"
								}).length
								that.adminWaitSend = getAllOrder.filter(function(item){
									return item.o_type == "待发货"
								}).length
								that.adminWaitGet = getAllOrder.filter(function(item){
									return item.o_type == "待收货"
								}).length
								that.adminWaitAppraisals = getAllOrder.filter(function(item){
									return item.o_type == "待评价"
								}).length
								that.adminHasOver = getAllOrder.filter(function(item){
									return item.o_type == "已完成"
								}).length
								that.adminHasOut = getAllOrder.filter(function(item){
									return item.o_type == "已关闭"
								}).length
								that.adminBackChange = getAllOrder.filter(function(item){
									return item.o_type == "已关闭"
								}).length
								that.adminOrderNum = 0
								that.adminOrderMoney = 0
								getAllOrder.forEach(function(item){
									that.adminOrderNum = item.g_num + that.adminOrderNum
								})
								getAllOrder.forEach(function(item){
									that.adminOrderMoney = item.g_num*item.g_price + that.adminOrderMoney
								})
								that.adminOrderNumM = 0
								that.adminOrderNumToday = 0
								that.adminOrderMoneyM = 0
								that.adminOrderMoneyToday = 0
								let crtTime = new Date()
								let nowDay = that.dateFtt("yyyy-MM-dd", crtTime)
								let nowMonth = that.dateFtt("yyyy-MM", crtTime)
								let M = getAllOrder.filter(function(item) {
									return item.o_time.substr(0, 7) == nowMonth
								})
								M.forEach(function(item){
									that.adminOrderNumM = item.g_num + that.adminOrderNumM
								})
								M.forEach(function(item){
									that.adminOrderMoneyM = item.g_num*item.g_price + that.adminOrderMoneyM
								})
								let D = getAllOrder.filter(function(item) {
									return item.o_time.substr(0, 10) == nowDay
								})
								D.forEach(function(item){
									that.adminOrderNumToday = item.g_num + that.adminOrderNumToday
								})
								D.forEach(function(item){
									that.adminOrderMoneyToday = item.g_num*item.g_price + that.adminOrderMoneyToday
								})
							}
						});
					} else {
						that.isUser = true
						that.user = res.data
						uni.request({
							url: 'http://localhost:3000/my/favorites',
							data: {
								userId: that.user.user_id
							},
							success: (res) => {
								let favorityLists = res.data.data
								that.favorityNum = favorityLists.length
							}
						});
						uni.request({
							url: 'http://localhost:3000/my/follow',
							data: {
								userId: that.user.user_id
							},
							success: (res) => {
								let followLists = res.data.data
								that.followNum = followLists.length
							}
						});
						uni.request({
							url: 'http://localhost:3000/my/footprint',
							data: {
								userId: that.user.user_id
							},
							success: (res) => {
								let footprintList = res.data.data
								that.footprintNum = footprintList.length
							}
						});
						uni.request({
							url: 'http://localhost:3000/my/integral',
							data: {
								userId: that.user.user_id
							},
							success: (res) => {
								let integralList = res.data.data
								let negative = 0
								let right = 0
								integralList.forEach(function(item) {
									if (item.i_id == 1) {
										right += item.i_num
									} else {
										negative += item.i_num
									}
								})
								that.integralNum = right - negative
							}
						});
						uni.request({
							url: 'http://localhost:3000/my/tool',
							success: (res) => {
								that.myToolList = res.data.data
							}
						});
						uni.request({
							url: 'http://localhost:3000/my/content',
							success: (res) => {
								that.myContentList = res.data.data
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
			handleMyHead() { //个人信息
				uni.navigateTo({
					url: '../my-info/my-info'
				});
			},
			handleSet() { //设置
				uni.navigateTo({
					url: '../my-set/my-set'
				});
			},
			handleContact() { //联系客服
				uni.navigateTo({
					url: '../my-contact-customer-service/my-contact-customer-service'
				});
			},
			handleMyFavorites() { //我的收藏夹
				uni.navigateTo({
					url: '../my-favorites/my-favorites'
				});
			},
			handleMyFollow() { //我的关注
				uni.navigateTo({
					url: '../my-follow/my-follow'
				});
			},
			handleMyFootprint() { //我的足迹
				uni.navigateTo({
					url: '../my-footprint/my-footprint'
				});
			},
			handleMyIntegral() { //我的积分
				uni.navigateTo({
					url: '../my-integral/my-integral'
				});
			},
			handleMyEnvelopes() { //我的红包
				uni.navigateTo({
					url: '../my-envelope-balance/my-envelope-balance'
				});
			},
			handleSeeAllOrder() { //查看全部订单
				uni.navigateTo({
					url: '../my-order/my-order?orderName=' + "全部"
				});
			},
			handleMyOrder(index) { //我的订单
				uni.navigateTo({
					url: '../my-order/my-order?orderName=' + this.myOrderLists[index].myOrderListsName
				});
			},
			handleMyTool(index) { //我的工具箱
				switch (index) {
					case 0:
						uni.navigateTo({
							url: '../my-favorites/my-favorites'
						});
						break;
					case 1:
						uni.navigateTo({
							url: '../my-evaluate/my-evaluate'
						});
						break;
					case 2:
						uni.navigateTo({
							url: '../my-info/my-info'
						});
						break;
					case 3:
						uni.navigateTo({
							url: '../my-follow/my-follow'
						});
						break;
					case 4:
						uni.navigateTo({
							url: '../my-envelope-balance/my-envelope-balance'
						});
						break;
					case 5:
						uni.navigateTo({
							url: '../my-sharing/my-sharing'
						});
						break;
					case 6:
						uni.navigateTo({
							url: '../my-set-address/my-set-address'
						});
						break;
					case 7:
						uni.navigateTo({
							url: '../my-coupon/my-coupon'
						});
						break;
					default:
						break;
				}
			},
			handleMy(index) {
				switch (index) {
					case 0:
						uni.navigateTo({
							url: '../my-boutique/my-boutique'
						});
						break;
					case 1:
						uni.navigateTo({
							url: '../my-flash-sale/my-flash-sale'
						});
						break;
					case 2:
						uni.navigateTo({
							url: '../my-special-sale/my-special-sale'
						});
						break;
					case 3:
						uni.navigateTo({
							url: '../my-shops/my-shops'
						});
						break;
					case 4:
						uni.navigateTo({
							url: '../my-tea/my-tea'
						});
						break;
					case 5:
						uni.navigateTo({
							url: '../home-team-buy/home-team-buy'
						});
						break;
					default:
						break;
				}
			},
			handleAdminTool(index) { //管理员
				switch (index) {
					case 0:
						uni.navigateTo({
							url: '../admin-goods/admin-goods'
						});
						break;
					case 1:
						uni.navigateTo({
							url: '../admin-shops/admin-shops'
						});
						break;
					case 2:
						uni.navigateTo({
							url: '../admin-order/admin-order'
						});
						break;
					case 3:
						uni.navigateTo({
							url: '../admin-user/admin-user'
						});
						break;
					case 4:
						uni.navigateTo({
							url: '../admin-find/admin-find'
						});
						break;
					case 5:
						uni.navigateTo({
							url: '../admin-shops-add/admin-shops-add'
						});
						break;
					case 6:
						uni.navigateTo({
							url: '../admin-find-add/admin-find-add'
						});
						break;
					case 7:
						uni.navigateTo({
							url: '../admin-goods-add/admin-goods-add'
						});
						break;
					default:
						break;
				}
			},
			handleQuit(){
				this.$refs.adminPopup.open()
			},
			handleAdminConfirm() {
				this.$refs.adminPopup.close()
				uni.removeStorage({
					key: 'user_login'
				});
				uni.switchTab({
					url: '../home/home'
				});
			},
			handleAdminCancle() {
				this.$refs.adminPopup.close()
			},
			getDay(day) {
				let today = new Date();
				let targetday_milliseconds = today.getTime() + 1000 * 60 * 60 * 24 * day;
				today.setTime(targetday_milliseconds); //注意，这行是关键代码
				let tYear = today.getFullYear();
				let tMonth = today.getMonth();
				let tDate = today.getDate();
				tMonth = this.doHandleMonth(tMonth + 1);
				tDate = this.doHandleMonth(tDate);
				return tYear + "-" + tMonth + "-" + tDate;
			},
			doHandleMonth(month) {
				let m = month;
				if (month.toString().length == 1) {
					m = "0" + month;
				}
				return m;
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

	.my {
		background: #efefef;

		.my-head {
			padding: 30upx 30upx 60upx;
			position: relative;
			margin-bottom: 140upx;

			.my-head-top {
				display: flex;
				justify-content: space-between;
				margin-bottom: 20upx;

				.my-head-left {
					display: flex;
					align-items: center;

					image {
						border-radius: 60%;
						width: 120upx;
						height: 120upx;
						margin-right: 30upx;
					}

					.my-head-user {
						display: flex;
						flex-direction: column;
						color: #666;

						.my-head-username {
							font-size: 60upx;
							color: #000;
						}
					}
				}

				.my-head-right {
					display: flex;
					flex-direction: column;
					justify-content: space-between;
					align-items: flex-end;
					padding: 20upx 0;

					.my-head-set {
						display: flex;
						align-items: center;

						image {
							width: 50upx;
							height: 50upx;
							margin-right: 20upx;
						}
					}
				}
			}

			.my-head-bottom {
				display: flex;
				justify-content: space-evenly;

				.mhb-list {
					padding: 20upx;
					display: flex;
					flex-direction: column;
					justify-content: space-around;
					align-items: center;

					text {
						padding: 0 0 20upx 0;
					}
				}
			}

			.my-head-recommend {
				position: absolute;
				width: 84%;
				left: 50%;
				transform: translate(-50%, -10%);
				background: #fff;
				display: flex;
				justify-content: space-between;
				align-items: center;
				padding: 30upx;
				border-radius: 20upx;

				.my-head-recommend-content {
					display: flex;
					align-items: center;

					image {
						width: 60upx;
						height: 60upx;
						padding: 20upx 10upx;
						background: #f0b766;
						margin-right: 20upx;
						border-radius: 12upx;
					}

					.mhrc-text {
						display: flex;
						flex-direction: column;

						.mhrc-text-color {
							color: #f00;
							font-size: 30upx;
						}
					}
				}

				.my-head-recommend-line {
					width: 2upx;
					height: 120upx;
					background: #666;
				}
			}
		}

		.my-content {
			padding: 0 30upx 120upx;
		}

		.my-order {
			background: #fff;
			border-radius: 20upx;
			font-size: 32upx;
			color: #666;

			.my-order-title {
				display: flex;
				justify-content: space-between;
				border-bottom: 1upx solid #666;
				padding: 30upx;

				>text {
					font-size: 40upx;
					color: #000;
				}

				.my-order-title-seeAll {
					display: flex;
					align-items: center;

					image {
						width: 36upx;
						height: 36upx;
						margin-left: 12upx;
					}
				}
			}

			.my-order-content {
				padding: 30upx 0;
				display: flex;
				align-items: center;
				justify-content: space-around;

				.moc-list {
					display: flex;
					flex-direction: column;
					justify-content: center;
					align-items: center;

					image {
						width: 60upx;
						height: 60upx;
						margin-bottom: 10upx;
					}
				}
			}
		}

		.my-tool {
			margin-top: 30upx;
			background: #fff;
			border-radius: 20upx;
			font-size: 32upx;
			color: #666;

			>text {
				display: block;
				font-size: 40upx;
				color: #000;
				border-bottom: 1upx solid #666;
				padding: 30upx;
			}

			.my-tool-content {
				display: flex;
				align-items: center;
				flex-wrap: wrap;

				.mtc-list {
					width: 25%;
					margin: 30upx 0;
					display: flex;
					flex-direction: column;
					justify-content: center;
					align-items: center;

					image {
						width: 60upx;
						height: 60upx;
						margin-bottom: 20upx;
						padding: 20upx;
						border-radius: 60%;
					}
				}
			}
		}

		.my-boutique {
			margin-top: 30upx;
			background: #fff;
			border-radius: 20upx;
			font-size: 32upx;
			color: #666;

			.my-boutique-title {
				display: flex;
				justify-content: space-between;
				border-bottom: 1upx solid #666;
				padding: 30upx;

				.my-boutique-title-left {
					display: flex;
					align-items: center;

					image {
						width: 40upx;
						height: 40upx;
						padding: 10upx;
						border-radius: 60%;
					}

					>text {
						display: inline-block;
						font-size: 40upx;
						color: #000;
						margin: 0 10upx;
					}

					.mbtl-recommend {
						display: inline-block;
						color: #fff;
						font-size: 32upx;
						padding: 4upx 10upx;
						border-radius: 8upx;
					}
				}


				.my-boutique-title-right {
					display: flex;
					align-items: center;

					image {
						width: 36upx;
						height: 36upx;
						margin-left: 12upx;
					}
				}
			}

			.my-boutique-content {
				display: flex;
				padding: 30upx 30upx 30upx 0;

				.mbc-left {
					width: 60%;
					display: flex;
					flex-direction: column;
					justify-content: center;
					align-items: center;

					image {
						width: 80%;
						height: 300upx;
						margin-bottom: 20upx;
					}
				}

				.mbc-right {
					width: 40%;
					display: flex;
					flex-wrap: wrap;
					justify-content: space-between;

					image {
						width: 45%;
						height: 150upx;
					}
				}
			}
		}
		.my-my{
			/deep/ .uni-popup__wrapper-box {
				background: #fff;
			
				.popup-background {
					padding: 40upx;
			
					text {
						display: inline-block;
						position: absolute;
						left: 50%;
						top: 50%;
						transform: translateX(-50%);
						background: #f0b766;
						padding: 40upx;
						font-size: 40upx;
						border-radius: 60%;
					}
				}
			
				.popup-close {
					position: absolute;
					right: 40upx;
					top: 40upx;
			
					image {
						width: 40upx;
						height: 40upx;
					}
				}
			}
		}
		.admin{
			// margin-bottom: 100upx;
			.admin-head{
				background: #67c23a;
				padding: 30upx 60upx;
				display: flex;
				justify-content: space-between;
				align-items: center;
				color: #fff;
				text{
					font-size: 60upx;
				}
				image{
					width: 48upx;
					height: 48upx;
				}
			}
			.admin-content{
				padding: 30upx;
				margin-bottom: 100upx;
			}
			.admin-tool{
				background: #fff;
				border-radius: 30upx;
				.at-title{
					border-bottom: 1upx solid #666;
					padding: 30upx;
				}
				.at-content{
					padding: 30upx;
					display: flex;
					flex-wrap: wrap;
					.atc-list{
						width: 25%;
						margin: 30upx 0;
						display: flex;
						flex-direction: column;
						justify-content: center;
						align-items: center;
						text{
							font-size: 28upx;
						}
						image {
							width: 60upx;
							height: 60upx;
							margin-bottom: 20upx;
							padding: 20upx;
							border-radius: 60%;
						}
					}
				}
			}
			.admin-order{
				background: #fff;
				border-radius: 30upx;
				margin-top: 30upx;
				.ao-title{
					border-bottom: 1upx solid #666;
					padding: 30upx;
				}
				.ao-content{
					display: flex;
					flex-wrap: wrap;
					padding: 30upx 30upx 0 30upx;
					.aoc-list{
						width: 25%;
						display: flex;
						flex-direction: column;
						justify-content: center;
						align-items: center;
						padding: 15upx 0;
						text{
							padding: 15upx 0;
						}
						text:first-child{
							font-size: 48upx;
						}
						text:last-child{
							font-size: 28upx;
						}
					}
				}
				.ao-c-m{
					display: flex;
					flex-wrap: wrap;
					padding: 0 30upx 30upx 30upx;
					.aoc-list{
						width: 33%;
						display: flex;
						flex-direction: column;
						justify-content: center;
						align-items: center;
						padding: 15upx 0;
						text{
							padding: 15upx 0;
						}
						text:first-child{
							font-size: 48upx;
						}
						text:last-child{
							font-size: 28upx;
						}
					}
				}
			}
			/deep/ .uni-popup__wrapper-box {
				width: 90%;
				margin: 0 auto;
			
				.popup-sure {
					background: #fff;
					text-align: center;
					border-radius: 10upx;
					margin-bottom: 30upx;
			
					text {
						display: block;
						padding: 30upx 0;
						border-bottom: 1upx solid #666;
					}
			
					button {
						background: #fff;
						color: red;
						border-radius: 10upx;
					}
				}
			
				>button {
					border-radius: 10upx;
					background: #fff;
					margin: 30upx 0;
				}
			}
		}
	}
</style>
