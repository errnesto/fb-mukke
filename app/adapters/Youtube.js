import PlayerModel from './PlayerModel'

export default class Youtube extends PlayerModel {
  static createFromURL(url) {
    return new Youtube()
  }
}