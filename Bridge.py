"""Bridge.py. The main Python-(Swift) plugin bundle entry module"""
import logging
import sys
import objc
from Foundation import NSObject
from Cocoa import NSView
from AppKit import NSGraphicsContext, NSRectToCGRect
import Quartz
from behavior_detector.behavior_detector import BehaviorDetector


BridgeInterface = objc.protocolNamed("StackFlow.BridgeInterface")

class Bridge(NSObject, protocols=[BridgeInterface]):
    @classmethod
    def createInstance(self):
        return Bridge.alloc().init()

    def getPythonInformation(self):
        return sys.version

    def addWithA_b_(self, a, b):
        return a + b

    def isContextSwitching(self):
    	return BD.is_context_switching()


logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)

logger.info("Loaded python bundle")

BD = BehaviorDetector()
BD.run()