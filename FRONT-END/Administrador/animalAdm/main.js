/*
function alteraLogin() {
    const linkLogin = document.querySelector("#link-login");
    const dadosUser = localStorage.getItem("dadosUsuario");
    const imgPerfil = document.querySelector("#vinil");
    console.log(dadosUser);

    if (dadosUser != null) {
        const obj = JSON.parse(dadosUser);
        linkLogin.innerText = obj.nome.split(" ")[0];

        if (obj.foto !== null && obj.foto != "null") {
            imgPerfil.setAttribute("src", obj.foto);
        }
    }
}*/

function logoutConta() {
    localStorage.clear();
    open("/LoginAdm", "_self");
}
/*
function toggleMenu() {
    const menu = document.getElementById('profileMenu');
    menu.style.display = localStorage.getItem("dadosUsuario") == null || menu.style.display === 'block' ? 'none':'block';
  }*/
/*
addEventListener("DOMContentLoaded", () => {
    alteraLogin();
})*/
/*
  // Fecha o menu se clicar fora
  window.onclick = function(event) {
    if (!event.target.matches('#vinil')) {
      const menus = document.getElementsByClassName('profile-menu');
      for (let i = 0; i < menus.length; i++) {
        const openMenu = menus[i];
        if (openMenu.style.display === 'block') {
          openMenu.style.display = 'none';
        }
      }
    }
  }*/