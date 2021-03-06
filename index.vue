<!-- Tween the height of the parent of transitioning items -->

<template lang='pug'>

//- Height style rules will be applied here
.height-tween(:class='{ "height-tween-active": isTweening }')

	//- Run the user's transition
	transition(
		:duration='duration'
		:name='name'
		:mode='mode'
		@beforeLeave='beforeLeave'
		@leave='leave'
		@afterLeave='afterLeave'
		@beforeEnter='beforeEnter'
		@enter='enter'
		@afterEnter='afterEnter')

		//- The toggling/switching children
		slot

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
###
One thing for me to remember is that when doing a toggling transition, only
enter _or_ leave hooks are fired. And during mode="out-in", the beforeEnter is
only fired after afterLeave finishes.
###
export default

	props:

		# The Vue transition that should be used
		name: String

		# Same as Vue transition `mode` property
		mode:
			type: String
			default: ''
			validator: (val) -> val in ['out-in', '']

		# Do a switch style tween, rather than a toggle (the default)
		switching: Boolean

		# Same as Vue transition `duration` property
		duration:
			type: Number
			default: null

	data: -> isTweening: false

	methods:

		# Capture the intial height when switching or the starting height when
		# toggling close
		beforeLeave: (el) ->
			@$el.style.height = el.clientHeight + 'px'
			@isTweening = true
			@$emit 'beforeLeave', el

		# When toggling, set the initial height to 0
		beforeEnter: (el) -> @$nextTick ->
			@isTweening = true
			@$el.style.height = 0 unless @switching
			@$emit 'beforeEnter', el

		# When leaving, if toggling, set the height to 0 after a tick
		leave: (el) -> @$nextTick ->
			unless @switching then defer => @$el.style.height = 0
			@$emit 'leave', el

		# When entering, always set the new height after a tick.
		enter: (el) ->
			defer => @$el.style.height = el.clientHeight + 'px'
			@$emit 'enter', el

		# Reset the state unless we're doing an out-in transition, in which case
		# this should get triggered on enter.
		afterLeave: (el) ->
			@reset() unless @mode == 'out-in'
			@$emit 'afterLeave', el

		# Clear the height after enter finishes in all cases. This is valid
		# because either it's a toggle animation and this won't get called at all
		# when v-if="false" or we're switching and it fires at the end in either
		# supported case.
		afterEnter: (el) ->
			@reset()
			@$emit 'afterEnter', el

		# Reset the state
		reset: ->
			@$el.style.height = ''
			@isTweening = false

# Wait a frame
defer = (cb) -> setTimeout cb, 0

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
@import '~bukwild-stylus-library'

// Apply masking
.height-tween
	position relative // Used with switching and position absolute *-leave-active
	overflow hidden

// Transition added while tweening
.height-tween-active
	transition height 0.3s ease-out-quad

</style>
