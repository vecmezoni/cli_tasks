#!/usr/bin/python
# -*- coding: UTF-8 -*-

import random
import time
from datetime import datetime, timedelta

for i in range(10000):
	now = time.time()
	dt = datetime(2013,1,20,0,0,0) + timedelta(seconds = random.randrange(1, 86400)) # Текущая дата и время
	milliseconds = '%03d' % random.randrange(0,999)
	print dt.strftime('%Y-%m-%d\t%H:%M:%S,') + milliseconds + "\tinfo\tGET\t", random.randrange(10000, 15000), "\t/" + random.choice(["resume","vacancy","user"]) + "?id=" + str(random.randrange(1, 100)) + "\t200\t" + str(float(random.randrange(5000, 50000))/100) + "ms"
