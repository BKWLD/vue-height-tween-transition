<!--
Transition based on key
-->

<template lang='pug'>

div
	button(@click='next') Next ({{ mode || 'none' }})
	.box(:class='"mode-"+(mode || "none")')
		height-tween(name='fade' :mode='mode' switching)
			div(:key='active') {{ quotes[active] }}

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import heightTween from '../index.vue'
export default

	components: { heightTween }

	data: ->
		active: 0
		quotes: [
			'Maecenas sed diam'
			'Nullam quis risus eget urna mollis ornare vel eu leo. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Maecenas sed diam eget risus varius blandit sit amet non magna. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.'
			'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur blandit tempus porttitor. Nulla vitae elit libero, a pharetra augue. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Cras mattis consectetur purus sit amet fermentum.'
		]

	methods: next: ->
		if @active == @quotes.length - 1
		then @active = 0
		else @active++

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

.box
	border 1px solid grey
	padding 10px
	max-width 320px

.fade-enter-active, .fade-leave-active
	transition opacity .3s
.fade-enter, .fade-leave-to
	opacity 0
.mode-none .fade-leave-active
	position absolute
	width 100%


</style>
