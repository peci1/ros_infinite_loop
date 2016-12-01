#!/bin/bash
set -e

# setup ros environment
source "/root/ros_catkin_ws/install/setup.bash"
exec "$@"
