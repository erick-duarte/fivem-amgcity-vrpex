var Radios = [document.getElementById("eoq")];
var Radios_volum = [1];
var estados = [true]
var index_user_id = [0];
var musicaatual = [1];
//user id 0 == Radio Servidor

Radios[0].html5 = true;
		
window.addEventListener('message',function(event){				
	var user_id = event.data.user_id;
	if (event.data.transactionType == "setvolumeRadio"){
		if(index_user_id.indexOf(user_id)!=-1){
			var index = index_user_id.indexOf(user_id)
			if (Radios[index] != null){
				Radios[index].muted = (event.data.transactionVolume==0);	
				if(!event.data.transactionVolume==0){
					Radios[index].volume = event.data.transactionVolume;
				}				
			}
		}			
	}else if (event.data.transactionType == "RadioON"){
		
		if(index_user_id.indexOf(user_id)==-1){
			var index = Radios.length;			
			var Radio = document.createElement("audio");			
			Radios.push(Radio);
			document.getElementById("radios").appendChild(Radio);
			Radio.type = "audio/mp3";			
			Radios[index].html5 = true;
			Radios_volum.push(event.data.volume_max);
			estados.push(true);
			index_user_id.push(user_id);
			//musicaatual.push(user_id);
		}else{
			var index = index_user_id.indexOf(user_id);
			estados[index]=true;
		}
	}else if (event.data.transactionType == "RadioOFF"){		
		if(index_user_id.indexOf(user_id)!=-1){
			var index = index_user_id.indexOf(user_id);		
			
			Radios[index].pause();
			Radios[index].currentTime = 0;
			estados[index]=false;
		}
	}else if (event.data.transactionType == "play"){			
		if(index_user_id.indexOf(user_id)!=-1){
			var index = index_user_id.indexOf(user_id);		
			
			musicaatual[index] = event.data.transactionFile;
			Radios[index].src = "./sounds/musica"+musicaatual[index]+".mp3";		
			Radios[index].type="audio/mp3";
			Radios[index].play();
			Radios[index].muted = true
			Radios[index].addEventListener('ended',function() {
				musicaatual= musicaatual+1
				if(musicaatual>10){
					musicaatual = 1;
				}
				Radios[index].src = "./sounds/musica"+musicaatual+".mp3";								
				Radios[index].play();						
			},true);
		}		
	}else if(event.data.transactionType == "play_url"){	
		if(index_user_id.indexOf(user_id)!=-1){
			var index = index_user_id.indexOf(user_id);		
			Radios[index].src = event.data.transactionFile;

			Radios[index].type="audio/mp3";
			Radios[index].play();
			Radios[index].muted = true
			Radios[index].addEventListener('ended',function() {
				window.jQuery.post('http://amg_scripts/jbl_sound/radiooff', JSON.stringify({user_id:index}));				
				estados[index]=false;
			},true);
		}					
	}	
	return false;
});

