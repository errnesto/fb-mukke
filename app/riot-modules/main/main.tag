'use strict'

import riot from 'riot'
import PlayerFactory from '../../adapters/_PlayerFactory'

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

  var urls = ['https://soundcloud.com/pusicrecords/woodcut-the-projects-hulk-hodn-aka-hodini-remix', 'https://www.youtube.com/watch?v=JNLlR7ZvEC8', 'https://www.youtube.com/watch?v=58kX9kQ682g', 'https://www.youtube.com/watch?v=i1eJMig5Ik4']

  this.players = []
  urls.forEach(url => {
    var player = PlayerFactory(url)
    if (player) {
      this.players.push(player)
    } 
  })
</main>