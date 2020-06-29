<template>
	<view class="home-swiper" name="homeSwiper">
		<swiper class="swiper" :indicator-dots="indicatorDots" :autoplay="autoplay" :interval="interval" :duration="duration"
		 :circular="circular" :vertical="vertical">
			<swiper-item v-for="(item,index) in lists" :key="index" @click="handleImg(index)">
				<view class="swiper-item">
					<image :src="item.s_bg" mode="scaleToFill"></image>
				</view>
			</swiper-item>
		</swiper>
	</view>
</template>

<script>
	export default {
		name: 'homeSwiper',
		props: {
			lists: { // 要显示的数组
				type: Array,
				default () {
					return [];
				}
			},
			indicatorDots: {
				type: Boolean,
				default: true
			},
			autoplay: {
				type: Boolean,
				default: true
			},
			interval: {
				type: Number,
				default: 2000
			},
			duration: {
				type: Number,
				default: 500
			},
			circular: {
				type: Boolean,
				default: true
			},
			vertical: {
				type: Boolean,
				default: false
			}
		},
		data() {
			return {

			};
		},
		methods: {
			handleImg(index) {
				this.$emit('clickImgItem', this.lists[index].shop_id);
			}
		}
	}
</script>

<style lang="less">
	image {
		width: 100%;
		height: 300upx;
	}
</style>
