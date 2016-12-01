FROM ubuntu:xenial

# setup environment
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

# setup keys
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list

# install bootstrap
#   and dev tools
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        python-catkin-tools  \
        python-rosdep \
        python-rosinstall-generator \
        python-wstool \
            bash-completion \
            byobu \
            git \
            htop \
            less \
            tree \
            wget \
            python-pip && \
    rm -rf /var/lib/apt/lists/*

# set envormetn and workspace
ENV ROS_DISTRO kinetic
ENV CATKIN_WS=/root/ros_catkin_ws
RUN mkdir -p $CATKIN_WS/src
WORKDIR $CATKIN_WS/src

# download sourcecode for ros
RUN rosinstall_generator \
      ros_comm \
      roscpp \
      rospy_tutorials \
      --rosdistro ${ROS_DISTRO} \
      --deps \
      --tar > ${ROS_DISTRO}-ros_comm-wet.rosinstall && \
    wstool init -j8 . ${ROS_DISTRO}-ros_comm-wet.rosinstall && \
    rm -rf ros_comm && \
    git clone -b patch-1 https://github.com/ruffsl/ros_comm.git && \
    git clone -b patch-1 https://github.com/ruffsl/ros_infinite_loop.git

# install dependencies
RUN apt-get update && \
    rosdep init && \
    rosdep update && \
    rosdep install -y \
      --from-paths . \
      --ignore-src \
      --rosdistro ${ROS_DISTRO} \
      --as-root=apt:false && \
    rm -rf /var/lib/apt/lists/*

# HACK, replacing shell with bash for later docker build commands
RUN mv /bin/sh /bin/sh-old && \
    ln -s /bin/bash /bin/sh

# build repo
WORKDIR $CATKIN_WS
ENV TERM xterm
ENV PYTHONIOENCODING UTF-8
RUN catkin config --install && \
    catkin build --no-status --summarize
RUN catkin config --no-install && \
    catkin build --no-status --summarize

# setup entrypoint
COPY ./ros_entrypoint.sh /
COPY ./ros_infinite_loop.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
# docker run --rm -it ros:loop /ros_infinite_loop.sh
