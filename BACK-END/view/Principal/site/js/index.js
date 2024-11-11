function alteraLogin() {
    const imgLogin = document.querySelector("#vinil");
    const linkLogin = document.querySelector("#link-login");
    const dadosUser = localStorage.getItem("dadosUsuario");
    console.log(dadosUser);

    if (dadosUser != null) {
        const obj = JSON.parse(dadosUser);
        linkLogin.innerText = obj.nome.split(" ")[0];
    }
}

addEventListener("DOMContentLoaded", () => {
    alteraLogin();
})