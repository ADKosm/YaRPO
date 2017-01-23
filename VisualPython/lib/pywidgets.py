import os
import sys

sys.path.append(os.getcwd())

from libpywidgets import *

class Object:
    def __init__(self, p, d = True):
        self.pointer = p
        self.toDel = d

    def get_class_name(self):
        return Object_GetClassName(self.pointer)

    def __del__(self):
        if self.toDel:
            Object_Delete(self.pointer)

class Application(Object):
    def __init__(self):
        Object.__init__(self, Application_New())

    def exec(self):
        return Application_Exec(self.pointer)

class Widget(Object):
    def __init__(self, parent = None):
        Object.__init__(self, Widget_New()) if parent is None else Object.__init__(self, Widget_New(parent.pointer), False)

    def set_layout(self, layout):
        Widget_SetLayout(self.pointer, layout.pointer)

    def set_window_title(self, title):
        Widget_SetWindowTitle(self.pointer, title)

    def set_size(self, w, h):
        Widget_SetSize(self.pointer, w, h)

    def set_visible(self, v):
        Widget_SetVisible(self.pointer, v)

class Label(Widget):
    def __init__(self, parent = None):
        Object.__init__(self, Label_New()) if parent is None else Object.__init__(self, Label_New(parent.pointer), False)

    def set_text(self, text):
        Label_SetText(self.pointer, text)

class PushButton(Widget):
    def __init__(self, parent = None):
        self.calls = []
        Object.__init__(self, PushButton_New()) if parent is None else Object.__init__(self, PushButton_New(parent.pointer), False)

    def set_text(self, text):
        PushButton_SetText(self.pointer, text)

    def set_on_clicked(self, callback):
        def wraped_callback():
            callback(self)
        self.calls.append(wraped_callback)
        PushButton_SetOnClicked(self.pointer, self.calls[-1])

class Layout(Object):
    def add_widget(self, widget):
        Layout_AddWidget(self.pointer, widget.pointer)

class VBoxLayout(Layout):
    def __init__(self, parent = None):
        Object.__init__(self, VBoxLayout_New()) if parent is None else Object.__init__(self, VBoxLayout_New(parent.pointer), False)