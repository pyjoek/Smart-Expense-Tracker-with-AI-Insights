from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager
from flask_migrate import Migrate

db = SQLAlchemy()
migrate = Migrate()
jwt = JWTManager()

def create_app():
    app = Flask(__name__)
    app.config['SQLALCHEMY_DATABASE_URI'] = "mysql+pymysql://trackuser:trackpass@db/expense_tracker"
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['SECRET_KEY'] = "supersecretkey"
    app.config['JWT_SECRET_KEY'] = "jwt-secret-key"

    db.init_app(app)
    migrate.init_app(app, db)
    jwt.init_app(app)

    # blueprints
    from app.routers.auth import auth_bp
    app.register_blueprint(auth_bp, url_prefix = "/auth")

    from app import model  # import your User model


    @app.route("/")
    def index():
        return {"message": "Smart Expense Tracker API is running!"}
    
    return app