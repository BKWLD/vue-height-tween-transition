# Vue Height Tween Transition

Tweens between heights of default slotted element.

![](http://yo.bkwld.com/0w3s302M0o2G/Screen%20Recording%202017-09-06%20at%2010.15%20AM.gif)

Demo: https://bkwld.github.io/vue-height-tween-transition/

## Usage

```javascript
// Add component
import 'vue-height-tween-transition/index.css'
Vue.component('height-tween', require('vue-height-tween-transition'))
```

#### Switching mode - Simultaneous

```vue
<template>
  <div class='quotes'>
   <height-tween switching name='fade'>
      <quote :key='quote.id' :quote='quote'></quote>
   </height-tween>
  </div>
</template>

<script>
export default {
  data: function () { return {
    quotes: [{ id: 1, quote: 'Text' }, { id: 2, quote: 'Another'}],
    active: 0,
  }},
  computed: {
    quote: function () { return this.quotes[this.active] }
  },
  methods: {
    next: function() { this.active++ }
  },
}
</script>
<style>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s;
}
.fade-enter,
.fade-leave-to {
  opacity: 0;
}
.fade-leave-active {
  position: absolute;
  width: 100%;
}
</style>
```

#### Switching mode - Out-In

```vue
<template>
  <div class='quotes'>
   <height-tween switching name='fade' mode='out-in'>
      <quote :key='quote.id' :quote='quote'></quote>
   </height-tween>
  </div>
</template>

<script>
export default {
  data: function () { return {
    quotes: [{ id: 1, quote: 'Text' }, { id: 2, quote: 'Another'}],
    active: 0,
  }},
  computed: {
    quote: function () { return this.quotes[this.active] }
  },
  methods: {
    next: function() { this.active++ }
  },
}
</script>
<style>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s;
}
.fade-enter,
.fade-leave-to {
  opacity: 0;
}
</style>
```

#### Toggle (Accordion) mode

```vue
<template>
  <div class='quotes'>
   <height-tween name='fade'>
      <quote :v-if='quote' :quote='quote'></quote>
   </height-tween>
  </div>
</template>

<script>
export default {
  data: function () { return {
    quote: { id: 1, quote: 'Text' },
  }},
}
</script>
<style>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s;
}
.fade-enter,
.fade-leave-to {
  opacity: 0;
}
</style>
```


## Notes

- Uses [`classList`](https://developer.mozilla.org/en-US/docs/Web/API/Element/classList) so requires IE >= 10
- To customize the height transition duration or other properties, define your own `height-tweening` CSS class.
- Doesn't work with `in-out` mode transitions ... though not sure why someone would use those...
- Expects a toggling transition to not use `mode`
