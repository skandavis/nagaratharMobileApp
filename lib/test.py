import requests
import json

# Your Firebase Server Key from the Firebase Console (Cloud Messaging > Project Settings)
server_key = "BMCz1Eb7vXbBOm7zDdebQ_3beQw0fZgu9nJ_bwIipPkYBMKeTdRxg7zOlhmFOmyi6i92M-mgNMPDJoIgp3p0Jkg"

# The FCM device token you want to send the notification to
device_token = "eQkZhTAw0Uwjn7qu8jwcqk:APA91bHlrdLkIibqemLcE_FSZPOuRrXWgSwfg6LuoohmZoh7Z1S-oeqct2l9oTF6GPvZauoH4fR0Y00hQSBk9UK3QIGGtwb2XqDWXERLFVEAokHrJJq_hQQMaW25JKBgoj7bTUQm5P9s"

# The message payload
message = {
    "to": device_token,
    "notification": {
        "title": "Hello!",
        "body": "This is a test notification sent from Python."
    },
    "data": {
        "key1": "value1",
        "key2": "value2"
    }
}

# Send a POST request to the FCM API
headers = {
    'Content-Type': 'application/json',
    'Authorization': f'key={server_key}',
}

response = requests.post(
    "https://fcm.googleapis.com/fcm/send",
    headers=headers,
    data=json.dumps(message)
)

# Print the response
print(response.status_code)
print(response.json())
