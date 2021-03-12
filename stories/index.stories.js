// Storybook deps
import { storiesOf, addDecorator } from '@storybook/vue'
import {
  withKnobs,
  radios,
} from '@storybook/addon-knobs'

// Import testing components
import keyTriggered from './key-triggered.vue'
import ifTriggered from './if-triggered.vue'

// Shared props
const props = ({
  mode = 'out-in',
}) => { return {
  mode: { default: radios('mode', {
    'out-in': 'out-in',
    // 'in-out': 'in-out', // I've never used this
    'none': '',
  }, mode) },
}}

// Create a bucket of stories
addDecorator(withKnobs)
storiesOf('Examples', module)

  .add('Triggered by :key', () => ({
    ...keyTriggered,
    props: props({})
  }))

  .add('Triggered by :v-if', () => ({
    ...ifTriggered
  }))

