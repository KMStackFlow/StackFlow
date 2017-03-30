from behavior_detector.ulogme_osx import EventSniffer
import behavior_detector.ulogme_osx
import behavior_detector.util as util
import os
from urllib.parse import urlparse
from behavior_detector.distracting_key import DISTRACT_DOMAINS
from collections import defaultdict


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
		self.CONTEXT_SWITCHING_SEC = 20
		self.CONTEXT_SWITCHING_DISTRACT = 0.5
		self.OFFENSIVE_TIME = 900 #15 min.

	def run(self):
		print("running EventSniffer...\n")
		self.event_sniffer.run()

	
	def parse_window(self, window):
		""" Parse window name. Some don't have window name
		"""
		try:
			return window.split(' :: ')
		except:
			return window


	def parse_last_records(self):
		""" Parses last records and analyzes
			Returns: True if user is context_switching or conducting offensive behavior, else False
			Assumption: Only distracting domains, not programs.
		""" 
		CS = False
		OB = False
		records = self.event_sniffer.last_records
		aggregate = defaultdict(int)
		distract_count = 0
		if records:
			last_time = None
			last_window = None
			time_diff = None
			for i, r in enumerate(records):
				window_name = self.parse_window(r.window_name)
				curr_time = r.timestamp
				if not window_name: #HACK: sometimes r.window_name is None
					continue
				if last_time:
					time_diff = curr_time - last_time
				last_time = curr_time
				
				if time_diff and last_window in DISTRACT_DOMAINS:
					print(time_diff, last_window)
					aggregate[last_window] += time_diff

				if window_name[0] in self.CHROME:
					dname = urlparse(window_name[1]).netloc
					if dname in DISTRACT_DOMAINS:
						distract_count += 1
					last_window = dname
				else: # If program is not chrome, just save program name
					last_window = window_name[0]
				distract_ratio = distract_count/float(len(records))
				
				if time_diff and time_diff <= self.CONTEXT_SWITCHING_SEC \
						and distract_ratio >= self.CONTEXT_SWITCHING_DISTRACT:
					CS = True

			distracted = [i for i in aggregate if aggregate[i] >= self.OFFENSIVE_TIME]
			if distracted:
				OB = True
		return CS or OB

		



