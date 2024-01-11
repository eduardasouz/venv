#pip install Flask-MySQLdb

from flask import Flask, render_template, request, redirect, session 
from flask import request
from flask_mysqldb import MySQL



app = Flask(__name__)
app.secret_key = '192b9bdd22ab9ed4d12e236c78afcb9a393ec15f71bbf5dc987d54727823bcbf'
app.secret_key = b'_5#y2L"F4Q8z\n\xec]/'

# Configurações do banco de dados
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'labinfo'
app.config['MYSQL_DB'] = 'maluly'

# Inicialização do MySQL    
mysql = MySQL(app)

@app.route('/Cliente/<Nome>')
def cliente(Nome):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM Cliente WHERE Nome = %s", (Nome,))
    data = cursor.fetchall()
    cursor.close()
    return str(data)

@app.route('/')
def home():
    if 'Cliente' in session:
        Cliente= session['Cliente']

        cursor = mysql.connection.cursor()
        cursor.execute("SELECT * FROM Cliente WHERE ClienteID = %s", (str(Cliente)))
        user_info = cursor.fetchone()
        cursor.close()

        return render_template('principal.html', nome=user_info[1])
    else:
        return render_template('principal.html')

@app.route('/login')
def login():
    return render_template('login.html')

@app.route('/cadastro')
def cadastro():
    return render_template('cadastro.html')


@app.route('/cadastro', methods=['POST'])
def Cadastro():
    Nome = request.form['nome']
    Email = request.form['email']
    Telefone = request.form['telefone']
    Senha = request.form['senha']
    CPF = request.form['cpf']
    
    cursor = mysql.connection.cursor()
    cursor.execute('INSERT INTO Cliente (Nome, Email, Telefone, Senha, CPF) VALUES (%s, %s, %s, %s, %s)', (Nome, Email, Telefone, Senha, CPF))
    mysql.connection.commit()
    cursor.close()

    return redirect("/login")
    
    
@app.route('/entrar', methods=['POST'])
def enviar():
    Email = request.form['usuario']
    Senha = request.form['senha']

    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM Cliente WHERE Email = %s AND Senha = %s", (Email, Senha))
    user = cursor.fetchone()
    cursor.close()
   

    if user:
        session['Cliente'] = user[0]
        return redirect('/')
    else:
        return redirect('/login') 
    


@app.route('/minha_conta')
def minha_conta():
    if 'Cliente' in session:
        Cliente= session['Cliente']

        cursor = mysql.connection.cursor()
        cursor.execute("SELECT * FROM Cliente WHERE ClienteID = %s", (str(Cliente)))
        user_info = cursor.fetchone()
        cursor.close()

        return render_template('principal.html', nome=user_info[1])
    else:
        return redirect('/login') 


if __name__ == '__main__':
    app.run(debug=True)
