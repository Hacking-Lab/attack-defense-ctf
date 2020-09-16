#!/usr/bin/env python3

import os
import sys


if __name__ == '__main__':
    sys.path.append('/opt/game/repo/src')
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'prod_settings')

    from django.core.management import execute_from_command_line
    execute_from_command_line(sys.argv)
