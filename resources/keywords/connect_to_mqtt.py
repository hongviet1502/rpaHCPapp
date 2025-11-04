import stat
import paho.mqtt.client as mqtt
import time
import json
import random
import string
from datetime import datetime
from datetime import datetime, timezone, timedelta
# Khai báo biến toàn cục
startTime = None
endTime = None

# MQTT broker configuration
# broker_address = "103.116.8.27"
# broker_port = 5883
broker_address = "210.211.96.132"
broker_port = 1884
username = "SuperUser"
password = "rd@2804"
topic_receive = "/v2/mobile/123456/server/json_req"

dataRsSend = {"type": "typecontrol"}
utc_plus_7 = timezone(timedelta(hours=7))
# utc = datetime.now(timezone.utc)
def set_start_time():
    global startTime
    # startTime = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    startTime = datetime.now(utc_plus_7).strftime("%Y-%m-%d %H:%M:%S")
    # startTime = utc.strftime("%Y-%m-%d %H:%M:%S")
def set_end_time():
    global endTime
    # endTime = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    endTime = datetime.now(utc_plus_7).strftime("%Y-%m-%d %H:%M:%S")
    # endTime = utc.strftime("%Y-%m-%d %H:%M:%S")
# Hàm tạo rqi ngẫu nhiên với chữ và số
def generate_random_rqi(length=8):
    characters = string.ascii_letters + string.digits
    return ''.join(random.choices(characters, k=length))

client = mqtt.Client()

# Callback function for when the client connects to the broker
def on_connect(client, userdata, flags, rc):
    print("Connected with result code " + str(rc))
    client.subscribe(topic_receive)
    # client.publish(topic_send, jsonString)
    

# Callback function for when a message is received from the broker
def on_message(client, userdata, msg):
    print(f"msg: {msg}")
    
def send_to_mqtt(topic, msg):
    client.publish(topic, msg)

def mqtt_connect():
    client.on_connect = on_connect
    client.on_message = on_message
    client.username_pw_set(username, password)
    client.connect(broker_address, broker_port, 60)
    client.loop_start()

def send_result_to_mqtt(topic, type, mac, id, status, errorCode):
    dataRsSend["type"] = type
    dataRsSend["timeStart"] = startTime
    dataRsSend["timeStop"] = endTime
    dataRsSend["mac"] = mac
    dataRsSend["id"] = id
    dataRsSend["status"] = status
    dataRsSend["errorCode"] = str(errorCode)
    temp = {
        "cmd": "appiumLogRpa",
        "rqi": generate_random_rqi(16),
        "data": dataRsSend
    }
    jsonString = json.dumps(temp, indent=4)
    print("message sent: " + jsonString)
    client.publish(topic, jsonString)

def send_result_to_mqtt_with_time(topic, type, mac, id, status, errorCode, timeStart, timeStop):
    dataRsSend["type"] = type
    dataRsSend["timeStart"] = timeStart
    dataRsSend["timeStop"] = timeStop
    dataRsSend["mac"] = mac
    dataRsSend["id"] = id
    dataRsSend["status"] = status
    dataRsSend["errorCode"] = str(errorCode)
    temp = {
        "cmd": "appiumLogRpa",
        "rqi": generate_random_rqi(16),
        "data": dataRsSend
    }
    jsonString = json.dumps(temp, indent=4)
    client.publish(topic, jsonString)

# dictionary để lưu trữ MAC address và tên thiết bị
device_mac_name = {}

def save_mac_name(mac, name):
    device_mac_name[mac] = name

def get_mac_by_name(device_name):
    for mac, name in device_mac_name.items():
        if name == device_name:
            return mac
    return "MAC Address not found"

