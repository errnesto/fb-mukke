export default class PlayerModel {
  play() {
    console.log('play')
  }

  pause() {
    console.log('pause')
  }

  stop() {
    console.log('stop')
  }

  finished() {
    console.log('send finished event')
  }
}