from datetime import datetime
from . import db
from werkzeug.security import generate_password_hash, check_password_hash

class User(db.Model):
    __tablename__ = "users"
    id = db.Column(db.Integer, primary_key = True)
    username = db.Column(db.String(50), unique = True, nullable = False)
    email = db.Column(db.String(120), unique = True, nullable = False)
    password = db.Column(db.String(200), nullable = False)
    created_at = db.Column(db.DateTime, default = datetime.utcnow)

    def set_password(self, password):
        """Hash and store the password"""
        self.password = generate_password_hash(password)

    def check_password(self, password):
        """check hash password"""
        return check_password_hash(self.password, password)

class Category(db.Model):
    __tablename__ = "categories"
    id = db.Column(db.Integer, primary_key = True)
    name = db.Column(db.String(50), nullable = False)

class Expense(db.Model):
    __tablename__ = "expenses"
    id = db.Column(db.Integer, primary_key = True)
    limit = db.Column(db.Float, nullable = False)
    month = db.Column(db.String(20), nullable = False)
    user_id = db.Column(db.Integer, db.ForeignKey("users.id"))

class Budget(db.Model):
    __tablename__ = "budgets"
    id = db.Column(db.Integer, primary_key=True)
    limit = db.Column(db.Float, nullable=False)
    month = db.Column(db.String(20), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey("users.id"))