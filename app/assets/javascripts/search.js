$.getJSON('/user/getData',function(friends){
	$(function() { //document is ready		
		//the behavior of the search panel
		var $searchInput =  $('#searchFriend');
		var $searchBar =  $('#searchbar');
		var $resultsContainer = $('.searchresults');
		var orgVal = $searchInput.val();

		var selected = -1;
		//empty input onClick
		$searchInput.focus(function(){
			$searchInput.val('');
			selected = 0;
		});
		//clear search bar on click outside
		$searchInput.blur(function(){
			//restore user name in input //hide results //set selected to first element
			selected = -1;
			$searchInput.val(orgVal);
			//nedd some delay to trigger click event
			$resultsContainer.slideUp('slow');
		});
		//on user Input
		var $results, foundFriends, input;
		$searchInput.keyup(function(key){
			input = $searchInput.val();
			if(input.length > 0){
				//user input exist empty the results from before
				$resultsContainer.empty();
				$resultsContainer.show();
				//search friends matching the user input
				foundFriends = searchFriends(input,friends);
				if(foundFriends.length > 0){
					//list result in searchresults tag
					listFriends(foundFriends,$resultsContainer);

					$results = $resultsContainer.children('a');
					$results[selected].className ='focus';
					//respond to the follwing keys
					switch (key.which){
					case 40: //down arrow
						if(selected < foundFriends.length -1){
							selected++;
							$results.removeClass('focus');
							$results[selected].className ='focus';
						}
						break;
					case 38:  //up arrow
						if(selected > 0){
							selected--;
							$results.removeClass('focus');
							$results[selected].className ='focus';
						}
						break;
					case 13: //enter key
						var link = $($results[selected]).attr('href');
						location.href = link;
						loadAnimation($($results[selected]).text());
						break;
					case 27: //escape key
						//remove focus and hide results Container
						$searchInput.blur();
						$resultsContainer.hide();
					}
				}
			}
			else{
				//no user iput hide the search bar and set selected back to first item
				$resultsContainer.hide();
				selected = 0;
			}
		});
		//do some completly made up animations to make the loading time feel shorter
		$resultsContainer.click(function(e){loadAnimation(e.target.outerText);});
		$('.logo').click(function(){loadAnimation(friends[friends.length-1].name);});
		function loadAnimation(text){
			//write the name of the selected friend in searchInput
			$searchInput.val(text);
			$resultsContainer.hide();
			$('.player').slideUp();
			$('.blueLine').width(0).animate({width: '90%'},5000,function(){$(this).animate({width: '98%'},5000);});
		}
	});
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
	var name;
	for(var i=0;i<friendArray.length;i++){
		$name = $p.clone();
		$name.text(friendArray[i].name);
		$picture = $img.clone();
		$picture.attr({'src':friendArray[i].picture.data.url});
		$link = $a.clone();
		//convert whitespace in links to make them look more beatiful
		name = friendArray[i].name.replace(/ /g,'_');
		$link.attr('href','/'+friendArray[i].id+'/'+name);
		$link.append($picture);
		$link.append($name);
		$element.append($link);
	}
}
