<template>
	<view class="admin-find-add">
		<view class="age-list">
			<text>发现名称：</text>
			<input type="text" placeholder="请填写发现名称" @blur="getFindName" />
		</view>
		<view class="age-list">
			<text>所属类别：</text>
			<picker @change="bindPickerChange" :range="findArray">
				<view class="agel-picker">
					<view class="uni-input" :style="findStyle">{{findPickerText}}</view>
					<image src="../../static/my-img/youjiantou.png" mode=""></image>
				</view>
			</picker>
		</view>
		<view class="age-list">
			<text>发现内容：</text>
			<textarea :auto-height="true" placeholder="请填写发现内容" :maxlength="-1" @blur="getFindContent" />
			</view>
		<view class="age-list-img">
			<text>背景：</text>
			<view class="ageli-b" @click="handleBga"><image :src="findBga" mode=""></image></view>
			<view class="ageli-b" @click="handleBgb"><image :src="findBgb" mode=""></image></view>
			<view class="ageli-b" @click="handleBgc"><image :src="findBgc" mode=""></image></view>
		</view>
		<view class="age-button">
			<button type="warn" @click="handlePreservation">保存</button>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				findBga: "../../static/my-img/add.png",
				findBgb: "../../static/my-img/add.png",
				findBgc: "../../static/my-img/add.png",
				find:{},
				user:[],
				findArray:[],
				findStyle: "color: grey;",
				findPickerText: "请选择类别",
			};
		},
		onLoad() {
			let that = this
			uni.request({
				url: 'http://localhost:3000/login/user',
				success: (res) => {
					that.user = res.data.data
				}
			});
			uni.request({
				url: 'http://localhost:3000/find',
				success: (res) => {
					that.findArray = res.data.data.map(function(item){
						return item.f_name
					})
				}
			});
		},
		methods:{
			bindPickerChange(e) {
				this.find.find_id = e.target.value + 1
				this.findPickerText = this.findArray[e.target.value]
				this.findStyle = "color: #000;"
			},
			getFindName(e){
				this.find.fi_name = e.target.value
			},
			getFindContent(e){
				this.find.fi_content = e.target.value
			},
			handleBga() {
				let that = this
				uni.chooseImage({
					sourceType: ["camera", "album"],
					sizeType: ["compressed", "original"],
					count: 1,
					success: (res) => {
						that.findBga = "../../static/images/new/" + res.tempFiles[0].name
					}
				});
			},
			handleBgb() {
				let that = this
				uni.chooseImage({
					sourceType: ["camera", "album"],
					sizeType: ["compressed", "original"],
					count: 1,
					success: (res) => {
						that.findBgb = "../../static/images/new/" + res.tempFiles[0].name
					}
				});
			},
			handleBgc() {
				let that = this
				uni.chooseImage({
					sourceType: ["camera", "album"],
					sizeType: ["compressed", "original"],
					count: 1,
					success: (res) => {
						that.findBgc = "../../static/images/new/" + res.tempFiles[0].name
					}
				});
			},
			handlePreservation() {
				let that = this
				// 当前时间格式转换
				let crtTime = new Date()
				let nowTime = that.dateFtt("yyyy-MM-dd hh:mm:ss", crtTime)
				if(Object.keys(that.find).length == 0){
					uni.showToast({
						title: '请填写商家信息',
						icon: 'none',
						duration: 1000
					})
				}else {
					let len = that.user.length
					for(let i=0;i<len;i++){
						uni.request({
							url: 'http://localhost:3000/admin/add/find/info',
							data: {
								userId: that.user[i].user_id,
								fiId: that.find.find_id,
								fiName: that.find.fi_name,
								fiSrca: that.findBga,
								fiSrcb: that.findBgb,
								fiSrcc: that.findBgc,
								fiTime: nowTime,
								fiStatus: "未读",
								fiType: "通知信息",
								fiContent: that.find.fi_content,
								fiPerson: 0
							},
							success: (res) => {
								// console.log(res)
							}
						})
					}
					uni.navigateBack()
					uni.showToast({
						title: '新增成功',
						icon: 'none',
						duration: 2000
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
	.admin-find-add{
		.age-list {
			background: #fff;
			border-bottom: 1upx solid #666;
			display: flex;
			align-items: center;
			padding: 30upx;
			
			picker {
				flex: 1;
			
				.agel-picker {
					display: flex;
					align-items: center;
					justify-content: space-between;
			
					image {
						width: 40upx;
						height: 40upx;
					}
				}
			}
			>text {
				width: 24%;
				padding-right: 30upx;
				font-size: 32upx;
			}
			textarea{
				width: 500upx;
			}
			input {
				flex: 1;
			}
		}
		.age-list-img {
			background: #fff;
			border-bottom: 1upx solid #666;
			padding: 30upx;
			display: flex;
			align-items: center;
		
			image {
				width: 160upx;
				height: 160upx;
				border-radius: 30upx;
			}
		
			.ageli-b {
				width: 160upx;
				height: 160upx;
				border-radius: 30upx;
				background: #efefef;
				color: #fff;
				font-size: 96upx;
				font-weight: 700;
				text-align: center;
				line-height: 160upx;
				margin-right: 30upx;
			}
		}
		
		.age-button {
			width: 90%;
			margin: 30upx auto 0;
		}
	}
</style>
