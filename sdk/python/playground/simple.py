import json
import logging
from datetime import datetime

import flet
from flet import Column, ElevatedButton, Page, Row, Text, Theme

logging.basicConfig(level=logging.DEBUG)

# theme = Theme(color_scheme_seed="red300", brightness="light")
# j = json.dumps(theme, default=vars)
# logging.debug(f"theme_json: {j}")


def main(page: Page):
    page.title = "Simple Example"
    page.theme_mode = "light"
    page.padding = 50
    page.spacing = 30
    page.vertical_alignment = "start"
    page.horizontal_alignment = "center"
    # page.bgcolor = "cyanAccent2003"
    page.theme = Theme(color_scheme_seed="red300")
    page.dark_theme = Theme(color_scheme_seed="cyan")
    page.update()

    def on_click1(e):
        page.add(Text(f"Line {datetime.now()}"))

    def on_click2(e):
        # page.content.pop()
        page.theme_mode = "light" if page.theme_mode == "dark" else "dark"
        page.update()

    page.add(
        Row([Text("This is a button:"), ElevatedButton("Button!")]),
        Column(
            [
                ElevatedButton("Click me!", on_click=on_click1),
                ElevatedButton("Remove last control", on_click=on_click2),
            ],
            alignment="center",
            horizontal_alignment="end",
            spacing=30,
        ),
    )


flet.app(name="test1", port=8550, target=main, view=flet.WEB_BROWSER)