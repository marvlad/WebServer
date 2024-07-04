#include <iostream>
#include <vector>  
#include <string>  
#include <stdio.h>  
#include <stdlib.h> 
#include <fstream>

#include "ServiceDiscovery.h"
#include "Store.h"
#include "zmq.hpp"

#include <boost/uuid/uuid.hpp>            // uuid class
#include <boost/uuid/uuid_generators.hpp> // generators
#include <boost/uuid/uuid_io.hpp>         // streaming operators etc.
#include <boost/date_time/posix_time/posix_time.hpp>
#include <boost/filesystem.hpp>

#include <libgen.h>  // dirname

using namespace std;

int main (int argc, char* argv[]){

  boost::uuids::uuid m_UUID=boost::uuids::random_generator()();
  long msg_id=0;
    
  zmq::context_t *context=new zmq::context_t(3);

  std::vector<Store*> RemoteServices;
  
  std::string address("239.192.1.1");

  int port=5000;

  std::cout<<"making service discovery class"<<std::endl;
  ServiceDiscovery *SD=new ServiceDiscovery(address,port,context,320);

  bool running=true;

  std::cout<<"connecting to inproc service discovery socket"<<std::endl;
  zmq::socket_t Ireceive (*context, ZMQ_DEALER);
  Ireceive.connect("inproc://ServiceDiscovery");

  std::cout<<"sleep for 7s"<<std::endl;
  sleep(7);

  zmq::message_t send(256);
  snprintf ((char *) send.data(), 256 , "%s" ,"All NULL") ;

  std::cout<<"sending request for list of services"<<std::endl;
  Ireceive.send(send);
      
  //Receive data about Services
  std::cout<<"receiving response"<<std::endl;
  zmq::message_t receive;
  Ireceive.recv(&receive);
  std::cout<<"parsing response"<<std::endl;
  std::istringstream iss(static_cast<char*>(receive.data()));

  int size;
  iss>>size;
  std::cout<<"SD found "<<size<<" services"<<std::endl;

  //Put all the services in RemoteServices vector
  RemoteServices.clear();
  for(int i=0;i<size;i++){

    Store *service = new Store;

    std::cout<<"\tgetting info on service "<<i<<"..."<<std::flush;
    zmq::message_t servicem;
    Ireceive.recv(&servicem);
    std::cout<<"done"<<std::endl;

    std::istringstream ss(static_cast<char*>(servicem.data()));
    service->JsonParser(ss.str());
    RemoteServices.push_back(service);

  }
  std::cout<<"generating output files"<<std::endl;
  // put them in the same directory as our application
  std::string outdir = dirname(argv[0]);
 
  //Get current warning state
  ifstream warnings_file((outdir+"/current_warnings.txt").c_str());
  bool warning_monitoring, warning_daq, warning_vme, warning_lappd;
  std::string temp_string;
  bool temp_warning;
  while (!warnings_file.eof()){
    warnings_file >> temp_string >> temp_warning;
    if (temp_string == "Monitoring") warning_monitoring = temp_warning;
    else if (temp_string == "DAQ") warning_daq = temp_warning;
    else if (temp_string == "VME") warning_vme = temp_warning;
    else if (temp_string == "LAPPD") warning_lappd = temp_warning;
  }
  warnings_file.close();
  
  /*std::cout <<"Warning Monitoring: "<<warning_monitoring<<std::endl;
  std::cout <<"Warning DAQ: "<<warning_daq<<std::endl;
  std::cout <<"Warning VME: "<<warning_vme<<std::endl;
  std::cout <<"Warning LAPPD: "<<warning_lappd<<std::endl;*/

  //Loop through RemoteServices, and print the ip, service, and status

  //Check if Monitoring service is present
  bool monitoring_present = 0;
  std::string monitoring_status = "None";
  std::string monitoring_ip = "None";
  bool daq_present = 0;
  std::string daq_status = "None";
  std::string daq_ip = "None";
  int vme_services = 0;
  std::vector<std::string> vme_ips;
  int lappd_services = 0;
  std::vector<std::string> lappd_ips;

  for(int i=0;i<RemoteServices.size();i++){

      std::string ip;
      std::string service;
      std::string status;
      
      ip=*((*(RemoteServices.at(i)))["ip"]);
      service=*((*(RemoteServices.at(i)))["msg_value"]);
      status=*((*(RemoteServices.at(i)))["status"]);

   //   std::cout<<"["<<i<<"]  "<<ip<<" , "<<service<<" , "<<status<<std::endl;
 
      if (service == "Monitoring") {
        monitoring_present = true;
        monitoring_status = status;
        monitoring_ip = ip;
      }
      if (service == "DAQ") {
        daq_present = true;
        daq_status = status;
        daq_ip = ip;
      }
      if (service == "VME"){
        vme_services ++;
        vme_ips.push_back(ip);
      }
      if (service == "LAPPD_Monitor_Service"){
        lappd_services ++;
        lappd_ips.push_back(ip);
      }
   
  }

  //Just for testing purposes
  /*
  monitoring_present = false;
  vme_services = 2;
  vme_ips.clear();
  daq_present = false;
  */

  //std::cout <<"Monitoring detected: "<<monitoring_present<<std::endl;
  //if (monitoring_present){
    //std::cout <<"Monitoring properties: "<<std::endl;
    //std::cout <<"Monitoring IP: "<<monitoring_ip<<std::endl;
    //std::cout <<"Monitoring Status: "<<monitoring_status<<std::endl;
  //}
  //std::cout <<"DAQ detected: "<<daq_present<<std::endl;
  //if (daq_present){
    //std::cout <<"DAQ properties: "<<std::endl;
    //std::cout <<"DAQ IP: "<<daq_ip<<std::endl;
    //std::cout <<"DAQ Status: "<<daq_status<<std::endl;
  //}  
  //std::cout <<"VME services: "<<vme_services<<std::endl;
  //std::cout <<"Running VME IPs: "<<std::endl;
  //for (int i=0; i< (int) vme_ips.size(); i++){
    //std::cout <<" >>> "<<vme_ips.at(i)<<" <<<"<<std::endl;
  //}

  //Get current time
  std::string current_time;
  current_time = boost::posix_time::to_iso_string(boost::posix_time::second_clock::local_time());
 
  ofstream error_file;
  error_file.open((outdir+"/services_errors.txt").c_str(),std::ios_base::app);
  if (monitoring_present) {
    warning_monitoring = 0;
    //error_file << current_time <<": All good, Monitoring service present"<<std::endl;
  }
  else {
    if (!warning_monitoring){
      error_file << "Monitoring: Did not find Monitoring process! Please contact Monitoring/DAQ/OPS experts"<<std::endl;
      warning_monitoring = 1;
    }
  }

  if (daq_present) {
    warning_daq = 0;
    //error_file << current_time << ": All good, DAQ service present"<<std::endl;
  }
  else {
    if (!warning_daq){
      error_file << "Monitoring: Did not find DAQ process! Please contact DAQ/OPS experts"<<std::endl;
      warning_daq = 1;
    }
  }

  if ((int) vme_ips.size() == 3) {
    warning_vme = 0;
    //error_file << current_time << ": All good with VME services"<<std::endl;
  }
  else {
    if (!warning_vme){
      error_file << "Monitoring: Did not detect 3 VME services! Please contact DAQ/OPS experts"<<std::endl;
      warning_vme = 1;
    }
  }
  error_file.close();

  //Warnings
  ofstream out_warnings_file((outdir+"/current_warnings.txt").c_str(),std::ofstream::trunc); 
  out_warnings_file << "Monitoring" << "    " << warning_monitoring << std::endl;
  out_warnings_file << "DAQ" << "    " << warning_daq << std::endl;
  out_warnings_file << "VME" << "    " << warning_vme << std::endl;
  out_warnings_file << "LAPPD" << "    " << warning_lappd << std::endl;
  out_warnings_file.close();

  //IPs
  ofstream out_ips((outdir+"/current_ips.txt").c_str(),std::ofstream::trunc);
  out_ips << "Monitoring" << "    " << monitoring_ip << std::endl;
  out_ips << "DAQ" << "    " << daq_ip << std::endl;
  for (int i_vme=0; i_vme < (int) vme_ips.size(); i_vme++){
    out_ips << "VME"<<i_vme+1<<"    " << vme_ips.at(i_vme)<<std::endl;
  }
  for (int i_lappd=0; i_lappd < (int) lappd_ips.size(); i_lappd++){
    out_ips << "LAPPD"<<i_lappd+1<<"    " << lappd_ips.at(i_lappd)<<std::endl;
  }
  out_ips.close();

  //Current status (run number, evt numbers...)
  if (daq_status != "None"){
  size_t position_camac = daq_status.find("CAMAC=");
  size_t position_lappd = daq_status.find("LAPPD=");
  size_t position_trig = daq_status.find("Trig=");
  size_t position_vme = daq_status.find("VME=");
  size_t position_run = daq_status.find("R:S:P=");
  
  std::string substr_camac=daq_status.substr(position_camac+6);
  std::string substr_lappd=daq_status.substr(position_lappd+6);
  std::string substr_trig=daq_status.substr(position_trig+5);
  std::string substr_vme=daq_status.substr(position_vme+4);
  std::string substr_run=daq_status.substr(position_run+6);

  size_t position_camac_end = substr_camac.find(":");
  size_t position_lappd_end = substr_lappd.find(":");
  size_t position_trig_end = substr_trig.find(":");
  size_t position_vme_end = substr_vme.find(":");
  size_t position_run_end = substr_run.find(":");

  std::string events_camac=substr_camac.substr(0,position_camac_end);
  std::string events_lappd=substr_lappd.substr(0,position_lappd_end);
  std::string events_trig=substr_trig.substr(0,position_trig_end);
  std::string events_vme=substr_vme.substr(0,position_vme_end);
  std::string run_nr=substr_run.substr(0,position_run_end);

  std::string substr_subrun=substr_run.substr(position_run_end+1);
  size_t position_subrun_end = substr_subrun.find(":");
  std::string subrun_nr = substr_subrun.substr(0,position_subrun_end);
  std::string part_nr = substr_subrun.substr(position_subrun_end+1);

  ofstream out_status((outdir+"/current_status.txt").c_str(),std::ofstream::trunc);
  out_status << "Run" << "    " << run_nr << std::endl;
  out_status << "SubRun" << "    " << subrun_nr << std::endl;
  out_status << "Part" << "    " << part_nr << std::endl;
  out_status << "VME" << "    " << events_vme << std::endl;
  out_status << "CAMAC" << "    " << events_camac << std::endl;
  out_status << "LAPPD" << "    " << events_lappd << std::endl;
  out_status << "Trig" << "    " << events_trig << std::endl;
  out_status.close();

  ofstream out_run((outdir+"/current_run.txt").c_str(),std::ofstream::trunc);
  out_run << run_nr << std::endl;
  out_run.close();
  }

  return 0;
}
