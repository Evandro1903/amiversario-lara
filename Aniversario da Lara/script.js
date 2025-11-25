// script simples para tratar ações do convite
document.addEventListener('DOMContentLoaded', function(){
  const rsvp = document.querySelector('.rsvp');
  if(rsvp){
    rsvp.addEventListener('click', function(e){
      // deixa o link abrir; aqui apenas registramos evento para possível analytics
      console.log('RSVP click');
    });
  }
  const pix = document.querySelector('.pix');
  if(pix){
    pix.addEventListener('click', function(e){
      e.preventDefault();
      // mostra cartão com chave PIX
      document.getElementById('pix').scrollIntoView({behavior:'smooth'});
    });
  }
});
