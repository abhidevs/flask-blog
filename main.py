from flask import Flask, render_template, request, session, redirect
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail
from werkzeug.utils import secure_filename
import json
import os
from datetime import datetime

with open('config.json') as fp:
    params = json.load(fp)["params"]

app = Flask(__name__)
app.secret_key = 'super-secret-key'
app.config.update(
    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT = '465',
    MAIL_USE_SSL = True,
    MAIL_USERNAME = params['gmail_user'],
    MAIL_PASSWORD = params['gmail_pass']

)
mail = Mail(app)

if params['local_server']:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']
db = SQLAlchemy(app)


class Contact(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(25), nullable=False)
    email = db.Column(db.String(50), nullable=False)
    phone = db.Column(db.String(15), nullable=False)
    message = db.Column(db.String(255), nullable=False)
    date = db.Column(db.String(120), nullable=True)

class Posts(db.Model):
    post_id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(50), nullable=False)
    slug = db.Column(db.String(50), nullable=False)
    content = db.Column(db.String(255), nullable=False)
    image_url = db.Column(db.String(25), nullable=True)
    date = db.Column(db.String(120), nullable=True)

@app.route('/')
def home():
    posts = Posts.query.filter_by().all()
    no_of_posts = int(params['no_of_posts']) 

    # Implementation of Pagination
    load_more = request.args.get('load_more')
    if not load_more:
        load_more = int(params['no_of_posts']) 
    elif str(load_more).isnumeric():
        load_more = int(load_more) 
        load_more += no_of_posts
    else:
        return "404 not found\nIf you entered the url manually then check it and enter correct url."
    
    if load_more<len(posts):
        loadUrl = f'/?load_more={load_more}'
    else:
        loadUrl = '#'

    return render_template('index.html', params=params, posts=posts[:load_more], loadUrl=loadUrl)


@app.route('/about')
def about():
    return render_template('about.html', params=params)

@app.route('/admin', methods = ['GET', 'POST'])
def admin():
    if 'user' in session and session['user'] == params['admin_user']:
        posts = Posts.query.all()
        return render_template('dashboard.html', params=params, posts=posts)

    if request.method == 'POST':
        # Redirect to admin panel after athentication
        username = request.form.get('username')
        password = request.form.get('password')
        if username == params['admin_user'] and password == params['admin_pass']:
            # set a session variable
            session['user'] = username
            posts = Posts.query.all()
            return render_template('dashboard.html', params=params, posts=posts)
        else:
            message = "Wrong username or password"
            return render_template('admin.html', params=params, message=message)
    else:
        return render_template('admin.html', params=params)


@app.route('/contact', methods = ['GET', 'POST'])
def contact():
    if request.method == 'POST':

        # Add entry to the database
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')

        entry = Contact(name=name, email=email, phone=phone, message=message, date=datetime.now())
        db.session.add(entry)
        db.session.commit()
        mail.send_message(f'New message from flask technify contact form {name}', 
                            sender=email, 
                            recipients=[params['gmail_user']],
                            body= f"{message} \nphone: {phone}")


    return render_template('contact.html', params=params)

@app.route("/post/<string:post_slug>", methods = ['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html', params=params, post=post)

@app.route("/edit/<string:post_id>", methods = ['GET', 'POST'])
def edit(post_id):
    if 'user' in session and session['user'] == params['admin_user']:
        if request.method == 'POST':
            updated_title = request.form.get('title')
            updated_content = request.form.get('content')
            updated_slug = updated_title.lower().replace(' ', '-')
            imgfile = request.files['imgfile']
            if imgfile:
                updated_postimg = secure_filename(imgfile.filename)
                imgfile.save(os.path.join(params['image_folder'], updated_postimg))
            else:
                updated_postimg = request.form.get('postimg')
            
            updated_post = Posts(post_id=post_id, title=updated_title, slug=updated_slug, content=updated_content, image_url=updated_postimg, date=datetime.now())
            db.session.merge(updated_post)
            db.session.commit()
            return redirect(f'/edit/{post_id}')     
        else:
            post = Posts.query.get(post_id)
            return render_template('edit.html', params=params, post=post)  
    else:
        return 'Only admin can access this page'

@app.route("/add", methods = ['GET', 'POST'])
def add():
    if 'user' in session and session['user'] == params['admin_user']:
        if request.method == 'GET':
            return render_template('add.html', params=params)   
        else:            
            title = request.form.get('title')
            content = request.form.get('content')
            slug = title.lower().replace(' ', '-')
            imgfile = request.files['postimg']
            if imgfile:
                postimg = secure_filename(imgfile.filename)
                imgfile.save(os.path.join(params['image_folder'], postimg))
            else:
                postimg = ''

            post = Posts(title=title, slug=slug, content=content, image_url=postimg, date=datetime.now())
            db.session.add(post)
            db.session.commit()
            post = Posts.query.filter_by(slug=slug).first()
            return redirect(f'/edit/{post.post_id}')
    else:
        return 'Only admin can access this page'

@app.route("/delete/<string:post_id>")
def delete(post_id):
    if 'user' in session and session['user'] == params['admin_user']:
        post = post = Posts.query.get(post_id)
        db.session.delete(post)
        db.session.commit()
        return redirect('/admin') 
    else:
        return 'Only admin can access this page'

@app.route('/logout')
def logout():
    session.pop('user')
    return redirect('/')

app.run(debug=True)
