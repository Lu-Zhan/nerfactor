#!/usr/bin/env bash

# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

if [ $# -lt 4 ]; then
    echo "Usage: $0 scene_dir h n_vali outroot[ ...]"
    exit 1
fi
scene_dir="$1"
h="$2"
n_vali="$3"
outroot="$4"
shift # shift the remaining arguments
shift
shift
shift

PYTHONPATH="$REPO_DIR" \
    python "$REPO_DIR"/data_gen/real/make_dataset.py \
    --scene_dir="$scene_dir" \
    --h="$h" \
    --n_vali="$n_vali" \
    --outroot="$outroot" \
    "$@"
