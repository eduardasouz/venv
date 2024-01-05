#pip install Flask-MySQLdb

from flask import Flask, render_template, request, url_for, redirect, session 
from flask import request, abort
from flask_mysqldb import MySQL



app = Flask(__name__)

# Configurações do banco de dados
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'labinfo'
app.config['MYSQL_DB'] = 'maluly'

# Inicialização do MySQL
mysql = MySQL()
mysql.init_app(app)

@app.route('/Cliente/<Nome>')
def cliente(Nome):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM Cliente WHERE Nome = %s", (Nome,))
    data = cursor.fetchall()
    cursor.close()
    return str(data)


@app.route('/login.html')
def login():
    return render_template('login.html')

@app.route('/cadastro.html')
def cadastro():
    return render_template('cadastro.html')


@app.route('/cadastro', methods=['POST'])
def Cadastro():
    if request.method == 'POST':
        Nome = request.form['Nome']
        Email = request.form['Email']
        Telefone = request.form['Telefone']
        Senha = request.form['Senha']
        CPF = request.form['CPF']
       

        cursor = mysql.connection.cursor()
        cursor.execute('INSERTO INTO cliente (Nome, Email, CPF, Senha) VALUES(%s, %s, %s, %s)', (Nome, Email, CPF, Senha, Telefone))
        mysql.connection.commit()
        cursor.close()

        return redirect
    
@app.route('/enviar', methods=['GET', 'POST'])
def enviar():
    if request.method == 'POST':
        Email = request.form['Email']
        Senha = request.form['Senha']

        cursor = mysql.connection.cursor()
        cursor.execute("SELECT * FROM Cliente WHERE email = %s AND Senha = %s", (Email, Senha))
        user = cursor.fetchone()
        cursor.close

        if user:
            session['Cliente'] = user[0]
            
            return redirect('/minha_conta')
        else:
            return redirect('/login.html') 

    return render_template('login.html') 

@app.route('/minha_conta')
def minha_conta():

    if 'Cliente' in session:
        Cliente= session['Cliente']

        cursor = mysql.connection.cursor()
        cursor.execute("SELECT * FROM cliente WHERE Clientei= %s", (Cliente,))
        user_info = cursor.fetchone()
        cursor.close()

        return render_template('principal.html', user_info=user_info)
    else:
        return redirect('/login.html') 

@app.route('/Produto')
def produtos():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM produto")
    data = cursor.fetchall()
    cursor.close()
    return str(data)

if __name__ == '__main__':
    app.run(debug=True)
