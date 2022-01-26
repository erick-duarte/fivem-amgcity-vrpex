$(document).ready(function() {

  // Listen for NUI Events
  window.addEventListener('message', function(event) {
      var item = event.data;

      let Toast = Swal.mixin({
        toast: true,
        position: 'center-start',
        showConfirmButton: false,
        timer: 3000
      });

      if (item.limiteVenda == true) {
          Toast.fire({
              type: 'error',
              title: 'Você já possui 2 veiculos a venda!'
          })
      } else if (item.AvisoSucesso == true) {
        Toast.fire({
          type: 'success',
          title: 'Seu veiculo está a venda!'
        })
      } else if (item.removidoSucesso == true) {
        Toast.fire({
          type: 'success',
          title: 'Seu veiculo foi retirado da venda!'
        })
      } else if (item.AvisoCompraSucesso == true) {
        Toast.fire({
          type: 'success',
          title: 'Veiculo comprado com sucesso!'
        })
      } else if (item.avisoDinheiroInsuficiente == true) {
        Toast.fire({
          type: 'error',
          title: 'Você não possui dinheiro suficiente!'
        })
      } else if (item.seuVeiculo == true) {
        Toast.fire({
          type: 'error',
          title: 'Esse veiculo pertence a você!'
        })
      } else if (item.naoPertence == true) {
        Toast.fire({
          type: 'error',
          title: 'Este veiculo não pertence a você!'
        })
      } else if (item.estaForaVeiculo == true) {
        Toast.fire({
          type: 'error',
          title: 'Você precica estar em um veiculo!'
        })
      } else if (item.valorInvalido == true) {
        Toast.fire({
          type: 'error',
          title: 'Valor inválido!'
        })
      }
  });
});