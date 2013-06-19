$.getJSON('/user/getData',function(data){
	console.log(data);
});

//searches for a fb friend by its name in an array of friends and returns all found friends plus their id
function searchFriends(searchString,friendArray){
	var limit = 5; //maximum output
	if(friendArray){
		var out = [];
		var regex = new RegExp('\\b' + searchString,'i');
		for(var i=0;i<friendArray.length;i++){
			//searches in the current string
			if( (friendArray[i].name).match(regex) && out.length < limit ){
				//adds object to output array
				out.push(friendArray[i]);
			}
		}
		return out;
	}
	else{
		return null;
	}
}

function listFriends(friendArray,$element){
	var $p = $('<p></p>');
	var $a = $('<a></a>');
	var $img = $('<img />');
	for(var i=0;i<friendArray.length;i++){
		$name = $p.clone();
		$name.text(friendArray[i].name);
		$picture = $img.clone();
		$picture.attr({'src':friendArray[i].picture.data.url});
		$link = $a.clone();
		$link.attr({'id':friendArray[i].id,'class':friendArray[i].name});
		$link.append($picture);
		$link.append($name);
		$element.append($link);
	}
}