#! /bin/bash

ToolDAQdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#cd ../
#make

export LD_LIBRARY_PATH=${ToolDAQdir}/ToolDAQFramework/lib:${ToolDAQdir}/boost_1_66_0/install/lib:${ToolDAQdir}/cgicc/lib:${ToolDAQdir}/zeromq-4.0.7/lib:$LD_LIBRARY_PATH
