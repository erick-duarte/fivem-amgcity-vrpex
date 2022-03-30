$(document).ready(function(){
  window.addEventListener('message', function( event ) {      
    if (event.data.action == true) {
      fuel = event.data.fuel; 
      datafuel = event.data.fuel
      money = event.data.money
      preco_por_litro = event.data.precolitro
      namecomb = event.data.combustivel

      $('.model').attr('src',`https://www.wolkesoft.com/fcp/powerserver/allstar/vehicles/${event.data.vehicle}.png`/*`/html/images/${event.data.vehicle}.png*/)
      $(".money").text('$ ' + event.data.money)
      $('.price').text(`$ ${preco_por_litro}.00`/*preco_por_litro + '.00'*/)
      $('.fuel').text(`${namecomb}`)

      $('body').fadeIn();
      $('.modal').css('display','none');
      $('.allstar__porcentagem').text(Math.round(event.data.fuel) + '%');
      $('.completion').css("width", Math.round(event.data.fuel) + '%');
      $("#allstar__preco").val("")

      $(document).keyup(function(e) {
        if (!counting) {
          if (e.key === "Escape") {
            myStop();
            $("#allstar__preco").val("")
            counting;
            inv;
            price;
            perc_new;
            totalPercent;
            guardar;
            completar;
            maxFuel;
            $.post('http://nation_fuel/escape', JSON.stringify({}));
          }
        }
      });
    } else {
      $('body').fadeOut();  
    }
  });
  
  var counting;
  var completar;
  var guardar;   
  var price;
  var inv;
  var totalPercent;
  var perc_new; 
  var maxFuel;


  function myStart() {
      if (inv == undefined) { inv = setInterval(increase,1000); }
    }

  function myStop() {
    if (inv !== undefined) { clearInterval(inv); inv = undefined; }
  }

  function increase() {
    if (counting) {
      if (fuel < maxFuel) {
        fuel++;
        totalPercent = Math.round(fuel) + '%'
        $('.allstar__porcentagem').text(totalPercent);
        $('.completion').css("width", totalPercent);    
      } else {
        $.post('http://nation_fuel/removeanim', JSON.stringify({}));
        if (completar) {
          $.post('http://nation_fuel/pay', JSON.stringify({ new_perc: perc_new2 }));
          perc_new2;
          completar = !completar;
        } else if (guardar) {
          $.post('http://nation_fuel/pay', JSON.stringify({ new_perc: price }));
          price;
          guardar = !guardar;
        }
        counting = !counting;
        inv;
        totalPercent;
        maxFuel;
        myStop();
        $.post('http://nation_fuel/escape', JSON.stringify({})); 
      } 
    }
  }

$( ".allstar__completar" ).click(function() {
  if (!counting) {
    maxFuel = 100
    perc_new = maxFuel - datafuel;
    perc_new2 = Math.round(perc_new) * Math.round(preco_por_litro);
    if (money >= perc_new2) {
      $.post('http://nation_fuel/checkpay', JSON.stringify({ new_perc: perc_new2 }));
      counting = !counting;
      completar = !completar;
      $('.modal span').text("Aceita abastecer o tanque com $"+perc_new2);  
      $('.modal').fadeIn(300);
      $(".allstar__princi").fadeOut();
      $("body").delay(300).addClass("disable");
    } else {
      var texto = 'O dinheiro necessario para completar com <b>$'+ perc_new2 +'</b> !'
      $.post('http://nation_fuel/notifytext', JSON.stringify({ text: texto }));
    }
  }
});

$( ".allstar__abastecer" ).click(function() {
  if (!counting) {
    combsmax = 100
    litrosabastc = Math.round($("#allstar__preco").val());
    price = Math.round($("#allstar__preco").val() * Math.round(preco_por_litro));
    calcfuel = litrosabastc + Math.round(datafuel);
    if (price > 0 && price <= 5000) {
      if (calcfuel <= combsmax ){
        console.log(money)
        console.log(price)
        if (money >= price) {
          $.post('http://nation_fuel/checkpay', JSON.stringify({ new_perc: price }));
          counting = !counting;
          guardar = !guardar;
          maxFuel = calcfuel - 1
          $('.modal span').text("Deseja abastecer o tanque no valor de $ "+price); 
          $('.modal').fadeIn(300);
          $(".allstar__princi").fadeOut();
          $("body").delay(300).addClass("disable");
        } else {
          var texto = 'Sem dinheiro suficiente para abastecer <b>$'+ price +'</b> !'
          $.post('http://nation_fuel/notifytext', JSON.stringify({ text: texto }));
        }
      } else {
        var texto = "Você não pode abastercer mais que <b>100%</b>."
        $.post('http://nation_fuel/notifytext', JSON.stringify({ text: texto }));
      }
    } else {
      var texto = "Somente valores entre <b>$1</b> e <b>$5000</b>, o valor atual é <b>$"+Math.round($("#amount").val())+"</b>!"
      $.post('http://nation_fuel/notifytext', JSON.stringify({ text: texto }));
    }
  }
});

$(".accept").click(function() {
    if (counting) {
      $('.modal').fadeOut();
      $(".allstar__princi").fadeIn(300);
      $.post('http://nation_fuel/startanim', JSON.stringify({}));
      $("body").delay(300).removeClass("disable");
      myStop();
      myStart(); 
    }
})

  $(".recuse").click(function() {
    $('.modal').fadeOut();
  $(".allstar__princi").fadeIn(300);
  $("body").delay(300).removeClass("disable");
    if (completar) {
      counting = !counting;
      completar = !completar;
    } else if (guardar) {
      counting = !counting;
      guardar = !guardar;
    }
  })
});

function addToPanel(){
    let first = $("#allstar__preco")
    let value = first.val()
    let more = parseInt(value) + 1
    $(".allstar__preco").val('more')
}