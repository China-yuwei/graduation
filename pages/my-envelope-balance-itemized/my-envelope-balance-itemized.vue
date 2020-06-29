<template>
	<view class="my-envelope-balance-itemized">
		<view class="mebi-top">
			<image :src="user.user_headImg" mode=""></image>
			<text>{{user.user_name}}的红包余额</text>
			<text class="mebit-total">{{totalMoney}}</text>
			<view class="mebi-top-content">
				<view class="mebitc-left">
					<text class="mebitcl-num">{{totalPay}}</text>
					<text>支出总额</text>
				</view>
				<view class="mebitc-left">
					<text class="mebitcl-num">{{totalNum}}</text>
					<text>支出个数</text>
				</view>
			</view>
		</view>
		<view class="mebi-content">
			<view class="mebi-content-list" v-if="isHave">
				<view class="mebicl-content" v-for="(item,index) in envelopeListsOut" :key="index">
					<view class="mebicl-content-left">
						<text>{{item.e_name}}</text>
						<text class="mebiclcl-title">{{item.e_time}}</text>
					</view>
					<text>{{item.e_money}}元</text>
				</view>
			</view>
			<view class="mebi-content-else" v-else>
				<image src="../../static/home-img/zanwushuju.png" mode=""></image>
				<view>暂无支出</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				headImg: "../../static/my-img/my-head.png",
				// userName: "阿萨德",
				// total: 0,/
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
					that.envelopeListsOut = aaa.filter(function(item) {
						return item.e_type == "0"
					})
					that.envelopeListsIn = aaa.filter(function(item) {
						return item.e_type == "1"
					})
					if (that.envelopeListsOut.length > 0) {
						that.isHave = true
					} else {
						that.isHave = false
					}
				}
			});
		},
		computed: {
			totalNum() {
				if (this.envelopeListsOut) {
					return this.envelopeListsOut.length
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
			},
			totalPay() {
				let total = 0
				if (this.envelopeListsOut) {
					this.envelopeListsOut.forEach(function(item) {
						let eMoney = Number(item.e_money)
						total = total + eMoney
					})
				}
				return total.toFixed(2)
			}
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
		background: #efefef;
	}

	.my-envelope-balance-itemized {
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
