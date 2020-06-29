<template>
	<view class="my-set-problem-feedback">
		<text>问题咨询或交易帮助,请您对茶APP功能和改进等进行意见反馈。</text>
		<text class="msau-text">建议类型</text>
		<picker @change="bindPickerChange" :range="feedbackTypeList">
			<view class="msau-text-class">
				<text :style="feedbackTypeColor">{{feedbackType}}</text>
				<image src="../../static/my-img/youjiantou.png" mode=""></image>
			</view>
		</picker>
		<text class="msau-text">现象描述和意见</text>
		<view class="msau-text-phenomenon">
			<textarea type="text" v-model="phenomenon" :value="phenomenon" placeholder="请描述您在使用过程中所遇到的问题(建议您上传问题截图),并提供更好的建议."
			 maxlength="200" @blur="handlePhenomenon" />
			</view>
		<view class="msau-text-img">
			<text>图片（选填，请上传提供问题的图片）</text>
			<view class="msau-text-image" @click="handleProvideImg">
				<image src="../../static/my-img/cammer.png" mode=""></image>
				<text>添加图片</text>
			</view>
		</view>
		<button type="warn" @click="handleSbmit">提交</button>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				phenomenon:"",
				feedbackType:"请选择您要反馈的类型",
				feedbackTypeColor:"color:grey",
				feedbackTypeList:["商品质量","登录、注册","订单、支付","账号、活动","发货、物流","其他建议"]
			};
		},
		methods:{
			bindPickerChange(e) {
			    let index = e.target.value
				this.feedbackType = this.feedbackTypeList[index]
				this.feedbackTypeColor = "color: #000"
			},
			handlePhenomenon(e){
				this.phenomenon = e.target.value
			},
			handleProvideImg(){
				uni.showToast({
					icon: 'none',
					title:"请上传描述图片",
					duration:1000
				})
			},
			handleSbmit(){
				uni.navigateBack()
			}
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
		background: #efefef;
	}
	.my-set-problem-feedback {
		padding: 30upx;
		font-size: 36upx;
		color: #666;
		.msau-text {
			display: block;
			color: #000;
			padding: 20upx 0;
		}
		.msau-text-class{
			background: #fff;
			border: 1upx solid #666;
			padding: 10upx 20upx;
			display: flex;
			align-items: center;
			justify-content: space-between;
			image{
				width: 40upx;
				height: 40upx;
			}
		}
		.msau-text-phenomenon{
			textarea{
				width: calc(96%);
				background: #fff;
				word-wrap: wrap;
				padding: 10upx;
				border: 1upx solid #666;
				color: #000;
			}
		}
		.msau-text-img{
			padding: 20upx 0;
			.msau-text-image{
				width: 25%;
				margin: 20upx 0;
				border: 1upx dotted #666;
				padding: 20upx;
				display: flex;
				flex-direction: column;
				justify-content: center;
				align-items: center;
				image{
					width: 60upx;
					height: 60upx;
				}
			}
		}
		button{
			width: 90%;
			position: absolute;
			left: 50%;
			transform: translateX(-50%);
		}
	}
</style>
