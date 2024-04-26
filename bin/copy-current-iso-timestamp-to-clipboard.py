#!/usr/bin/env python
from datetime import datetime

import clipboard


if __name__ == "__main__":
    clipboard.copy(datetime.now().astimezone().isoformat(timespec="seconds"))
