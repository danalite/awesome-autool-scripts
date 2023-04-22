from Foundation import NSObject, NSNotificationCenter

import AppKit
from AppKit import NSApplication
from Foundation import NSNotificationCenter

class MyObserver(NSObject):
    def init(self):
        self = super(MyObserver, self).init()
        if self is None:
            return None

        nc = AppKit.NSNotificationCenter.defaultCenter()
        nc.addObserver_selector_name_object_(self, 'mainWindowChanged:', AppKit.NSWindowDidEnterFullScreenNotification, None)

        return self

    def mainWindowChanged_(self, info):
        w = info.object()
        if hasattr(w, 'windowName'):
            print(w.windowName())

app = NSApplication.sharedApplication()

# Create an observer object
observer = MyObserver.alloc().init()

# Start the application event loop
app.run()
