#!/bin/bash

echo 'source /root/ros_catkin_ws/install/setup.bash' >> ~/.bashrc
echo 'source /root/ros_catkin_ws/devel/setup.bash' >> ~/.bashrc

# byobu new-session glances \; split-window -d -h htop \; select-pane -t 1 \; split-window -d \; select-pane -t 2

# byobu-tmux new-session -d glances
# byobu-tmux split-window -d -h htop
# byobu-tmux attach

# source /root/ros_catkin_ws/install/setup.sh
# source /root/ros_catkin_ws/devel/setup.sh

byobu new-session -d -n 'ros' 'roscore; $SHELL'
byobu split-window -d 'top; $SHELL'
sleep 1;
byobu split-window -d -h 'roslaunch ros_infinite_loop test.launch; $SHELL'

# Fix the annoying byobu display
echo "tmux_left=\"session\"" > $HOME/.byobu/status
echo "tmux_right=\"load_average disk_io date time\"" >> $HOME/.byobu/status
tmux attach

echo "Started"
$SHELL
