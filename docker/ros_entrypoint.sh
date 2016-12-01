#!/bin/bash
set -e

# setup ros environment
source "/root/ros_catkin_ws/devel/setup.bash"
exec "$@"
