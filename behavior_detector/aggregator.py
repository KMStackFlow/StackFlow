import datetime
import time
from urllib.parse import urlparse
from collections import defaultdict
import json


class Aggregator(object):
    """
        Aggregator for log file.
        This reads the log file for today
    """
    def __init__(self):
        # time is at 7am
        st = datetime.datetime.now().replace(hour=7, minute=0,
                                             second=0, microsecond=0)
        file_datetime = int(time.mktime(st.timetuple()))
        log_file_path = "logs/window_" + str(file_datetime) + ".txt"
        windows = []
        with open(log_file_path, 'r') as fr:
            for line in fr:
                temp = line.split()
                try:
                    temp[0] = int(temp[0])
                    line = line.strip()
                    timestamp = line[:11].strip()
                    window_name = line[11:].strip()
                    windows.append((timestamp, window_name))
                except:
                    print("ignoring", line)
        self.windows = windows

    def parse_window(self, window):
        try:
            return window.split(' :: ')
        except:
            return window

    def aggregate_by_program(self):
        """
            returns json of program name, seconds spent
            for urls, program name = domain name
        """
        aggregate = defaultdict(int)
        windows = self.windows
        for idx in range(1, len(windows)):
            last_ts, window = windows[idx - 1]
            curr_ts, _ = windows[idx]
            window_name = self.parse_window(window)
            if window_name is None:
                continue
            if window_name[0] == 'Google Chrome':
                if len(window_name) > 1:
                    domain = urlparse(window_name[1]).netloc
                    # manually change local host to jupyter notebook
                    if 'localhost' in domain:
                        domain = 'jupyter notebook'
                    aggregate[domain] += int(curr_ts) - int(last_ts)
            else:
                aggregate[window_name[0]] += int(curr_ts) - int(last_ts)
        return json.dumps(aggregate)

    def aggregate_by_time(self):
        return json.dumps({9: 20, 10: 30, 11: 0, 12: 10})
