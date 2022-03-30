$(document).ready(function () {
	window.addEventListener("message", function (event) {

		if(event.data.css == "sucesso"){
			iziToast.show({
				messageSize: '15',
				messageLineHeight: '14',
				messageColor: 'rgba(255, 255, 255, 0.600)',

				iconUrl : 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path fill="none" stroke="%2390e990" stroke-width="12" stroke-linejoin="round" stroke-linecap="round" d="M 20 52 l 25 25 l 30 -50"></path></svg>',
				timeout: event.data.delay,
				id: 'haduken',
				class: 'pingo',
				theme: 'dark',
				//title: event.data.prefix,
				//titleColor: "rgba(214, 214, 214, 0.815)",
				displayMode: 3,
				close: false,
				balloon: false,
				backgroundColor: 'rgba(0, 0, 0, 0.700)', 
				message: event.data.mensagem,
				position: 'center',
				progressBarColor: "rgba(31, 200, 30)",
				imageWidth: 70,
				layout: 2,
				iconColor: 'rgba(91, 180, 120);',
				maxWidth: 300,
				animateInside: false,
				transitionIn: "bounceInRight",
				messageColor: 'rgba(214, 214, 214, 0.815)',
				//titleSize: '14',
				transitionOut: 'fadeOutLeft'
			});

		} else if(event.data.css == "negado"){
 			iziToast.show({
				messageSize: '15',
				messageLineHeight: '14',
				messageColor: 'rgba(255, 255, 255, 0.600)',

				iconUrl : 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><g transform="translate(50 50) rotate(45)"><path fill="none" stroke="%23e99090" stroke-width="12" stroke-linejoin="round" stroke-linecap="round" d="M 0 -30 v 60 z M -30 0 h 60"></path></g></svg>',
				timeout: event.data.delay,
				id: 'haduken',
				class: 'pingo',
				theme: 'dark',
				//title: event.data.prefix,
				//titleColor: "rgba(214, 214, 214, 0.815)",
				displayMode: 3,
				close: false,
				balloon: false,
				backgroundColor: 'rgba(0, 0, 0, 0.700) ',
				message: event.data.mensagem,
				position: 'center',
				progressBarColor: 'rgba(160, 0, 0, 184)',
				imageWidth: 70,
				layout: 2,
				iconColor: 'rgb(0, 255, 184)',
				maxWidth: 300,
				animateInside: false,
				transitionIn: "bounceInRight",
				messageColor: 'rgba(214, 214, 214, 0.815)',
				//titleSize: '14',
				transitionOut: 'fadeOutLeft'
			}); 


		}  else if(event.data.css == "aviso"){
			iziToast.show({
				messageSize: '15',
				messageLineHeight: '14',
				messageColor: 'rgba(255, 255, 255, 0.600)',

				iconUrl : 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path fill="none" stroke="%23e9e090" stroke-width="12" stroke-linejoin="round" stroke-linecap="round" d="M 50 18 v 40"></path><circle stroke="none" fill="%23e9e090" cx="50" cy="78" r="8"></circle></svg>',
				timeout: event.data.delay,
				id: 'haduken',
				class: 'pingo',
				theme: 'dark',
				//title: event.data.prefix,
				//titleColor: "rgba(214, 214, 214, 0.815)",
				displayMode: 3,
				close: false,
				balloon: false,
				backgroundColor: 'rgba(0, 0, 0, 0.700) ',
				message: event.data.mensagem,
				position: 'center',
				progressBarColor: 'rgba(233, 224, 144, 184)',
				imageWidth: 70,
				layout: 2,
				iconColor: 'rgb(0, 255, 184)',
				maxWidth: 300,
				animateInside: false,
				transitionIn: "bounceInRight",
				messageColor: 'rgba(214, 214, 214, 0.815)',
				//titleSize: '14',
				transitionOut: 'fadeOutLeft'
			}); 

		}  else if(event.data.css == "importante"){

			iziToast.show({
				messageSize: '15',
				messageLineHeight: '14',
				messageColor: 'rgba(255, 255, 255, 0.600)',

				iconUrl : 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle stroke="none" fill="%2390dee9" cx="50" cy="22" r="8"></circle><path fill="none" stroke="%2390dee9" stroke-width="12" stroke-linejoin="round" stroke-linecap="round" d="M 45 40 h 5 v 40 h -5 h 10"></path></svg>',
				timeout: event.data.delay,
				id: 'haduken',
				class: 'pingo',
				theme: 'dark',
				//title: event.data.prefix,
				//titleColor: "rgba(214, 214, 214, 0.815)",
				displayMode: 3,
				close: false,
				balloon: false,
				backgroundColor: 'rgba(0, 0, 0, 0.700) ',
				message: event.data.mensagem,
				position: 'center',
				progressBarColor: 'rgba(144, 222, 233, 184)',
				imageWidth: 70,
				layout: 2,
				iconColor: 'rgb(0, 255, 184)',
				maxWidth: 300,
				animateInside: false,
				transitionIn: "bounceInRight",
				messageColor: 'rgba(214, 214, 214, 0.815)',
				//titleSize: '14',
				transitionOut: 'fadeOutLeft'
			}); 
		
		} else if(event.data.css) {
			iziToast.show({
				messageSize: '15',
				messageLineHeight: '14',
				messageColor: 'rgba(255, 255, 255, 0.600)',

				iconUrl : 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle stroke="none" fill="%2390dee9" cx="50" cy="22" r="8"></circle><path fill="none" stroke="%2390dee9" stroke-width="12" stroke-linejoin="round" stroke-linecap="round" d="M 45 40 h 5 v 40 h -5 h 10"></path></svg>',
				timeout: event.data.delay,
				id: 'haduken',
				class: 'pingo',
				theme: 'dark',
				//title: event.data.prefix,
				//titleColor: "rgba(214, 214, 214, 0.815)",
				displayMode: 3,
				close: false,
				balloon: false,
				backgroundColor: 'rgba(0, 0, 0, 0.700) ',
				message: event.data.mensagem,
				position: 'center',
				progressBarColor: 'rgba(144, 222, 233, 184)',
				imageWidth: 70,
				layout: 2,
				iconColor: 'rgb(0, 255, 184)',
				maxWidth: 300,
				animateInside: false,
				transitionIn: "bounceInRight",
				messageColor: 'rgba(214, 214, 214, 0.815)',
				//titleSize: '14',
				transitionOut: 'fadeOutLeft'
			}); 
		}
		
		//
		// NOTIFY DE ITEM
		// 

		if  (event.data.mode == "sucesso") {
			console.log(JSON.stringify(event.data));
			iziToast.show({
				image : 'http://177.54.156.70/grk_inv/'+event.data.item+'.png',
				timeout: 5000,
				id: 'haduken',
				class: 'pongo',
				theme: 'dark',
				//title: "Aviso",
				//titleColor: "rgba(214, 214, 214, 0.815)",
				displayMode: 3,
				close: false,
				balloon: false,
				backgroundColor: 'rgba(0, 0, 0, 0.700) ',
				message: "Você recebeu "+ event.data.mensagem,
				position: 'center',
				progressBarColor: "rgba(31, 200, 30)",
				imageWidth: 55,
				layout: 2,
				maxWidth: 300,
				animateInside: false,
				transitionIn: "bounceInRight",
				messageColor: 'rgba(214, 214, 214, 0.815)',
				//titleSize: '14',
				transitionOut: 'fadeOutLeft'
			}); 

		} else if (event.data.mode == "negado") {
			console.log(JSON.stringify(event.data));
			iziToast.show({
				image : 'http://177.54.156.70/grk_inv/'+event.data.item+'.png',
				timeout: 5000,
				id: 'haduken',
				class: 'pongo',
				theme: 'dark',
				//title: "Aviso",
				//titleColor: "rgba(214, 214, 214, 0.815)",
				displayMode: 3,
				close: false,
				balloon: false,
				backgroundColor: 'rgba(0, 0, 0, 0.700) ',
				message: "Você removeu "+ event.data.mensagem,
				position: 'center',
				progressBarColor: 'rgba(160, 0, 0, 184)',
				imageWidth: 55,
				layout: 2,
				maxWidth: 300,
				animateInside: false,
				transitionIn: "bounceInRight",
				messageColor: 'rgba(214, 214, 214, 0.815)',
				//titleSize: '14',
				transitionOut: 'fadeOutLeft'
			}); 	
		}
	})
});


