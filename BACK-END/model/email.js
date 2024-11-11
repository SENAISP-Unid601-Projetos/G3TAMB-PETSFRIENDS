const nodemailer = require('nodemailer');

function enviaEmail(destinatario, assunto, texto) {
    const transporter = nodemailer.createTransport({
        service: 'gmail', // ou outro serviço
        auth: {
            user: 'adm.petfriendstamb@gmail.com', // seu email
            pass: 'qkqf qxgy flyn vtee' // sua senha ou App Password
        }
    });

    const mailOptions = {
        from: 'Administrador Pet Friends <adm.petfriendstamb@gmail.com>',
        to: destinatario,
        subject: assunto,
        html: texto
    };

    transporter.sendMail(mailOptions)
    .then(info => {
        console.log('Email enviado: ' + info.response);
    })
    .catch(error => {
        console.error('Erro ao enviar email: ' + error);
    });
}

exports.enviaEmail = enviaEmail;