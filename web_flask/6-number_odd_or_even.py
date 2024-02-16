#!/usr/bin/python3
"""hello flask"""
from flask import Flask
from flask import render_template


app = Flask(__name__)


@app.route("/")
def index():
    return "Hello HBNB!"


@app.route("/hbnb")
def hbnb():
    return "HBNB"


@app.route("/c/<text>")
def c_is(text):
    res = text.replace("_", " ")
    return f"C {res}"


@app.route("/python/")
@app.route("/python/<text>")
def python_is(text="is cool"):
    res = text.replace("_", " ")
    return f"Python {res}"


@app.route("/number/<int:n>")
def disp_number(n):
    return f"{n} is a number"


@app.route("/number_template/<int:n>")
def disp_html(n):
    return render_template("5-number.html", n=n)


@app.route("/number_odd_or_even/<int:n>")
def odd_or_even(n):
    return render_template("6-number_odd_or_even.html", n=n)


if __name__ == '__main__':
    app.url_map.strict_slashes = False
    app.run(host='0.0.0.0', port=5000)
