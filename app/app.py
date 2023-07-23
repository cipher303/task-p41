from flask import Flask, request
from flask import jsonify
import datetime

app = Flask(__name__)


@app.route("/", methods=["GET"])
def get_my_details():
    if request.environ.get("HTTP_X_FORWARDED_FOR") is None:
        ip_addr = request.environ["REMOTE_ADDR"]
    else:
        ip_addr = request.environ["HTTP_X_FORWARDED_FOR"]
    return (
        jsonify({"timestamp": datetime.datetime.now(), "ip": ip_addr}),
        200,
    )


if __name__ == "__main__":
    app.run()
