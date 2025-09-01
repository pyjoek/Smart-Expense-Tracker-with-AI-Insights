from datetime import datetime
from . import db

class User(db.Model):
    __tablename__ = "users"
    id = db.Column(db.Integer, primary_key = True)
    username = db.Column(db.String(50), unique = True, nullable = False)
    email = db.Column(db.String(120), unique = True, nullable = False)
    password = db.Column(db.String(200), nullable = False)
    created_at = db.Column(db.DateTime, default = datetime.utcnow)

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