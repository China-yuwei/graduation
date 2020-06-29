<template>
	<view class="shopping-car-order-confirm-address">
		<radio-group @change="radioChange">
			<label class="scoca-label" v-for="(item, index) in myAddressLists" :key="item.address_id">
				<radio :value="String(item.address_id)" :checked="index === current" />
				<view class="scocal-c">
					<view class="msa-list-title">
						<view class="msalt-name-phone">
							<text>{{item.address_user}}</text>
							<text>{{item.address_phone}}</text>
						</view>
					</view>
					<text>{{item.address_provence}}-{{item.address_house}}</text>
				</view>
			</label>
		</radio-group>
		<view class="sc-button">
			<button type="warn" @click="handleAdd">
				<image src="../../static/my-img/add.png" mode=""></image>
				添加收货地址
			</button>
			<button type="warn" @click="handleConfirm">确认</button>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				user: [],
				myAddressLists: [],
				current: 0,
				currentId: "",
				orderIdd: 0
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
		onLoad(options) {
			this.orderIdd = options.id
		},
		methods: {
			handleAdd() {
				uni.navigateTo({
					url: '../my-set-address-add/my-set-address-add'
				});
			},
			radioChange(e) {
				this.currentId = e.target.value
			},
			handleConfirm() {
				let that = this
				if (that.currentId == "") {
					that.currentId = that.myAddressLists[0].address_id
				}
				uni.request({
					url: 'http://localhost:3000/modify/my/order/address',
					data: {
						addressId: Number(that.currentId),
						orderId: Number(that.orderIdd)
					},
					success: (res) => {
						uni.navigateBack();
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

	.shopping-car-order-confirm-address {
		position: relative;
		height: 100%;
		border-top: 1upx solid #666;
		font-size: 36upx;

		.scoca-label {
			background: #fff;
			padding: 30upx;
			margin-bottom: 30upx;
			display: flex;
			align-items: center;

			.scocal-c {
				flex: 1;
				margin-left: 30upx;
			}
		}

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

		.sc-button {
			position: absolute;
			width: 100%;
			bottom: 40upx;

			// left: 50%;
			// transform: translateX(-50%);
			button {
				width: 90%;
				margin-top: 30upx;

				image {
					width: 30upx;
					height: 30upx;
					margin-right: 20upx;
				}
			}
		}
	}
</style>
