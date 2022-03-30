$(function() {
	init();
  
	var actionContainer = $("body");
  
	window.addEventListener("message", function(event) {
	  var item = event.data;

	  if (item.showmenu) {
		ResetMenu();
		$('body').css('background-color', 'rgba(0, 0, 0, 0.15)')
		actionContainer.fadeIn();
	  }
  
	  if (item.hidemenu) {
		$('body').css('background-color', 'transparent')
		actionContainer.fadeOut();
	  }

	  if (item.gender == "male") {
		$('.recruta').attr('src','media/img/recrutaM.png');
		$('.soldado').attr('src','media/img/soldadoM.png');
		$('.cabo').attr('src','media/img/caboM.png');
		$('.sargento').attr('src','media/img/sargentoM.png');
		$('.tenente').attr('src','media/img/tenenteM.png');
		$('.capitao').attr('src','media/img/capitaoM.png');
		$('.major').attr('src','media/img/majorM.png');
		$('.coronel').attr('src','media/img/coronelM.png');
		$('.aluno').attr('src','media/img/alunoM.png');
	} else if (item.gender == "female") {
		$('.recruta').attr('src','media/img/recrutaF.png');
		$('.soldado').attr('src','media/img/soldadoF.png');
		$('.cabo').attr('src','media/img/caboF.png');
		$('.sargento').attr('src','media/img/sargentoF.png');
		$('.tenente').attr('src','media/img/tenenteF.png');
		$('.capitao').attr('src','media/img/capitaoF.png');
		$('.major').attr('src','media/img/majorF.png');
		$('.coronel').attr('src','media/img/coronelF.png');
		$('.aluno').attr('src','media/img/alunoF.png');
	} else if (item.gender == "taticamale") {
		$('.recruta').attr('src','media/img/taticaMaleM.png');
		$('.soldado').attr('src','https://www.flaticon.com/svg/static/icons/svg/564/564617.svg');
		$('.cabo').attr('src','https://www.flaticon.com/svg/static/icons/svg/564/564617.svg');
		$('.sargento').attr('src','https://www.flaticon.com/svg/static/icons/svg/564/564617.svg');
		$('.tenente').attr('src','https://www.flaticon.com/svg/static/icons/svg/564/564617.svg');
		$('.capitao').attr('src','https://www.flaticon.com/svg/static/icons/svg/564/564617.svg');
		$('.major').attr('src','https://www.flaticon.com/svg/static/icons/svg/564/564617.svg');
		$('.coronel').attr('src','https://www.flaticon.com/svg/static/icons/svg/564/564617.svg');
		$('.aluno').attr('src','https://www.flaticon.com/svg/static/icons/svg/564/564617.svg');
	} else if (item.gender == "taticafemale") {
		$('.recruta').attr('src','media/img/taticaMaleF.png');
		$('.soldado').attr('src','https://www.flaticon.com/svg/static/icons/svg/564/564617.svg');
		$('.cabo').attr('src','https://www.flaticon.com/svg/static/icons/svg/564/564617.svg');
		$('.sargento').attr('src','https://www.flaticon.com/svg/static/icons/svg/564/564617.svg');
		$('.tenente').attr('src','https://www.flaticon.com/svg/static/icons/svg/564/564617.svg');
		$('.capitao').attr('src','https://www.flaticon.com/svg/static/icons/svg/564/564617.svg');
		$('.major').attr('src','https://www.flaticon.com/svg/static/icons/svg/564/564617.svgg');
		$('.coronel').attr('src','https://www.flaticon.com/svg/static/icons/svg/564/564617.svg');
		$('.aluno').attr('src','https://www.flaticon.com/svg/static/icons/svg/564/564617.svg');
	}
	});
  
	document.onkeyup = function(data) {
	  if (data.which == 27) {
		if (actionContainer.is(":visible")) {
		  sendData("ButtonClick", "fechar");
		}
	  }
	};
  });
  
  function ResetMenu() {
	$("div").each(function(i, obj) {
	  var element = $(this);
  
	  if (element.attr("data-parent")) {
		element.hide();
	  } else {
		element.show();
	  }
	});
  }
  
  function init() {
	$(".menuoption").each(function(i, obj) {
	  if ($(this).attr("data-action")) {
		$(this).click(function() {
		  var data = $(this).data("action");
		  sendData("ButtonClick", data);
		});
	  }
  
	  if ($(this).attr("data-sub")) {
		var menu = $(this).data("sub");
		var element = $("#" + menu);
  
		$(this).click(function() {
		  element.show();
		  $("#mainmenu").hide();
		});
  
		$(".subtop button, .back").click(function() {
		  element.hide();
		  $("#mainmenu").show();
		});
	  }
	});
  }
  
  function sendData(name, data) {
	$.post("http://bdl_pdcloak/" + name, JSON.stringify(data), function(
	  datab
	) {
	  if (datab != "ok") {
		console.log(datab);
	  }
	});
  }
  
  $('.category_item').click(function() {
	let pegArma = $(this).attr('category');
	$('.item-item').css('transform', 'scale(0)');
  
	function hideArma() {
		$('.item-item').hide();
	}
	setTimeout(hideArma, 100);
  
	function showArma() {
		$('.item-item[category="' + pegArma + '"]').show();
		$('.item-item[category="' + pegArma + '"]').css('transform', 'scale(1)');
	}
	setTimeout(showArma, 100);
  });
  
  $('.category_item[category="all"]').click(function() {
	function showAll() {
		$('.item-item').show();
		$('.item-item').css('transform', 'scale(1)');
	}
	setTimeout(showAll, 100);


  });