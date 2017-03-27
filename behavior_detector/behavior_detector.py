from behavior_detector.ulogme_osx import EventSniffer
import behavior_detector.ulogme_osx
import behavior_detector.util as util
import os
from collections import namedtuple
import time


Record = namedtuple('Record', ('window_name', 'timestamp'))


class BehaviorDetector(object):

	def __init__(self):

		os.chdir(os.path.dirname(__file__))
		util.makedir("logs")
		curr_path = os.getcwd()
		options = util.Options()
		options.pid_file = curr_path + ".python_pid"
		options.keystroke_raw_file = curr_path + "/logs/keyfreqraw.txt"
		options.active_window_file = curr_path + "/logs/window_%s.txt"
		options.active_window_time = 2
		
		self.options = options
		self.event_sniffer = EventSniffer(options=self.options)
		self.num_records = 5
		self.last_records = []


	def run(self):
		print("running EventSniffer...\n")
		self.event_sniffer.run()


	def is_context_switching(self):
		print("is context switching?")
		print(self.event_sniffer.get_current_window_name())
		print(self.event_sniffer.get_current_chrome_tab())
		return True


	def moniter_window_change(self):
		if not self.last_records \
		or self.event_sniffer.last_app_logged != self.last_records[-1].window_name:
			if len(self.last_records) == self.num_records:
				_ = self.last_records.pop(0)
			self.last_records.append(Record(self.event_sniffer.last_app_logged, int(time.time())))
			print(self.last_records)

