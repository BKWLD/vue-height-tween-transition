<!-- Tween the height of the parent of transitioning items -->

<template lang='pug'>

.height-tween-mask(
	:class='{ "height-tweening": isTweening }'
	:style='styles')

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
		mode: String

		# Same as Vue transition `duration` property
		duration:
			type: Number
			default: null

	data: ->
		height: null # Stores the height that will be set on the parent
		willLeave: false
		willEnter: false

	computed:

		# Make the height style
		styles: -> height: "#{@height}px" if @height != null

		# Are we currently tweening?
		isTweening: -> @willEnter or @willLeave

		# We can assume we're switching between elements if there is a mode or if
		# we're both leaving and entering simultaneously
		isSwitching: -> @mode or (@willEnter and @willLeave)

	methods:

		# When both of these are true, we can assume we're switching between
		# two component simultaneously, like when mode="" but it's not a simple
		# v-if toggle
		beforeLeave: -> @willLeave = true
		beforeEnter: -> @willEnter = true

		# When leaving, always capture the height. If no new component is entering,
		# set the height to 0 after a tick
		leave: (el) ->
			@height = el.clientHeight
			unless @isSwitching then defer => @height = 0

		# Unless we're switching children, start from a height of 0. Then, always
		# wait a tick to expand.
		enter: (el) ->
			height = el.clientHeight
			unless @isSwitching then @height = 0
			defer => @height = height

		# Reset the state unless we're doing an out-in transition, in which case
		# this should get triggered on enter.
		afterLeave: -> @reset() unless @mode == 'out-in'

		# Clear the height after enter finishes in all cases. This is valid
		# because either it's a toggle animation and this won't get called at all
		# when v-if="false" or we're switching and it fires at the end in either
		# supported case.
		afterEnter: -> @reset()

		# Reset the state
		reset: ->
			@height = null
			@willLeave = @willEnter = false

# Helper to call method after one tick
defer = (cb) -> setTimeout cb, 0

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
@import '~bukwild-stylus-library'

// Tween between heights
.height-tweening
	overflow hidden
	transition height 0.3s ease-out-quad

	// If using mode="" with a position absolute *-leave-active
	position relative

</style>
