#!/usr/bin/env python

# Copyright (c) 2011 Google Inc. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""Confirms presence of files generated by our targets we depend on.
If they exist, create a new file.

Note target's input files are explicitly NOT defined in the gyp file
so they can't easily be passed to this script as args.
"""

import os
import sys

outfile = sys.argv[1]  # Example value we expect: deps_all_done_first_123.txt
if (os.path.exists("dep_1.txt") and
    os.path.exists("dep_2.txt") and
    os.path.exists("dep_3.txt")):
  open(outfile, "w")
