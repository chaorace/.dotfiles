#!/usr/bin/env python3

import os
import sys
import time
from html.parser import HTMLParser

html = os.getenv('QUTE_SELECTED_HTML')

def qute_command(command):
    with open(os.environ['QUTE_FIFO'], 'w') as fifo:
        fifo.write(command + '\n')
        fifo.flush()

class HackyQueryBuilder(HTMLParser):
    query = ''
    queryAttributes = ''

    def handle_starttag(self, tag, attrs):
        self.query = tag
        for attr in attrs:
            if(attr[0] == 'class'):
                for classVal in attr[1].split():
                    self.query += f'.{classVal}'
            elif(attr[0] == 'id'):
                self.query += f'#{attr[1]}'
            elif(attr[1] != None):
                self.queryAttributes += f'[{attr[0]}="{attr[1]}"]'

        qute_command(f":jseval document.querySelector('{self.query + self.queryAttributes}').focus()")
        qute_command(':enter-mode insert')
        qute_command(':open-editor')
        sys.exit(0) # Heh...

parser = HackyQueryBuilder()
parser.feed(html)
