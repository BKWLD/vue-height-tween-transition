import { configure, addParameters } from '@storybook/vue';

// Option defaults:
addParameters({
  options: {
    name: 'vue-height-tween-transition',
    url: 'https://github.com/BKWLD/vue-height-tween-transition',
  }
})

// automatically import all files ending in *.stories.js
const req = require.context('../stories', true, /\.stories\.js$/);
function loadStories() {
  req.keys().forEach(filename => req(filename));
}

configure(loadStories, module);
