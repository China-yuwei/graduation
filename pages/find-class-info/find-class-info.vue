<template>
	<view class="find-class-info">
		<uni-nav-bar class="mf-nav" left-icon="back" :title="title" :fixed="true" background-color="#67C23A" color="#fff"
		 @clickLeft="handleBack">
		</uni-nav-bar>
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
</template>

<script>
	export default {
		data() {
			return {
				title: "消息",
				infoLists: []
			};
		},
		onLoad(options) {
			let that = this
			uni.request({
				url: 'http://localhost:3000/find',
				success: (res) => {
					let findList = res.data.data
					let currentFind = findList.filter(function(item) {
						return item.find_id == options.id
					})
					that.title = currentFind[0].f_name
				}
			});
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
					let all = res.data.data
					that.infoLists = all.filter(function(item) {
						return item.fi_type == "通知信息" && item.find_id == options.id
					})
				}
			});
		},
		methods: {
			handleBack() {
				uni.switchTab({
					url: '../find/find'
				})
			},
			handleInfoDetail(item) {
				let that = this
				if (item.fi_status == "未读") {
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
							uni.navigateTo({
								url: '../home-info-detail/home-info-detail?id=' + item.fi_id
							})
						}
					});
				} else {
					uni.navigateTo({
						url: '../home-info-detail/home-info-detail?id=' + item.fi_id
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

	.find-class-info {
		background: #efefef;

		.mf-nav {
			/deep/ .uni-navbar--fixed {
				width: 100%;
			}
		}

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
</style>
