<!--
Tween the height of the parent of transitioning items
-->

<template lang='pug'>

transition(
	:name='name'
	:mode='mode'
	@beforeLeave='beforeLeave'
	@leave='leave'
	@enter='enter'
	@afterEnter='afterEnter')
	slot

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
module.exports =

	props:

		# The Vue transition that should be used
		name: String

		# Same as Vue transition `mode` property
		mode: String

	# Stores the height that will be set on the parent
	data: -> height: null

	# Store a refrence to the parent
	mounted: -> @parent = @$el.parentElement

	# Watch for the height to change and update the parent element
	watch: height: (val) -> @parent.style.height = if val then "#{val}px" else ''

	methods:

		# Add transition class to parent
		beforeLeave: (el) -> @parent.classList.add 'height-tweening'

		# Capture the height of the leaving element
		leave: (el) -> @height = el.clientHeight

		# Capture the height of the entering element
		enter: (el) -> @height = el.clientHeight

		# Clear the height after the transition ends
		afterEnter: (el) ->
			@height = null
			@parent.classList.remove 'height-tweening'

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>

@import '~bukwild-stylus-library'

// Tween between heights
.height-tweening
	transition height .3s ease-out-quad

</style>
