"""Bridge.py. The main Python-(Swift) plugin bundle entry module"""
import logging
import sys
import objc
from Foundation import NSObject
from Cocoa import NSView
from AppKit import NSGraphicsContext, NSRectToCGRect
import Quartz

BridgeInterface = objc.protocolNamed("StackFlow.BridgeInterface")

class Bridge(NSObject, protocols=[BridgeInterface]):
  @classmethod
  def createInstance(self):
    return Bridge.alloc().init()

  def getPythonInformation(self):
    return sys.version

  def addWithA_b_(self, a, b):
      return a + b

  def doSomethingWithArgumentOne_argumentTwo_(self, a, b):
      return a + b

class ColouredView(NSView):
  def drawRect_(self, dirtyRect):
    context = NSGraphicsContext.currentContext().CGContext()
    Quartz.CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0)
    Quartz.CGContextFillRect(context, dirtyRect)

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)

logger.info("Loaded python bundle")
