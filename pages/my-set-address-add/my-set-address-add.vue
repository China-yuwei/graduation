<template>
	<view class="my-set-new-address">
		<view class="my-set-address-list">
			<text>收货人</text>
			<input type="text" placeholder="请输入收货人姓名" @blur="getUserName" />
		</view>
		<view class="my-set-address-list">
			<text>手机号码</text>
			<input type="number" placeholder="请输入手机号码" @blur="getUserPhone" />
		</view>
		<view class="msna-choose-provence">
			<text>所在地区</text>
			<view class="msnac-provence" @tap="openAddres">
				<text :style="pickerAddress">{{pickerText}}</text>
				<image src="../../static/my-img/youjiantou.png" mode=""></image>
			</view>
			<simple-address ref="simpleAddress" :pickerValueDefault="cityPickerValueDefault" @onConfirm="onConfirm" themeColor="#007AFF"></simple-address>
		</view>
		<view class="my-set-address-list">
			<text>详情地址</text>
			<input type="text" placeholder="请输入具体小区、门牌号" @blur="getUserAddress" />
		</view>
		<button type="warn" @click="handlePreservation">保存</button>
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
				pickerAddress: "color:grey",
				user: [],
				userName: "",
				userPhone: "",
				userAddressA: "",
				userAddressB: ""
			};
		},
		onLoad() {
			let that = this
			uni.getStorage({
				key: 'user_login',
				success(res) {
					that.user = res.data
				}
			})
		},
		methods: {
			getUserName(e) {
				this.userName = e.target.value
			},
			getUserPhone(e) {
				this.userPhone = e.target.value
			},
			getUserAddress(e) {
				this.userAddressB = e.target.value
			},
			openAddres() {
				this.cityPickerValueDefault = [0, 0, 1]
				this.$refs.simpleAddress.open();
			},
			onConfirm(e) {
				this.pickerText = e.label
				this.pickerAddress = "color:#000"
				this.userAddressA = this.pickerText
			},
			handlePreservation() {
				let that = this
				let regPhone = /^[1][3,4,5,7,8][0-9]{9}$/;
				if (that.userName == "") {
					uni.showToast({
						title: '请输入收货人姓名',
						icon: 'none',
						duration: 1000
					})
				} else if (that.userPhone == "") {
					uni.showToast({
						title: '请输入收货人手机号',
						icon: 'none',
						duration: 1000
					})
				} else if (regPhone.test(that.userPhone) == false) {
					uni.showToast({
						title: '请输入正确的手机号',
						icon: 'none',
						duration: 1000
					})
				} else if (that.userAddressA == "") {
					uni.showToast({
						title: '请选择城市',
						icon: 'none',
						duration: 1000
					})
				} else if (that.userAddressB == "") {
					uni.showToast({
						title: '请填写详细地址',
						icon: 'none',
						duration: 1000
					})
				} else {
					uni.request({
						url: 'http://localhost:3000/add/userAddress',
						data: {
							userId: that.user.user_id,
							userName: that.userName,
							userPhone: that.userPhone,
							userProvence: that.userAddressA,
							userHouse: that.userAddressB
						},
						success: (res) => {
							uni.navigateBack({
								url: '../my-set-address/my-set-address'
							})
						}
					})
				}
			}
		}
	}
</script>

<style lang="less">
	.my-set-new-address {
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

		>button {
			width: 90%;
			position: absolute;
			bottom: 40upx;
			left: 50%;
			transform: translateX(-50%);
		}
	}
</style>
