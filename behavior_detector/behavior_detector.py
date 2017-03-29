from behavior_detector.ulogme_osx import EventSniffer
import behavior_detector.ulogme_osx
import behavior_detector.util as util
import os
from urllib.parse import urlparse
from behavior_detector.distracting_key import DISTRACT_DOMAINS


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
		self.CHROME = ['Google Chrome']
		# TODO line 26: Safari handles URLs weird. We don't always get an actual URL...
		self.SAFARI = ['Safari']
		self.CONTEXT_SWITCHING_MSEC = 20
		self.CONTEXT_SWITCHING_DISTRACT = 0.5

	def run(self):
		print("running EventSniffer...\n")
		self.event_sniffer.run()

	
	def parse_window(self, window):
		"""
			Parse window name. Some don't have window name
		"""
		try:
			return window.split(' :: ')
		except:
			return window

	
	def is_context_switching(self):
		"""
			Rules based system for whether the user is context switching
		"""
		# print(self.event_sniffer.last_records)
		records = self.event_sniffer.last_records
		distract_count = 0
		N = len(records)
		if records:
			last_time = None
			time_diff = None
			for i, r in enumerate(records):
				window_name = self.parse_window(r.window_name)
				if not window_name: #HACK: sometimes r.window_name is None
					continue
				curr_time = r.timestamp
				if window_name[0] in self.CHROME:
					dname = urlparse(window_name[1]).netloc
					if dname in DISTRACT_DOMAINS:
						distract_count += 1
				if last_time:
					time_diff = curr_time - last_time 
				last_time = curr_time
				distract_ratio = distract_count/float(len(records))
				if time_diff and time_diff <= self.CONTEXT_SWITCHING_MSEC \
						and distract_ratio >= self.CONTEXT_SWITCHING_DISTRACT:
					print("CONTEXT_SWITCHING!")
					return True
		return False

	def is_offensive_behavior(self):
		"""
			Rules based for whether the user is doing something "offensive"
			- This should just take info from aggregate behavior
		"""
		



