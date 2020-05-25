import time
import datetime

for i in range(0, 3):
    print(datetime.datetime.now().isoformat(), i)
    time.sleep(1)
print(datetime.datetime.now().isoformat(), "exit")