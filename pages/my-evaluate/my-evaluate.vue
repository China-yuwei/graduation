<template>
	<view class="my-evaluate">
		<view class="me-tab">
			<home-tab id="tabbar" :values="items" :stickyTop="108" :current="current" @clickItem="onClickItem"></home-tab>
		</view>
	</view>
</template>

<script>
	import homeTab from '../../components/home-tab.vue';
	export default {
		components: {
			homeTab
		},
		data() {
			return {
				items: ["全部", "有图"],
				current: 0
			};
		},
		methods: {
			onClickItem(index) { //选项卡
				if (this.current !== index) {
					this.current = index;
				}
			}
		}
	}
</script>

<style lang="less">
	.my-evaluate {
		.me-tab {
			/deep/ .home-tab-control {
				.home-tab-control-item {
					width: 50%;
					text-align: center;
				}
			}
		}
	}
</style>
