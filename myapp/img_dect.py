def main(path):
    import json
    import requests

    headers = {
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMWE2OGU0N2MtOTMyZi00MDdmLTk4NTgtYzYwNThkZTM4ZDNjIiwidHlwZSI6ImFwaV90b2tlbiJ9.Ad3FGdSs9FIvY6gkALOmAbjabstAjnjnNnypQNNQB6w"}

    url = "https://api.edenai.run/v2/ocr/ocr"
    data = {
        "providers": "google",
        "language": "en",
    }
    files = {"file": open(path, 'rb')}

    response = requests.post(url, data=data, files=files, headers=headers)

    result = json.loads(response.text)
    file_path = r'example.txt'

    # Open the file in write mode ('w'), this will clear the file if it exists
    with open(file_path, 'w') as file:
        file.write(result["google"]["text"])
    return (result["google"]["text"])


# print(main("download (1).jpg"))
# print(main(r"C:\Users\vinai\PycharmProjects\fakeNews\media\1000450612.jpg"))