import PlayerModel from './PlayerModel'

export default class Youtube extends PlayerModel {
  constructor() {
    this.name = 'my yt player'
  }
  
  static createFromURL(url) {
    return new Youtube()
  }
}