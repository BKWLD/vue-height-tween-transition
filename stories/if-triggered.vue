<!--
Transition based on v-if
-->

<template lang='pug'>

div
	button(@click='open = !open') Toggle ({{ mode }})
	.box: height-tween(:duration='300' :mode='mode')
		div(v-if='open') Donec sed odio dui. Donec sed odio dui. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Lorem ipsum dolor sit amet, consectetur adipiscing elit.

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import heightTween from '../index.vue'
export default

	components: { heightTween }
	
	data: -> open: false

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

.box
	max-width 320px


</style>