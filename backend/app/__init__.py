from flask import Flask
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

def create_app():
    app = Flask(__name__)
    app.config['SQLALCHEMY_DATABASE_URI'] = "mysql+pymysql://trackuser:trackpass@dv/expense_tracker"
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['SECRET_KEY'] = "supersecretkey"

    db.init_app(app)

    @app.route("/")
    def index():
        return {"message": "Smart Expense Tracker API is running!"}
    
    return app