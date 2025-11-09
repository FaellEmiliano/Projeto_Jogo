
const themeButton = document.getElementById('tema');
const body = document.body;


themeButton.addEventListener('click', () => {
   
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