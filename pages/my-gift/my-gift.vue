<template>
	<view class="my-flash-sales">
		<view class="mfs-top">
			<view class="mfst-title">
				<text>实时热抢</text>
				<text class="mfst-title-change" @click="handleChange">换一批</text>
			</view>
			<view class="mfst-content">
				<view class="mfstc-list" v-for="(item,index) in imgList" :key="index" @click="handleGoods(item)">
					<image :src="item.g_src" mode=""></image>
					<text>￥{{item.g_discount}}</text>
				</view>
			</view>
		</view>
		<view class="mfs-list" v-for="(item,index) in imgLists" :key="index">
			<image :src="item.g_src" mode=""></image>
			<view class="mbccl-right">
				<text class="mbcclr-in">{{item.g_introduce}}</text>
				<view class="mbcclr-bottom">
					<view class="mbcclrb-price">
						￥<text>{{item.g_discount}}</text>
						<text class="mbcclrb-oldPrice">￥{{item.g_price}}</text>
					</view>
					<text class="mbcclrb-num" @click="handleGoods(item)">去购买</text>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				imgList: [],
				imgLists: [],

			};
		},
		onLoad() {
			let that = this
			uni.request({
				url: 'http://localhost:3000/goods',
				success: (res) => {
					let all = res.data.data
					that.imgLists = all.filter(function(item){
						return item.g_discount != null
					})
					that.imgList = that.imgLists.slice(0, 4)
				}
			});
		},
		methods: {
			handleChange() {
				let that = this
				that.imgList = []
				let len = that.imgLists.length
				let arr = that.randomArr(4, 0, len)
				for (let i = 0; i < arr.length; i++) {
					that.imgList.push(that.imgLists[arr[i]])
				}
			},
			handleGoods(item) {
				uni.navigateTo({
					url:'../goods-class-detail/goods-class-detail?goods=' + JSON.stringify(item)
				})
			},
			RandomNum(Min, Max) {
				let Range = Max - Min;
				let Rand = Math.random();
				let num = Min + Math.floor(Rand * Range); //舍去
				return num;
			},
			/** len生成数组的长度，min生成数最小值，max生成数的最大值 **/
			randomArr(len, min, max) {
				if ((max - min) < len) { //可生成数的范围小于数组长度
					return null;
				}
				let arr = [];
				while (arr.length < len) {
					let num = this.RandomNum(min, max);
					if (arr.indexOf(num) == -1) {
						arr.push(num);
					}
				}
				return arr;
			}
		}
	}
</script>

<style lang="less">
	uni-page-body {
		height: 100%;
		background: #efefef;
	}

	.my-flash-sales {
		background: #efefef;
		padding: 30upx;

		.mfs-top {
			background: #fff;
			border-radius: 15upx;
			padding: 30upx;

			.mfst-title {
				display: flex;
				justify-content: space-between;
				align-items: center;

				.mfst-title-change {
					color: #666;
					font-size: 28upx;
				}
			}

			.mfst-content {
				display: flex;
				justify-content: space-between;

				.mfstc-list {
					display: flex;
					flex-direction: column;
					align-items: center;
					color: #f00;

					image {
						width: 150upx;
						height: 180upx;
						border-radius: 15upx;
						padding: 30upx 0;
					}
				}
			}
		}

		.mfs-list {
			margin-top: 30upx;
			background: #fff;
			border-radius: 15upx;
			display: flex;
			align-items: center;

			image {
				width: 30%;
				height: 270upx;
				border-radius: 15upx;
			}

			.mbccl-right {
				height: 270upx;
				flex: 1;
				padding: 0 30upx;
				display: flex;
				flex-direction: column;
				justify-content: space-between;

				.mbcclr-in {
					padding: 15upx 0;
					overflow: hidden;
					text-overflow: ellipsis;
					display: -webkit-box;
					-webkit-line-clamp: 2;
					-webkit-box-orient: vertical;
				}

				.mbcclr-center {
					width: 85%;
					background: #f00;
					opacity: 0.8;
					color: #fff;
					border-radius: 45upx;
					text-align: center;
				}

				.mbcclr-bottom {
					padding: 15upx 0;
					display: flex;
					justify-content: space-between;
					align-items: flex-end;

					.mbcclrb-price {
						color: #f00;

						.mbcclrb-oldPrice {
							font-size: 28upx;
							color: #666;
							text-decoration: line-through;
							padding-left: 15upx;
						}
					}

					.mbcclrb-num {
						background: #f00;
						color: #fff;
						border-radius: 45upx;
						padding: 0 10upx;
					}
				}
			}
		}

	}
</style>
