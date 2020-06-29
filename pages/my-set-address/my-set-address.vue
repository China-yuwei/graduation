<template>
	<view class="my-set-address">
		<view class="msa-list" v-for="(item,index) in myAddressLists" :key="index">
			<view class="msa-list-title">
				<view class="msalt-name-phone">
					<text>{{item.address_user}}</text>
					<text>{{item.address_phone}}</text>
				</view>
				<view class="msalt-icon">
					<image src="../../static/my-img/bianjidizhi.png" mode="" @click="handleEdit(index)"></image>
					<image src="../../static/my-img/shanchu.png" mode="" @click="handleDelete(index)"></image>
				</view>
			</view>
			<text>{{item.address_provence}}-{{item.address_house}}</text>
		</view>
		<button type="warn" @click="handleAdd">
			<image src="../../static/my-img/add.png" mode=""></image>
			新建收货地址
		</button>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				user: [],
				myAddressLists: []
			};
		},
		onShow() {
			let that = this
			uni.getStorage({
				key: 'user_login',
				success(res) {
					that.user = res.data
				}
			})
			uni.request({
				url: 'http://localhost:3000/set/address',
				data: {
					userId: that.user.user_id
				},
				success: (res) => {
					that.myAddressLists = res.data.data
				}
			})
		},
		methods: {
			handleEdit(index) {
				uni.navigateTo({
					url: '../my-set-address-edit/my-set-address-edit?id=' + this.myAddressLists[index].address_id
				});
			},
			handleAdd() {
				uni.navigateTo({
					url: '../my-set-address-add/my-set-address-add'
				});
			},
			handleDelete(index) {
				let that = this
				uni.request({
					url: 'http://localhost:3000/del/userAddress',
					data: {
						addressId: that.myAddressLists[index].address_id
					},
					success: (res) => {
						that.myAddressLists.splice(index, 1)
					}
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

	.my-set-address {
		position: relative;
		height: 100%;
		border-top: 1upx solid #666;
		font-size: 36upx;

		.msa-list {
			padding: 30upx;
			background: #fff;
			margin-bottom: 20upx;

			.msa-list-title {
				display: flex;
				align-items: center;
				justify-content: space-between;

				.msalt-name-phone {
					text {
						padding-right: 30upx;
						font-size: 40upx;
					}
				}

				.msalt-icon {
					image {
						width: 40upx;
						height: 40upx;
						padding: 0 30upx;
					}
				}
			}
		}

		button {
			width: 90%;
			position: absolute;
			bottom: 40upx;
			left: 50%;
			transform: translateX(-50%);

			image {
				width: 30upx;
				height: 30upx;
				margin-right: 20upx;
			}
		}
	}
</style>
