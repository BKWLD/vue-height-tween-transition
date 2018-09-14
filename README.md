# Vue Height Tween Transition

Tweens between heights of default slotted element.

![](http://yo.bkwld.com/0w3s302M0o2G/Screen%20Recording%202017-09-06%20at%2010.15%20AM.gif)

## Usage

```javascript
// Add component
import 'vue-height-tween-transition/index.css'
Vue.component('height-tween', require('vue-height-tween-transition'))
```

```
<template>
  <div class='quotes'>
   <height-tween name='fade' mode='out-in'>
      <quote :key='quote.id' :quote='quote'></quote>
   </height-tween>
  </div>
</template>

<script>
export default {
  data: function () {
    quotes: [{ id: 1, quote: 'Text' }, { id: 2, quote: 'Another'}],
    active: 0,
   },
  computed: {
    quote: function () { return this.quotes[this.active] }
  },
  methods: {
    next: function() { this.active++ }
  },
}
</script>
```

Works with `v-if` transitions as well as `:key` based transitions.

## Notes

- Uses [`classList`](https://developer.mozilla.org/en-US/docs/Web/API/Element/classList) so requires IE >= 10
- To customize the height transition duration or other properties, define your own `height-tweening` CSS class.
