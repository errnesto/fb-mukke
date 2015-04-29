import PlayerModel from './_PlayerModel'

export default class Soundcloud extends PlayerModel {
  constructor() {
    this.name = 'soundcloud'
  }
  
  static createFromURL(url) {
    if (url.indexOf('soundcloud') < 0)
      return null

    return new Soundcloud()
  }
}