##############################################################################
##                                 Base Image                               ##
##############################################################################
ARG ROS_DISTRO=foxy
FROM osrf/ros:$ROS_DISTRO-desktop
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

##############################################################################
##                                 Global Dependecies                       ##
##############################################################################
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV LC_ALL=C

RUN apt-get update && apt-get install --no-install-recommends -y \
    bash nano htop git sudo wget curl gedit pip && \
    rm -rf /var/lib/apt/lists/*

##############################################################################
##                                 Create User                              ##
##############################################################################
ARG USER=robot
ARG PASSWORD=robot
ARG UID=1000
ARG GID=1000
ARG DOMAIN_ID=0
ENV UID=${UID}
ENV GID=${GID}
ENV USER=${USER}
RUN groupadd -g "$GID" "$USER"  && \
    useradd -m -u "$UID" -g "$GID" --shell $(which bash) "$USER" -G sudo && \
    echo "$USER:$PASSWORD" | chpasswd && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/sudogrp

RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> /etc/bash.bashrc
RUN echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> /etc/bash.bashrc
RUN echo "export _colcon_cd_root=~/ros2_install" >> /etc/bash.bashrc
RUN echo "export ROS_DOMAIN_ID=${DOMAIN_ID}" >> /etc/bash.bashrc

USER $USER 
RUN rosdep update

#RUN mkdir -p /home/"$USER"/ws_moveit2/src
#RUN cd /home/"$USER"/ws_moveit2/src && git clone https://github.com/ros-planning/moveit2.git -b foxy && vcs import < moveit2/moveit2.repos && rosdep install -r --from-paths . --ignore-src --rosdistro foxy -y

#RUN cd /home/"$USER"/ws_moveit2/src/geometric_shapes && git checkout foxy
#RUN cd /home/$USER/ws_moveit2 && . /opt/ros/$ROS_DISTRO/setup.sh && colcon build --event-handlers desktop_notification- status- --cmake-args -DCMAKE_BUILD_TYPE=Release

#USER root
#RUN DEBIAN_FRONTEND=noninteractive \
#	apt update && \
#	apt install -y ros-$ROS_DISTRO-moveit ros-$ROS_DISTRO-rqt*
#RUN DEBIAN_FRONTEND=noninteractive \
#	apt update && \
#	apt install -y ros-$ROS_DISTRO-xacro ros-$ROS_DISTRO-joint-trajectory-controller ros-$ROS_DISTRO-joint-state-broadcaster
##############################################################################
##                                 User Dependecies                         ##
##############################################################################


##############################################################################
##                                 Build ROS and run                        ##
##############################################################################
USER $USER 
RUN mkdir -p /home/"$USER"/ros_ws/src
RUN cd /home/"$USER"/ros_ws && colcon build
RUN echo "source /home/$USER/ros_ws/install/setup.bash" >> /home/$USER/.bashrc

WORKDIR /home/$USER/ros_ws

CMD /bin/bash