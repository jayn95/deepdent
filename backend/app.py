from flask import Flask, request, jsonify
from gradio_client import Client, handle_file
import tempfile, base64, os
import threading

app = Flask(__name__)

GINGIVITIS_SPACE = "jayn95/deepdent_gingivitis"
PERIODONTITIS_SPACE = "jayn95/deepdent_periodontitis"


def call_huggingface(space_name, image_path, labels=None, flatten=False, timeout_seconds=120):
    """Call HF Space in a separate thread with timeout."""
    client = Client(space_name)
    result_container = {}

    def run_predict():
        result_container["data"] = client.predict(
            handle_file(image_path),
            0.4,
            0.5,
            api_name="/predict"
        )

    thread = threading.Thread(target=run_predict)
    thread.start()
    thread.join(timeout=timeout_seconds)

    if thread.is_alive():
        raise TimeoutError(f"Hugging Face request to {space_name} timed out after {timeout_seconds}s")

    result = result_container.get("data", [])

    # Flatten nested list if needed
    if flatten:
        flat_result = []
        for r in result:
            if isinstance(r, (list, tuple)):
                flat_result.extend(r)
            else:
                flat_result.append(r)
    else:
        flat_result = result

    # Auto-generate labels if None
    if labels is None:
        labels = []
        if space_name == PERIODONTITIS_SPACE:
            num_teeth = len(flat_result) // 2
            for i in range(num_teeth):
                for m in ["cej", "abc"]:
                    labels.append(f"tooth{i+1}_{m}")
        else:
            labels = [f"output{i+1}" for i in range(len(flat_result))]

    # Encode files as base64
    encoded_results = {}
    for label, path in zip(labels, flat_result):
        if os.path.exists(path):
            with open(path, "rb") as f:
                encoded_results[label] = base64.b64encode(f.read()).decode("utf-8")
        else:
            encoded_results[label] = None

    return encoded_results


@app.route("/predict/gingivitis", methods=["POST"])
def predict_gingivitis():
    try:
        image = request.files.get("image")
        if not image:
            return jsonify({"error": "No image provided"}), 400

        with tempfile.NamedTemporaryFile(delete=False, suffix=".jpg") as temp_file:
            image.save(temp_file.name)
            temp_path = temp_file.name

        encoded_results = call_huggingface(
            GINGIVITIS_SPACE,
            temp_path,
            labels=["swelling", "redness", "bleeding"]
        )

        os.remove(temp_path)
        return jsonify({"images": encoded_results})

    except TimeoutError as te:
        return jsonify({"error": str(te)}), 500
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route("/predict/periodontitis", methods=["POST"])
def predict_periodontitis():
    try:
        image = request.files.get("image")
        if not image:
            return jsonify({"error": "No image provided"}), 400

        with tempfile.NamedTemporaryFile(delete=False, suffix=".jpg") as temp_file:
            image.save(temp_file.name)
            temp_path = temp_file.name

        encoded_results = call_huggingface(
            PERIODONTITIS_SPACE,
            temp_path,
            labels=None,  # let function handle auto-labels
            flatten=True
        )

        os.remove(temp_path)
        return jsonify({"images": encoded_results})

    except TimeoutError as te:
        return jsonify({"error": str(te)}), 500
    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
