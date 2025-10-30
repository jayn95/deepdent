from flask import Flask, request, jsonify
from gradio_client import Client, handle_file
import tempfile, base64

app = Flask(__name__)

@app.route("/predict", methods=["POST"])
def predict():
    try:
        image = request.files["image"]

        # Save temporarily
        with tempfile.NamedTemporaryFile(delete=False, suffix=".jpg") as temp_file:
            image.save(temp_file.name)
            temp_path = temp_file.name

        # Call Hugging Face Space
        client = Client("jayn95/deeepdent")
        result = client.predict(
            image=handle_file(temp_path),
            api_name="/predict"
        )

        # Read and encode the output image
        with open(result, "rb") as f:
            encoded = base64.b64encode(f.read()).decode("utf-8")

        return jsonify({"image": encoded})
    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
