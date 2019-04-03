<!--
Tween the height of the parent of transitioning items
-->

<template lang='pug'>

.height-tween-mask(
	:class='{ "height-tweening": tweening }'
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
module.exports =

	props:

		# The Vue transition that should be used
		name: String

		# Same as Vue transition `mode` property
		mode: String

		# Same as Vue transition `duration` property
		duration:
			type: Number
			default: null

		open:
			type: Boolean
			default: true

	data: ->
		height: null # Stores the height that will be set on the parent
		tweening: false # Are we currently tweening

	computed:

		# Make the height style
		styles: -> height: "#{@height}px" if @height != null

		# Are we transitioning to a new

	methods:

		# Add clases to parent
		beforeLeave: (el) -> @tweening = true
		beforeEnter: (el) -> @tweening = true

		# If switching to a new slot, store the old height.  Else, store and then
		# tween to 0
		leave: (el) -> @$nextTick ->
			@height = el.clientHeight
			setTimeout (=> @height = 0), 0 unless @$slots.default

		# If we were closing (not transitioning to a new component), clear settings
		afterLeave: (el) -> @reset() unless @$slots.default

		# Capture the height of the entering element after waiting a tick to make
		# sure DOM updates are finished.  Using setTimeout rather than nextTick so
		# it fires a frame after the height change in "leave" in the case of a
		# simultaneous (mode='') transition.
		enter: (el) ->  setTimeout (=> @height = el.clientHeight), 0

		# Clear the height after the transition ends
		afterEnter: (el) -> @reset()

		# Reset the state
		reset: ->
			@height = null
			@tweening = false

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
@import '~bukwild-stylus-library'

// Tween between heights
.height-tweening
  overflow hidden
  transition height 0.3s ease-out-quad
</style>
