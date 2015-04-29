import Youtube from './Youtube'
import Soundcloud from './Soundcloud'

export default function playerFactory(url) {
  var player = Youtube.createFromURL(url)
  if (player)
    return player

  player = Soundcloud.createFromURL(url)
  if (player)
    return player
}