from behavior_detector.ulogme_osx import EventSniffer
import behavior_detector.util as util
import os


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


	def run(self):
		print("running EventSniffer...\n")
		self.event_sniffer.run()


	def is_context_switching(self):
		print("is context switching?")
		print(self.event_sniffer.get_current_window_name())
		return True