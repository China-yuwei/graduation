<template>
	<view name="homeTab" class="home-tab">
		<view class="home-tab-control">
			<view :id="'sc-'+index" :data-index="index" v-for="(item, index) in values" class="home-tab-control-item" :key="index"
			 :class="index === current ? 'active' : ''" @click="onClick">
				{{item}}
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		name: 'homeTab',
		props: {
			values: { // 要显示的数组
				type: Array,
				default () {
					return [];
				}
			},
			current: { // 当前选中第几个
				type: Number,
				default () {
					return 1;
				}
			}
		},
		data() {
			return {};
		},
		methods: {
			onClick(e) {
				let index = parseInt(e.mp.target.dataset.index);
				let that = this;
				let id = e.mp.target.id;
				if (that.current !== index) {
					that.$emit('clickItem', index); // 父级组件回调方法
				}
			}
		}
	};
</script>

<style lang="less">
	.home-tab {
		position: sticky;
	}

	.home-tab-control {
		display: flex;
		// background: #ffffff;
		align-items: center;

		.home-tab-control-item {
			padding: 30upx;
			font-size: 32upx;
			color: #999;
			white-space: nowrap;
		}

		.active {
			color: #00aa00;
			font-size: 40upx;
			border-bottom: 4upx solid #00aa00;
		}
	}
</style>
