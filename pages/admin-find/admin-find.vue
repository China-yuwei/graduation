<template>
	<view class="admin-find">
		<view class="af-list" v-for="(item,index) in findLists" :key="index">
			<view class="afl-title">
				<text>{{item.fi_name}}</text>
				<view class="aflt-action">
					<image src="../../static/my-img/bianjidizhi.png" mode="" @click="handleEdit(item)"></image>
					<image src="../../static/my-img/shanchu.png" mode="" @click="handleDelete(item)"></image>
				</view>
			</view>
			<view class="afl-content" @click="handleDetail(item)">
				<image :src="item.fi_src" mode=""></image>
				<view class="hmc-content">
					<text class="hmcc-i">{{item.fi_content}}</text>
					<text style="padding: 10upx 0;">阅览人数{{item.fi_person}}</text>
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
				findLists: []
			};
		},
		onLoad() {
			let that = this
			uni.request({
				url: 'http://localhost:3000/admin/find/info',
				success: (res) => {
					let getData = res.data.data
					that.findLists = getData.sort(function(a, b) {
						let x = a.s_person;
						let y = b.s_person;
						if (x < y) {
							return 1;
						}
						if (x > y) {
							return -1;
						}
						return 0;
					})
				}
			});
		},
		methods: {
			handleEdit(item) {
				uni.showToast({
					icon: 'none',
					title: '暂时不可编辑该内容',
					duration: 1000
				})
			},
			handleDelete(item) {
				let that = this
				uni.request({
					url: 'http://localhost:3000/admin/del/find/info',
					data: {
						findId: item.fi_id
					},
					success: (res) => {
						uni.showToast({
							title: res.data.data,
							icon: 'none',
							duration: 2000
						})
						that.findLists = that.findLists.filter(function(i) {
							return i.fi_id != item.fi_id
						})
					}
				});
			},
			handleDetail(item) {
				uni.navigateTo({
					url: '../admin-find-detail/admin-find-detail?id=' + item.fi_id
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

	.admin-find {
		background: #efefef;
		padding: 30upx;

		.af-list:first-child {
			margin: 0;
		}

		.af-list {
			background: #fff;
			border-radius: 15upx;
			padding: 30upx;
			margin-top: 30upx;

			.afl-title {
				display: flex;
				align-items: center;
				justify-content: space-between;

				.aflt-action {
					image {
						width: 40upx;
						height: 40upx;
						margin-left: 30upx;
					}
				}
			}

			.afl-content {
				display: flex;
				padding-top: 30upx;

				>image {
					width: 30%;
					height: 220upx;
					margin-right: 30upx;
				}

				.hmc-content {
					flex: 1;
					display: flex;
					flex-direction: column;
					justify-content: space-between;

					.hmcc-i {
						overflow: hidden;
						text-overflow: ellipsis;
						display: -webkit-box;
						-webkit-line-clamp: 2;
						-webkit-box-orient: vertical;
					}
				}
			}
		}
	}
</style>
