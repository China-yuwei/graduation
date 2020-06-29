<template>
	<view class="admin-find-detail">
		<view class="adf-title">{{info.fi_name}}</view>
		<view class="adf-content" v-for="(item,index) in text" :key="index">
			<view class="adfc-title">
				{{item.title}}
			</view>
			<view class="adfc-c">
				{{item.content}}
			</view>
			<image :src="item.src" mode=""></image>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				info: {},
				text: []
			};
		},
		onLoad(options) {
			let that = this
			uni.request({
				url: 'http://localhost:3000/admin/find/info',
				success: (res) => {
					let getData = res.data.data
					that.info = getData.filter(function(item) {
						return item.fi_id == options.id
					})[0]
					let allText = that.info.fi_content.split(" ")
					let reg = /^[1-9]/ //匹配正整数
					for (let i = 0; i < allText.length; i++) {
						let obj = {}
						if (reg.test(allText[i]) == true) {
							obj.title = allText[i]
							obj.content = allText[i + 1]
							that.text = that.text.concat(obj)
						}
					}
					if (that.text.length == 1) {
						that.text[0].src = that.info.fi_src
					} else if (that.text.length == 2) {
						that.text[0].src = that.info.fi_src
						that.text[1].src = that.info.fi_srcb
					} else if (that.text.length == 3) {
						that.text[0].src = that.info.fi_src
						that.text[1].src = that.info.fi_srcb
						that.text[2].src = that.info.fi_srcc
					} else if (that.text.length == 4) {
						that.text[0].src = that.info.fi_src
						that.text[1].src = that.info.fi_srcb
						that.text[2].src = that.info.fi_srcc
						that.text[3].src = that.info.fi_src
					} else if (that.text.length == 5) {
						that.text[0].src = that.info.fi_src
						that.text[1].src = that.info.fi_srcb
						that.text[2].src = that.info.fi_srcc
						that.text[3].src = that.info.fi_src
						that.text[4].src = that.info.fi_srcb
					} else if (that.text.length == 6) {
						that.text[0].src = that.info.fi_src
						that.text[1].src = that.info.fi_srcb
						that.text[2].src = that.info.fi_srcc
						that.text[3].src = that.info.fi_src
						that.text[4].src = that.info.fi_srcb
						that.text[5].src = that.info.fi_srcc
					}
				}
			});
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
		background: #efefef;
	}

	.admin-find-detail {
		background: #efefef;
		padding: 30upx;

		.adf-title {
			font-size: 56upx;
			text-align: center;
		}

		.adf-content {
			.adfc-title {
				padding: 30upx 0;
				font-size: 44upx;
			}

			.adfc-c {
				text-indent: 2em;
			}

			image {
				width: 100%;
				height: 360upx;
				margin-top: 30upx;
			}
		}
	}
</style>
