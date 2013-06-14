//get the youtube Iframe API
$.getScript('https://www.youtube.com/iframe_api');

//save PLaylist when document is ready
var playlist = [];
$(function() {
	$('.trigger').each(function(i){
		playlist[i] = $(this);
		$(this).click(function(e){
			e.preventDefault();
			loadSong(i);
			return false;
		});
	});
});
//make Youtube Iframe Acissible via API
var ytPlayer;
function onYouTubeIframeAPIReady() {
	ytPlayer = new YT.Player('ytPlayer', {
		events: {
			'onReady': onPlayerReady
			//'onStateChange': updateYTSeekBar
		}
	});
}
function onPlayerReady(){
	//temporary fix for youtube onStateChange not firing
	ytPlayer.addEventListener('onStateChange', updateYTSeekBar);
	//show all players with songs from youtube
	$('.from_youtube').slideDown('slow');
}
//set defaults for soundManager
soundManager.url = '/swf/';
soundManager.flashVersion = 9;
soundManager.useFlashBlock = false;
soundManager.useHighPerformance = true;
soundManager.wmode = 'transparent';
soundManager.useFastPolling = true;

soundManager.onready(function() {
	//show all players with songs from soundcloud
	$('.from_soundcloud').slideDown('slow');
});

//play a song based on its numer in the playlist no matter where its from
var playedBar,bufferdBar, nowPlaying;
function loadSong(trigger_number){
	resetPlayer(nowPlaying); //skip the state of the previous player
	nowPlaying = trigger_number;
	//get the correct trigger and extract information from it if trigger_number does not exist get the first one
	var trigger = playlist[trigger_number] ? playlist[trigger_number] : playlist[0];
	var song = {'sid': trigger.attr('href'), 'source': trigger.attr('name')};
	//set up pointers to the playedBar and the bufferdBar
	playedBar = trigger.parent().find('.seekBar .played');
	bufferdBar = trigger.parent().find('.seekBar .bufferd');
	//set the seek bar listener to the current seekBar
	setSeekBarListener(trigger.parent().find('.seekBar'),song.source);

	//first stop everything that's might be playing
	soundManager.destroySound('nowPlaying');
	if(typeof(ytPlayer.stopVideo()) != "undefined") ytPlayer.stopVideo();

	//set bufferd bar to 0 fade out the playedBar then show it with 0 width
	bufferdBar.width(0);
	playedBar.fadeOut(1000,function(){playedBar.width(0).show();});

	//play the song depending on the source
	if(song.source == 'youtube'){
		ytPlayer.loadVideoById(song.sid);
		//the youtube seekbar is updated by the onStateChange function of the Player (see above)
	}
	else if(song.source == 'soundcloud'){
		//create Song and update seek Bars
		soundManager.createSound({
			id: 'nowPlaying', 
			url: song.sid+'?consumer_key=978f352c112cb02aa31166a4824dd0da',
			whileloading: function(){
				var percent = this.bytesLoaded / this.bytesTotal * 100;
				bufferdBar.width(percent+'%');
			},
			whileplaying: function(){
				var percent = this.position / this.durationEstimate * 100;
				playedBar.width(percent+'%');
			},
			//when song is finished Play the next one
			onfinish: function(){
				loadSong(nowPlaying+1);
			}
		});
		//start playing
		soundManager.play('nowPlaying');
	}

	//switch to pause button
	trigger.off('click');//remove all click events
	//hide play symbol show pause symbol
	trigger.find('.pause').addClass('show');
	trigger.find('.play').removeClass('show');
	//add pause function to click event
	trigger.click(function(e){
		e.preventDefault();
		pause(trigger,song.source);
		return false;
	});
}

function pause(trigger,source){
	//pause the currently plaing song
	if (source == 'youtube') {
		ytPlayer.pauseVideo();
	}
	else if (source == 'soundcloud') {
		soundManager.pause('nowPlaying');
	}
	//switch pause icon for play icon
	trigger.find('.play').addClass('show');
	trigger.find('.pause').removeClass('show');
	//remove all click events
	trigger.off('click');
	//add play funtion ti click event
	trigger.click(function(e){
		e.preventDefault();
		play(trigger,source);
		return false;
	});
}

function play(trigger,source){
	//play the currently loaded song
	if (source == 'youtube') {
		ytPlayer.playVideo();
	}
	else if (source == 'soundcloud') {
		soundManager.play('nowPlaying');
	}
	//switch play icon for pause icon
	trigger.find('.pause').addClass('show');
	trigger.find('.play').removeClass('show');
	//remove all click events
	trigger.off('click');
	//add pause funtion ti click event
	trigger.click(function(e){
		e.preventDefault();
		pause(trigger,source);
		return false;
	});
}

function resetPlayer(i){
	if(typeof(i) !== 'undefined'){
		//set playBar to full width
		playlist[i].parent().find('.played').width('100%').show();
		//append the loadSong method to the trigger
		playlist[i].off('click');
		playlist[i].click(function(e){
			e.preventDefault();
			loadSong(i);	
			return false;
		});
		playlist[i].find('.play').addClass('show');
		playlist[i].find('.pause').removeClass('show');
	}
}

var t,prevState;
function updateYTSeekBar(){
	var ytState;
	if(playedBar){ //prevent error on first load
		var bufferd = ytPlayer.getVideoLoadedFraction()*100;
		if(bufferd > 100) bufferd = 100; //for some reason it gets greater than 100
		bufferdBar.width(bufferd +'%');
		var percent = ytPlayer.getCurrentTime() / ytPlayer.getDuration() * 100;
		playedBar.width(percent+'%');
		//update by timeot events
		ytState = ytPlayer.getPlayerState(); //? ytPlayer.getPlayerState(): 1;
		if(ytState > 0 && ytState < 3){
			t = window.setTimeout(updateYTSeekBar,200);
		}
	}
	//when song is finished play next //youtoube stachange my fires twice check for that 
	if (ytPlayer.getPlayerState() === 0 && prevState != ytState) {
		window.clearTimeout(t);
		loadSong(nowPlaying+1);
	}
	prevState = ytState;
}

function setSeekBarListener(seekBar,source){
	//unbind all pevious attaced events from all seek bars
	$('.seekBar').off();
	//bind click event to seek bar
	seekBar.click(function(e){
		//calculate relative clicked position in seekBar
		var relativePos = e.offsetX / e.currentTarget.clientWidth;
		if (source == 'youtube') {
			//calculate Position in song and jump to it
			realPos = relativePos * ytPlayer.getDuration();
			ytPlayer.seekTo(realPos);
		}
		else if (source == 'soundcloud') {
			//calculate Position in song and jump to it
			realPos = relativePos * soundManager.getSoundById('nowPlaying').durationEstimate;
			soundManager.setPosition('nowPlaying',realPos);
		}
	});
}