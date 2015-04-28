'use strict'

import riot from 'riot'
import Youtube from '../../adapters/Youtube'

// uses webpack loaders
require('./main.styl')
require('../player/player.tag')

<main>
  <img src={logo} />
  <h1>fb-mukke</h1>
  <ul>
    <li each={ playerObj in players }>
      <player playerobj = {playerObj} />
    </li>
  </ul>

  this.logo = require('./fb-mukke-logo.svg')

  var urls = ['https://www.youtube.com/watch?v=JNLlR7ZvEC8', 'https://www.youtube.com/watch?v=58kX9kQ682g', 'https://www.youtube.com/watch?v=i1eJMig5Ik4']

  this.players = []
  urls.forEach(url => {
    var ytPlayer = Youtube.createFromURL()
    if (ytPlayer) {
      this.players.push(ytPlayer)
    } 
  })
</main>