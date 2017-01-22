#!/usr/bin/python3.4
import os
import sys

sys.path.append(os.getcwd())

from libpywidgets import *

app = Application_New()
assert("Application" == Object_GetClassName(app))

main_window = Widget_New()
assert "Widget" == Object_GetClassName(main_window)

layout = VBoxLayout_New(main_window)
assert "VBoxLayout" == Object_GetClassName(layout)

Widget_SetLayout(main_window, layout)
#
# label = Label_New(main_window)
# assert "Label" == Object_GetClassName(label)
#
# # Label_SetText(label, "Helo")
# Layout_AddWidget(layout, label)
#
# print(111)
#
# button = PushButton_New(main_window)
# assert "PushButton" == Object_GetClassName(button)
#
# # PushButton_SetText(button, " ")
# Layout_AddWidget(layout, button)
#
# print("YO")

# Widget_SetWindowTitle(main_window, " ")
# print("DDDDDD")
Widget_SetSize(main_window, 400, 300)
print("1")
Widget_SetVisible(main_window, True)
print("8")

status = Application_Exec(app)
sys.exit(status)
