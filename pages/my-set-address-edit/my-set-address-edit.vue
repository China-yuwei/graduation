<template>
	<view class="my-set-edit-address">
		<view class="my-set-address-list">
			<text>收货人</text>
			<input type="text" :value="myAddress.address_user" @blur="getUserName" />
		</view>
		<view class="my-set-address-list">
			<text>手机号码</text>
			<input type="number" :value="myAddress.address_phone" @blur="getUserPhone" />
		</view>
		<view class="msna-choose-provence">
			<text>所在地区</text>
			<view class="msnac-provence" @tap="openAddres">
				<text style="color:#000">{{myAddress.address_provence}}</text>
				<image src="../../static/my-img/youjiantou.png" mode=""></image>
			</view>
			<simple-address ref="simpleAddress" :pickerValueDefault="cityPickerValueDefault" @onConfirm="onConfirm" themeColor="#007AFF"></simple-address>
		</view>
		<view class="my-set-address-list">
			<text>详情地址</text>
			<input type="text" :value="myAddress.address_house" @blur="getUserAddress" />
		</view>
		<view class="my-set-edit-address-button">
			<button type="warn" @click="handlePreservation">保存</button>
			<button type="warn" @click="handleCancel">取消</button>
		</view>
	</view>
</template>

<script>
	import simpleAddress from '@/components/simple-address/simple-address.nvue'
	export default {
		components: {
			simpleAddress
		},
		data() {
			return {
				cityPickerValueDefault: [0, 0, 1],
				pickerText: '请选择城市',
				user: [],
				current: [],
				myAddress: []
			};
		},
		onLoad(options) {
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
					that.current = res.data.data.filter(function(item) {
						return item.address_id == options.id
					})
					that.myAddress = that.current[0]
				}
			})
		},
		methods: {
			getUserName(e) {
				this.myAddress.address_user = e.target.value
			},
			getUserPhone(e) {
				this.myAddress.address_phone = e.target.value
			},
			getUserAddress(e) {
				this.myAddress.address_house = e.target.value
			},
			openAddres() {
				this.cityPickerValueDefault = [0, 0, 1]
				this.$refs.simpleAddress.open();
			},
			onConfirm(e) {
				this.pickerText = e.label
				this.myAddress.address_provence = this.pickerText
			},
			handlePreservation() {
				let that = this
				let regPhone = /^[1][3,4,5,7,8][0-9]{9}$/;
				if (that.myAddress.address_user == "") {
					uni.showToast({
						title: '请输入收货人姓名',
						icon: 'none',
						duration: 1000
					})
				} else if (that.myAddress.address_phone == "") {
					uni.showToast({
						title: '请输入收货人手机号',
						icon: 'none',
						duration: 1000
					})
				} else if (regPhone.test(that.myAddress.address_phone) == false) {
					uni.showToast({
						title: '请输入正确的手机号',
						icon: 'none',
						duration: 1000
					})
				} else if (that.myAddress.address_provence == "") {
					uni.showToast({
						title: '请选择城市',
						icon: 'none',
						duration: 1000
					})
				} else if (that.myAddress.address_house == "") {
					uni.showToast({
						title: '请填写详细地址',
						icon: 'none',
						duration: 1000
					})
				} else {
					uni.request({
						url: 'http://localhost:3000/modify/userAddress',
						data: {
							addressId: that.myAddress.address_id,
							userName: that.myAddress.address_user,
							userPhone: that.myAddress.address_phone,
							userProvence: that.myAddress.address_provence,
							userHouse: that.myAddress.address_house
						},
						success: (res) => {
							uni.navigateBack({
								url: '../my-set-address/my-set-address'
							})
						}
					})
				}
			},
			handleCancel() {
				uni.navigateBack();
			}
		}
	}
</script>

<style lang="less">
	.my-set-edit-address {
		border-top: 1upx solid #666;
		font-size: 36upx;

		.my-set-address-list {
			padding: 20upx 30upx;
			border-bottom: 1upx solid #666;
			display: flex;
			align-items: center;
			color: #000;
			background: #fff;

			text {
				width: 25%;
			}

			/deep/ input {
				padding: 10upx;
			}
		}

		.msna-choose-provence {
			padding: 20upx 30upx;
			border-bottom: 1upx solid #666;
			color: #000;
			display: flex;
			align-items: center;

			>text {
				width: 25%;
			}

			.msnac-provence {
				width: 75%;
				display: flex;
				align-items: center;
				justify-content: space-between;

				text {
					padding: 10upx;
					font-size: 32upx;
				}

				image {
					width: 40upx;
					height: 40upx;
				}
			}
		}

		.my-set-edit-address-button {
			width: 90%;
			position: absolute;
			bottom: 30upx;
			left: 50%;
			transform: translateX(-50%);

			button {
				margin-top: 30upx;
			}
		}
	}
</style>
