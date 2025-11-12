
const themeButton = document.getElementById('tema'); // obtem o botão de tema
const body = document.body;// obtem o elemento body

// Adiciona um ouvinte de evento ao botão para alternar o tema
themeButton.addEventListener('click', () => {

   //alterna a classe 'dark-theme' no body
   //se estiver presente, remove; se não estiver, adiciona
    body.classList.toggle('dark-theme');

    // OPCIONAL: Salvar a preferência do usuário no """""armazenamento local"""""
    if (body.classList.contains('dark-theme')) {
        localStorage.setItem('theme', 'dark');
    } else {
        localStorage.setItem('theme', 'light');
    }
});

// OPCIONAL: Carrega a preferência do usuário quando ele carrega a pagina :D
document.addEventListener('DOMContentLoaded', () => {
    const savedTheme = localStorage.getItem('theme');
    
    if (savedTheme === 'dark') {
        body.classList.add('dark-theme');
    }
});





// PARTE DO SLIDER AUTOMÁTICO//







// Adicione este código ao seu arquivo script.js

let count = 1;

document.getElementById("radio1").checked = true; //inicia na primeira imagem
    
setInterval( function(){ //Função q muda a imagem a cada 4 segundos
    nextImage(); //chama a função nextImage
}, 5000)

function nextImage(){ //função para mudar a imagem
    count++;
    if(count > 4){//se estiver na quinta imagem, volta para a primeira
            count = 1;
    }
    document.getElementById("radio" + count).checked = true;
    
}