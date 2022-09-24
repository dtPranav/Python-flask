from datetime import date, datetime
from email import message
import math
from flask_mail import Mail, Message
from flask import Flask, render_template, request, session, redirect
from flask_sqlalchemy import SQLAlchemy
import json
from werkzeug.utils import secure_filename
import os
local_server = True
with open('./cwh_flask/config.json', 'r') as c:
    params = json.load(c)["params"]

app = Flask(__name__)
if local_server:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:@localhost/codingthunder'


app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params["gmail-id"],
    MAIL_PASSWORD=params["gmail-pass"]
)


mail = Mail(app)
db = SQLAlchemy(app)
app.secret_key = 'super-secret-key'


class Contact(db.Model):
    sno = db.Column(db.Integer, unique=True, primary_key=True)
    name = db.Column(db.String(80), nullable=True)
    phone = db.Column(db.String(12), nullable=True)
    msg = db.Column(db.String(120), nullable=True)
    date = db.Column(db.String(12), nullable=True)
    email = db.Column(db.String, nullable=True)


class Post(db.Model):
    sno = db.Column(db.Integer, unique=True, primary_key=True)
    title = db.Column(db.String(30), nullable=True)
    content = db.Column(db.String(800), nullable=True)
    date = db.Column(db.String(12), nullable=True)
    img_file = db.Column(db.String(25), nullable=True)
    slug = db.Column(db.String(25), nullable=True)
    tagline = db.Column(db.String(20))


@app.route('/dashboard', methods=['GET', 'POST'])
def dashboard():
    posts = Post.query.all()
    if 'user' in session and session['user'] == params['admin_user']:
        return render_template('dashboard.html', params=params, post=posts)
    if request.method == 'POST':
        uname = request.form.get('username')
        pwd = request.form.get('Password')
        if uname == params['admin_user'] and params['password'] == pwd:
            session['user'] = uname
            return render_template('dashboard.html', post=posts)

    return render_template('login.html', params=params)


@app.route("/")
def index():
    posts = Post.query.filter_by().all()
    last = math.ceil(len(posts)/int(params["no_of_post"]))
    page = request.args.get('page')
    if (not str(page).isnumeric()):
        page = 1

    page = int(page)
    posts = posts[(page-1)*int(params['no_of_post']):(page-1) *
                  int(params["no_of_post"])+int(params["no_of_post"])]
    print(posts)
    if (page == 1):
        prev = "#"
        next = "/?page=" + str(page+1)
    elif (page == last):
        prev = "/?page=" + str(page-1)
        next = "#"
    else:
        prev = "/?page=" + str(page-1)
        next = "/?page=" + str(page+1)
    return render_template('index.html', params=params, post=posts, prev=prev, next=next)


@app.route('/login')
def home():
    post = Post.query.filter_by().all()
    s = len(post)

    return render_template('login.html', name='Pranav', params=params)


@app.route("/edit/<string:sno>", methods=['GET', 'POST'])
def edit(sno):
    if "user" in session and session['user'] == params['admin_user']:
        if request.method == "POST":
            title = request.form.get('title')
            tagline = request.form.get('tagline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img_file = request.form.get('img_file')
            date = datetime.now()
            if sno == '0':
                post = Post(title=title, slug=slug, content=content,
                            tagline=tagline, img_file=img_file, date=date)
                db.session.add(post)
                db.session.commit()
            else:
                post = Post.query.filter_by(sno=sno).first()
                post.box_title = title
                post.tline = tagline
                post.slug = slug
                post.content = content
                post.img_file = img_file
                post.date = date
                db.session.commit()
                return redirect('/edit/'+sno)
        post = Post.query.filter_by(sno=sno).first()
        return render_template('edit.html', params=params, post=post)


app.config['UPLOAD_FOLDER'] = params['upload_location']


@app.route('/uploader',  methods=['GET', 'POST'])
def uploader():
    if "user" in session and session['user'] == params['admin_user']:
        if request.method == 'POST':
            f = request.files['filename']
            f.save(os.path.join(
                app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            return "Uploaded Successfully"


@app.route('/about')
def about():
    return render_template('about.html', name='Pranav', params=params)


@app.route('/delete/<string:sno>')
def delete(sno):
    if 'user' in session and session['user'] == params['admin_user']:
        post = Post.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboard')


@app.route("/logout")
def logout():
    session.pop('user')
    return redirect('/dashboard')


@app.route("/contact", methods=['GET', 'POST'])
def contact():
    if (request.method == 'POST'):
        # '''ADD entry to database'''
        name = request.form.get('name')
        email = request.form.get('email')
        msg = request.form.get('msg')
        phone = request.form.get('phone')
        entry = Contact(name=name, phone=phone, msg=msg,
                        date=datetime.now(), email=email)
        db.session.add(entry)
        db.session.commit()

        bodymsg = str(msg)+"\n"+str(name)+"\n"+str(email)
        msg1 = Message('New message from blog ',
                       sender=email,
                       recipients=[params["gmail-id"]],
                       body=bodymsg
                       )
        mail.send(msg1)
    return render_template('contact.html')


@app.route("/post/<string:post_slug>", methods=['GET', 'POST'])
def post_route(post_slug):
    post = Post.query.filter_by(slug=post_slug).first()
    return render_template('post.html', params=params, post=post)


@app.route('/bootstrap')
def bootstrap():
    return render_template('bootstrap.html')


app.run(debug=True)
