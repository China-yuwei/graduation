<!-- 联系客服 -->
<template>
	<view class="contact-customer-service">
		<view class="ccs-content">
			<view class="ccs-question-table">
				<view class="ccs-question" v-for="(item,index) in quesLists" :key="index" @click="handleQuestionList(index)">
					<image :src="item.quesListsImgSrc" mode="" :style="item.quesListsBackground"></image>
					<text>{{item.quesListsTitle}}</text>
				</view>
			</view>
			<text>--- 常见问题 ---</text>
			<view class="ccs-question-list">
				<view class="ccs-question-list-title" v-for="(item,index) in questionLists" :key="index" @click="handleQuestion(index)">
					<text>{{item}}</text>
					<image src="../../static/my-img/youjiantou.png" mode=""></image>
				</view>
			</view>
		</view>
		<view class="ccs-my-question">
			<view class="ccs-my-question-method">
				<text>我想</text>
				<view class="ccsmqm-ren">人工客服</view>
			</view>
			<view class="ccs-my-question-write">
				<image src="../../static/my-img/yuyin.png" mode=""></image>
				<input type="text" value="" />
				<image src="../../static/my-img/icon-test.png" mode=""></image>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				quesLists: [{ //问题类别列表
					quesListsTitle: "常见问题",
					quesListsImgSrc: "../../static/my-img/changjianwenti.png",
					quesListsBackground: "background:#3766e9"
				}, {
					quesListsTitle: "优惠权益",
					quesListsImgSrc: "../../static/my-img/youhuiquanyi.png",
					quesListsBackground: "background:#bc16e9"
				}, {
					quesListsTitle: "支付问题",
					quesListsImgSrc: "../../static/my-img/qianbao.png",
					quesListsBackground: "background:#e96d25"
				}, {
					quesListsTitle: "订单物流",
					quesListsImgSrc: "../../static/my-img/dingdan.png",
					quesListsBackground: "background:#48a83e"
				}],
				questionLists: ["卖家不发货怎么办？", "申请退款后，钱退回到哪里？", "未收到货，怎么办？", "新人888元大礼包在哪里？"]
			};
		},
		methods: {
			handleQuestionList(index) {
				uni.showToast({
					icon: 'none',
					title: this.quesLists[index].quesListsTitle,
					duration: 1000
				})
			},
			handleQuestion(index) {
				uni.showToast({
					icon: 'none',
					title: this.questionLists[index],
					duration: 1000
				})
			}
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
		background: #efefef;
	}

	.contact-customer-service {
		.ccs-content {
			padding: 30upx;
			font-size: 36upx;

			.ccs-question-table {
				display: flex;

				.ccs-question {
					background: #fff;
					border-radius: 8upx;
					padding: 20upx;
					margin-right: 30upx;
					display: flex;
					flex-direction: column;
					justify-content: center;
					align-items: center;

					image {
						width: 40upx;
						height: 40upx;
						padding: 10upx;
					}

					text {
						margin-top: 16upx;
						font-size: 26upx;
						white-space: nowrap;
					}
				}
			}

			>text {
				display: block;
				color: #666;
				padding: 40upx 0;
				text-align: center;
			}

			.ccs-question-list {
				padding: 0 30upx;
				background: #fff;
				border-radius: 16upx;

				.ccs-question-list-title {
					padding: 20upx 0;
					border-bottom: 1upx solid #666;
					display: flex;
					justify-content: space-between;
					align-items: center;

					image {
						width: 40upx;
						height: 40upx;
					}
				}
			}
		}
	}

	.ccs-my-question {
		width: 92%;
		position: absolute;
		bottom: 0;
		padding: 30upx;
		font-size: 36upx;
		border-top: 1upx solid #666;

		.ccs-my-question-method {
			display: flex;
			align-items: center;

			.ccsmqm-ren {
				margin-left: 20upx;
				border: 2upx solid #000;
				border-radius: 30upx;
				padding: 4upx 20upx;
			}
		}

		.ccs-my-question-write {
			display: flex;
			align-items: center;
			justify-content: space-between;
			margin-top: 30upx;

			image {
				border: 2upx solid #666;
				border-radius: 60%;
				width: 60upx;
				height: 60upx;
			}

			input {
				background: #fff;
				width: 70%;
				height: 60upx;
				line-height: 60upx;
				border-radius: 30upx;
				padding: 4upx 20upx;
			}
		}
	}
</style>
