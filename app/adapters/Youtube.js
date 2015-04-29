import PlayerModel from './_PlayerModel'

var mockAPI = function(url) {
  switch (url) {
    case 'https://www.youtube.com/watch?v=JNLlR7ZvEC8':
      return 'antilopen'
    break
    case 'https://www.youtube.com/watch?v=58kX9kQ682g':
      return 'tubbe'
    break 
    case 'https://www.youtube.com/watch?v=i1eJMig5Ik4':
      return false
    break
  }
}

export default class Youtube extends PlayerModel {
  constructor(name) {
    this.name = 'yt ' + name
  }
  
  static createFromURL(url) {
    if (url.indexOf('youtube') < 0)
      return null

    // check url on api
    var resp = mockAPI(url)
    if(resp) {
      return new Youtube(resp)
    } 
  }
}