import os


class Options(object):
	pass


def makedir(path):
	try:
		os.makedirs(path)
	except OSError as exc:  # Python >2.5
		if os.path.isdir(path):
			pass
		else:
			raise("Fail to make directory: %d\n", path)