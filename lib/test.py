# import base64, requests

# url = "https://jayn95-deeepdent.hf.space/predict"
# image_path = r"C:\Users\jilln\test.jpg"

# with open(image_path, "rb") as f:
#     b64 = base64.b64encode(f.read()).decode("utf-8")

# payload = {"data": ["data:image/jpeg;base64," + b64]}

# r = requests.post(url, json=payload)
# print(r.status_code, r.text)

from gradio_client import Client, handle_file

client = Client("jayn95/deeepdent")
result = client.predict(
	image=handle_file('https://raw.githubusercontent.com/gradio-app/gradio/main/test/test_files/bus.png'),
	api_name="/predict"
)
print(result)