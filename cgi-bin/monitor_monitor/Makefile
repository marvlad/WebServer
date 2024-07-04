ToolDAQ=/setup

all:
	#g++ -Wl,--verbose check_services.cpp -o check_services -L ./setup/ToolDAQFramework/lib -lStore -lServiceDiscovery -L ./setup/cgicc/lib -lcgicc  -I /usr/local/include -I ./setup/ToolDAQFramework/include -I ./setup/boost_1_66_0/install/include/  -I ./setup/zeromq-4.0.7/include -L ./setup/boost_1_66_0/install/lib  -lboost_date_time -lboost_serialization  -lboost_iostreams  -L ./setup/zeromq-4.0.7/lib -lzmq -lboost_filesystem -lboost_system
	g++ -std=c++11 check_services.cpp -o check_services -L $(ToolDAQ)/ToolDAQFramework/lib -lServiceDiscovery -lStore -L $(ToolDAQ)/cgicc/lib -lcgicc  -I /usr/local/include -I $(ToolDAQ)/ToolDAQFramework/include -I $(ToolDAQ)/boost_1_66_0/install/include/  -I $(ToolDAQ)/zeromq-4.0.7/include -L $(ToolDAQ)/boost_1_66_0/install/lib  -lboost_date_time -lboost_serialization  -lboost_iostreams  -L $(ToolDAQ)/zeromq-4.0.7/lib -lzmq -lboost_filesystem -lboost_system
