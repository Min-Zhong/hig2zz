#!/usr/bin/env bash

# Main driver to submit jobs 
# Author Ryuta Kiuchi <kiuchi@ihep.ac.cn> and Konglingteng <konglingteng15@mails.ucas.ac.cn>
# Created [2018-06-16 Sat 16:00] 

usage() {
	printf "NAME\n\tsubmit.sh - Main driver to submit jobs\n"
	printf "\nSYNOPSIS\n"
	printf "\n\t%-5s\n" "./submit.sh [OPTION]" 
	printf "\n\start event_sel in 1.1.6 1.2.7 1.3.7\n" 
	printf "\nOPTIONS\n" 
        printf "\n\t%-9s  %-40s"  "1"      "[run Z(->ll)H(->ZZ*) channel]"
        printf "\n\t%-9s  %-40s"  "2"      "[run Z(->nn)H(->ZZ*) channel]"
        printf "\n\t%-9s  %-40s"  "3"      "[run Z(->qq)H(->ZZ*) channel]"
        printf "\n\n"
	printf "\nDATE\n"
	printf "\n\t%-5s\n" "AUGUST 2019" 
}

usage_1() {
        printf "\n\t%-9s  %-40s"  "1.1"      "[run Z(->mumu)H(->ZZ*->nnjj) sample]"
        printf "\n\t%-9s  %-40s"  "1.2"      "[run Z(->ll,qq,nn)H(->inclusive) background sample]"
        printf "\n\t%-9s  %-40s"  "1.3"      "[run background sample]"
        printf "\n\t%-9s  %-40s"  "1.4"      "[plot pictures and save results]"
}

usage_2() {
        printf "\n\t%-9s  %-40s"  "2.1"      "[run Z(->nn)H(->ZZ*->mumujj) sample]"
        printf "\n\t%-9s  %-40s"  "2.2"      "[run Z(->ll,qq,nn)H(->inclusive) background sample]"
        printf "\n\t%-9s  %-40s"  "2.3"      "[run background sample]"
        printf "\n\t%-9s  %-40s"  "2.4"      "[plot pictures and save results]"
}

usage_3() {
        printf "\n\t%-9s  %-40s"  "3.1"      "[run Z(->qq)H(->ZZ*->nnmumu) sample]"
        printf "\n\t%-9s  %-40s"  "3.2"      "[run Z(->ll,qq,nn)H(->inclusive) background sample]"
        printf "\n\t%-9s  %-40s"  "3.3"      "[run background sample]"
        printf "\n\t%-9s  %-40s"  "3.4"      "[plot pictures and save results]"
}

usage_1_1() { 
	printf "\n\t%-9s  %-40s"  "1.1"      "[run signal sample]" 
	printf "\n\t%-9s  %-40s"  "1.1.1"    "Split signal sample with each group 0.5G" 
	printf "\n\t%-9s  %-40s"  "1.1.2"    "Generate XML input files for Marlin job" 
	printf "\n\t%-9s  %-40s"  "1.1.3"    "Run with a few events" 
	printf "\n\t%-9s  %-40s"  "1.1.4"    "Generate Condor job scripts for pre-selection" 
	printf "\n\t%-9s  %-40s"  "1.1.5"    "Submit Condor jobs for pre-selection on signal" 
	printf "\n\t%-9s  %-40s"  "1.1.6"    "Select events on signal (with a small sample)" 
	printf "\n\t%-9s  %-40s"  "1.1.7"    "Generate Condor job scripts for event selection" 	
	printf "\n\t%-9s  %-40s"  "1.1.8"    "Submit Condor jobs for event selection on signal" 
	printf "\n\t%-9s  %-40s"  "1.1.9"    "Merge event root files" 
}

usage_2_1() {
        printf "\n\t%-9s  %-40s"  "2.1"      "[run signal sample]"
        printf "\n\t%-9s  %-40s"  "2.1.1"    "Split signal sample with each group 0.5G"
        printf "\n\t%-9s  %-40s"  "2.1.2"    "Generate XML input files for Marlin job"
        printf "\n\t%-9s  %-40s"  "2.1.3"    "Run with a few events"
        printf "\n\t%-9s  %-40s"  "2.1.4"    "Generate Condor job scripts for pre-selection"
        printf "\n\t%-9s  %-40s"  "2.1.5"    "Submit Condor jobs for pre-selection on signal"
        printf "\n\t%-9s  %-40s"  "2.1.6"    "Select events on signal (with a small sample)"
        printf "\n\t%-9s  %-40s"  "2.1.7"    "Generate Condor job scripts for event selection"
        printf "\n\t%-9s  %-40s"  "2.1.8"    "Submit Condor jobs for event selection on signal"
        printf "\n\t%-9s  %-40s"  "2.1.9"    "Merge event root files"
}

usage_3_1() {
        printf "\n\t%-9s  %-40s"  "3.1"      "[run signal sample]"
        printf "\n\t%-9s  %-40s"  "3.1.1"    "Split signal sample with each group 0.5G"
        printf "\n\t%-9s  %-40s"  "3.1.2"    "Generate XML input files for Marlin job"
        printf "\n\t%-9s  %-40s"  "3.1.3"    "Run with a few events"
        printf "\n\t%-9s  %-40s"  "3.1.4"    "Generate Condor job scripts for pre-selection"
        printf "\n\t%-9s  %-40s"  "3.1.5"    "Submit Condor jobs for pre-selection on signal"
        printf "\n\t%-9s  %-40s"  "3.1.6"    "Select events on signal (with a small sample)"
        printf "\n\t%-9s  %-40s"  "3.1.7"    "Generate Condor job scripts for event selection"
        printf "\n\t%-9s  %-40s"  "3.1.8"    "Submit Condor jobs for event selection on signal"
        printf "\n\t%-9s  %-40s"  "3.1.9"    "Merge event root files"
}

usage_1_2() { 
	printf "\n" 
	printf "\n\t%-9s  %-40s"  "1.2"      "[run Z(->ff)H(->inclusive) sample]" 
	printf "\n\t%-9s  %-40s"  "1.2.1"    "Split ZH sample with each group 1G" 
	printf "\n\t%-9s  %-40s"  "1.2.2"    "Generate XML input files for Marlin job" 
	printf "\n\t%-9s  %-40s"  "1.2.3"    "Check the number files" 
	printf "\n\t%-9s  %-40s"  "1.2.4"    "Run with a few events" 
	printf "\n\t%-9s  %-40s"  "1.2.5"    "Generate Condor job scripts for pre-selection" 
	printf "\n\t%-9s  %-40s"  "1.2.6"    "Submit Condor jobs for pre-selection on ZH sample" 
	printf "\n\t%-9s  %-40s"  "1.2.7"    "Select events on ZH sample (with a small sample)"
	printf "\n\t%-9s  %-40s"  "1.2.8"    "Generate Condor job scripts for event selection" 	
	printf "\n\t%-9s  %-40s"  "1.2.9"    "Submit Condor jobs for event selection on ZH sample" 
	printf "\n\t%-9s  %-40s"  "1.2.10"   "Merge event root files" 
}

usage_2_2() {
        printf "\n"
        printf "\n\t%-9s  %-40s"  "2.2"      "[run Z(->ll,qq,nn)H(->inclusive) sample]"
        printf "\n\t%-9s  %-40s"  "2.2.1"    "Split ZH sample with each group 1G"
        printf "\n\t%-9s  %-40s"  "2.2.2"    "Generate XML input files for Marlin job"
        printf "\n\t%-9s  %-40s"  "2.2.3"    "Check the number files"
        printf "\n\t%-9s  %-40s"  "2.2.4"    "Run with a few events"
        printf "\n\t%-9s  %-40s"  "2.2.5"    "Generate Condor job scripts for pre-selection"
        printf "\n\t%-9s  %-40s"  "2.2.6"    "Submit Condor jobs for pre-selection on ZH sample"
        printf "\n\t%-9s  %-40s"  "2.2.7"    "Select events on ZH sample (with a small sample)"
        printf "\n\t%-9s  %-40s"  "2.2.8"    "Generate Condor job scripts for event selection"
        printf "\n\t%-9s  %-40s"  "2.2.9"    "Submit Condor jobs for event selection on ZH sample"
        printf "\n\t%-9s  %-40s"  "2.2.10"   "Merge event root files"
}

usage_3_2() {
        printf "\n"
        printf "\n\t%-9s  %-40s"  "3.2"      "[run Z(->ll,qq,nn)H(->inclusive) sample]"
        printf "\n\t%-9s  %-40s"  "3.2.1"    "Split ZH sample with each group 1G"
        printf "\n\t%-9s  %-40s"  "3.2.2"    "Generate XML input files for Marlin job"
        printf "\n\t%-9s  %-40s"  "3.2.3"    "Check the number files"
        printf "\n\t%-9s  %-40s"  "3.2.4"    "Run with a few events"
        printf "\n\t%-9s  %-40s"  "3.2.5"    "Generate Condor job scripts for pre-selection"
        printf "\n\t%-9s  %-40s"  "3.2.6"    "Submit Condor jobs for pre-selection on ZH sample"
        printf "\n\t%-9s  %-40s"  "3.2.7"    "Select events on ZH sample (with a small sample)"
        printf "\n\t%-9s  %-40s"  "3.2.8"    "Generate Condor job scripts for event selection"
        printf "\n\t%-9s  %-40s"  "3.2.9"    "Submit Condor jobs for event selection on ZH sample"
        printf "\n\t%-9s  %-40s"  "3.2.10"   "Merge event root files"
}

usage_1_3() { 
	printf "\n" 
	printf "\n\t%-9s  %-40s"  "1.3"      "[run background sample]" 
	printf "\n\t%-9s  %-40s"  "1.3.1"    "Split background sample with each group 20G" 
	printf "\n\t%-9s  %-40s"  "1.3.2"    "Generate XML input files for Marlin job" 
	printf "\n\t%-9s  %-40s"  "1.3.3"    "Check the number files" 
	printf "\n\t%-9s  %-40s"  "1.3.4"    "Run with a few events" 
	printf "\n\t%-9s  %-40s"  "1.3.5"    "Generate Condor job scripts for pre-selection" 
	printf "\n\t%-9s  %-40s"  "1.3.6"    "Submit Condor jobs for pre-selection on Bg sample" 
	printf "\n\t%-9s  %-40s"  "1.3.7"    "Select events on background (with a small sample)"
	printf "\n\t%-9s  %-40s"  "1.3.8"    "Generate Condor job scripts for event selection" 	
	printf "\n\t%-9s  %-40s"  "1.3.9"    "Submit Condor jobs for event selection on Bg sample" 
	printf "\n\t%-9s  %-40s"  "1.3.10"    "Merge event root files" 
}

usage_2_3() {
        printf "\n"
        printf "\n\t%-9s  %-40s"  "2.3"      "[run background sample]"
        printf "\n\t%-9s  %-40s"  "2.3.1"    "Split background sample with each group 20G"
        printf "\n\t%-9s  %-40s"  "2.3.2"    "Generate XML input files for Marlin job"
        printf "\n\t%-9s  %-40s"  "2.3.3"    "Check the number files"
        printf "\n\t%-9s  %-40s"  "2.3.4"    "Run with a few events"
        printf "\n\t%-9s  %-40s"  "2.3.5"    "Generate Condor job scripts for pre-selection"
        printf "\n\t%-9s  %-40s"  "2.3.6"    "Submit Condor jobs for pre-selection on Bg sample"
        printf "\n\t%-9s  %-40s"  "2.3.7"    "Select events on background (with a small sample)"
        printf "\n\t%-9s  %-40s"  "2.3.8"    "Generate Condor job scripts for event selection"
        printf "\n\t%-9s  %-40s"  "2.3.9"    "Submit Condor jobs for event selection on Bg sample"
        printf "\n\t%-9s  %-40s"  "2.3.10"    "Merge event root files"
}

usage_3_3() {
        printf "\n"
        printf "\n\t%-9s  %-40s"  "3.3"      "[run background sample]"
        printf "\n\t%-9s  %-40s"  "3.3.1"    "Split background sample with each group 20G"
        printf "\n\t%-9s  %-40s"  "3.3.2"    "Generate XML input files for Marlin job"
        printf "\n\t%-9s  %-40s"  "3.3.3"    "Check the number files"
        printf "\n\t%-9s  %-40s"  "3.3.4"    "Run with a few events"
        printf "\n\t%-9s  %-40s"  "3.3.5"    "Generate Condor job scripts for pre-selection"
        printf "\n\t%-9s  %-40s"  "3.3.6"    "Submit Condor jobs for pre-selection on Bg sample"
        printf "\n\t%-9s  %-40s"  "3.3.7"    "Select events on background (with a small sample)"
        printf "\n\t%-9s  %-40s"  "3.3.8"    "Generate Condor job scripts for event selection"
        printf "\n\t%-9s  %-40s"  "3.3.9"    "Submit Condor jobs for event selection on Bg sample"
        printf "\n\t%-9s  %-40s"  "3.3.10"    "Merge event root files"
}

usage_1_4() { 
	printf "\n" 
	printf "\n\t%-9s  %-40s"  "1.4"      "[plot pictures and save results]" 
	printf "\n\t%-9s  %-40s"  "1.4.1"    "Plot signal-bg histograms..." 
	printf "\n\t%-9s  %-40s"  "1.4.2"    "Plot information..." 
	printf "\n\t%-9s  %-40s"  "1.4.3"    "Generate tables and LaTex tables..."
	printf "\n\t%-9s  %-40s"  "1.4.4"    "Save results..." 
	printf "\n\t%-9s  %-40s"  "1.4.5"    "fit results..."
        printf "\n\t%-9s  %-40s"  "1.4.6"    "move repository for another channel"
}

usage_2_4() {
        printf "\n"
        printf "\n\t%-9s  %-40s"  "2.4"      "[plot pictures and save results]"
        printf "\n\t%-9s  %-40s"  "2.4.1"    "Plot signal-bg histograms..."
        printf "\n\t%-9s  %-40s"  "2.4.2"    "Plot information..."
        printf "\n\t%-9s  %-40s"  "2.4.3"    "Generate tables and LaTex tables..."
        printf "\n\t%-9s  %-40s"  "2.4.4"    "Save results..."
        printf "\n\t%-9s  %-40s"  "2.4.5"    "fit results..."
}

usage_3_4() {
        printf "\n"
        printf "\n\t%-9s  %-40s"  "3.4"      "[plot pictures and save results]"
        printf "\n\t%-9s  %-40s"  "3.4.1"    "Plot signal-bg histograms..."
        printf "\n\t%-9s  %-40s"  "3.4.2"    "Plot information..."
        printf "\n\t%-9s  %-40s"  "3.4.3"    "Generate tables and LaTex tables..."
        printf "\n\t%-9s  %-40s"  "3.4.4"    "Save results..."
        printf "\n\t%-9s  %-40s"  "3.4.5"    "fit results..."
        printf "\n\t%-9s  %-40s"  "3.4.6"    "move repository for another channel"
}

if [[ $# -eq 0 ]]; then
    usage
    echo "Please enter your option: "
    read option
else
    option=$1    
fi

signal_slcio_dir_ll=/cefs/data/DstData/CEPC240/CEPC_v4/higgs/E240.Pe2e2h_zz.e0.p0.whizard195

signal_slcio_dir_nn=/cefs/data/DstData/CEPC240/CEPC_v4/higgs/E240.Pnnh_zz.e0.p0.whizard195

signal_slcio_dir_qq=/cefs/data/DstData/CEPC240/CEPC_v4/higgs/E240.Pqqh_zz.e0.p0.whizard195

sel_all=0
sel_signal=1
sel_bg=2
channel_opt_ll=1  #1 for hvvjj, 2 for hjjvv
channel_opt_nn=1
channel_opt_qq=1  #1 for hvvmm, 2 for hmmvv
llhzz=1
nnhzz=2
qqhzz=3

    # --------------------------------------------------------------------------
    #  1.1 Signal   
    # --------------------------------------------------------------------------

sub_1_1(){
case $option in 

    1.1) echo "Running on signal sample..."
         ;;

    1.1.1) echo "Split signal sample with each group 0.5G..."
	   mkdir -p   ./run/channel_ll/llh2zz/samples
           ./python/get_samples.py  ${signal_slcio_dir_ll} ./run/channel_ll/llh2zz/samples/E240_Pllh_zz.txt 0.5G
           ;;

    1.1.2) echo "Generate XML input files for Marlin job..."
	   mkdir -p   ./run/channel_ll/llh2zz/steers 
	   mkdir -p   ./run/channel_ll/llh2zz/steers/test 
	   mkdir -p   ./run/channel_ll/llh2zz/ana
           ./python/gen_steerfiles.py ./table/template_jobfile.xml ./run/channel_ll/llh2zz/samples ./run/channel_ll/llh2zz/steers ./run/channel_ll/llh2zz/ana/ana_File.root ${llhzz}
           ;;

    1.1.3) echo "Run with a few events ..."
	   source setup.sh
	   ./build.sh
	   Marlin ./run/channel_ll/llh2zz/steers/test/sample-1.xml
           ;;
    
    1.1.4) echo "Generate Condor job scripts..."
	   mkdir -p  ./run/channel_ll/llh2zz/condor/script/marlin
           ./python/gen_condorscripts.py ${channel_opt_ll} 1 ./run/channel_ll/llh2zz/steers ./run/channel_ll/llh2zz/condor ${sel_signal} ${llhzz}
           ;;

    1.1.5) echo "Submit Condor jobs for pre-selection on signal..."
           if [ ${channel_opt_ll} = 1 ]; then
               cd ./run/channel_ll/llh2zz/condor
               mkdir -p log
               ./condor_submit.sh
           else 
               echo "Use the same ntuples as vvjj channel..."
           fi
           ;;

    1.1.6) echo "Select events on signal (with a small sample)..."
	   rm -rf ./run/channel_ll/llh2zz/events
	   mkdir -p   ./run/channel_ll/llh2zz/events/ana
           ./python/sel_events.py  ${channel_opt_ll} ./run/channel_ll/llh2zz/ana/ana_File-1.root  ./run/channel_ll/llh2zz/events/ana/ana_File-1_event.root ${sel_signal} ${llhzz}
           ;;

    1.1.7) echo "Generate Condor job scripts for event selection..."
	   mkdir -p   ./run/channel_ll/llh2zz/events/ana
	   rm -rf ./run/channel_ll/llh2zz/condor/script/eventsel
           mkdir -p   ./run/channel_ll/llh2zz/condor/script/eventsel
	   ./python/gen_condorscripts.py ${channel_opt_ll} 2  ./run/channel_ll/llh2zz/ana ./run/channel_ll/llh2zz/condor  ${sel_signal} ${llhzz}
           ;;

    1.1.8) echo "Submit Condor jobs for event selection on signal..."
           cd ./run/channel_ll/llh2zz/condor
	   rm -rf log/events
	   mkdir -p log/events
	   ./condor_submit_eventsel.sh
           ;;

    1.1.9) echo  "Merge event root files..."
	   rm -rf ./run/channel_ll/llh2zz/hist
           mkdir -p   ./run/channel_ll/llh2zz/hist
           ./python/mrg_rootfiles.py  ./run/channel_ll/llh2zz/events/ana  ./run/channel_ll/llh2zz/hist 
           ;; 


    esac
}

    # --------------------------------------------------------------------------
    #  1.2 ZH Inclusive Sample   
    # --------------------------------------------------------------------------

sub_1_2(){
case $option in 

    1.2) echo "Running on ZH inclusive sample..."
         ;;

    1.2.1) echo "Split background sample with each group 1G..."
	   mkdir -p   ./run/channel_ll/zh/samples
	   ./python/get_bg_samples.py ./table/zh_sample_list.txt ./run/channel_ll/zh/samples 1G
           ;;

    1.2.2) echo "Generate XML input files for Marlin job..."
	   mkdir -p   ./run/channel_ll/zh/steers 
	   mkdir -p   ./run/channel_ll/zh/ana

           ./python/gen_bg_steerfiles.py ./table/zh_sample_list.txt ./table/template_jobfile.xml  ./run/channel_ll/zh/samples  ./run/channel_ll/zh/steers  ./run/channel_ll/zh/ana
           ;;

    1.2.3) echo "Check statistics : print the number of files..."
	   ./python/check_stat.py  ./table/zh_sample_list.txt ./run/channel_ll/zh/samples 
	   ;;
	   
    1.2.4) echo "Run with a few events ..."
	   source setup.sh
	   ./build.sh
	   cd ./run/channel_ll/zh/steers/

	   array=("e2e2h_zz")
	   for dir in "${array[@]}"
	   do
	       cd ${dir}/test
	       Marlin sample-1.xml
	       cd ../../
	   done
           ;;

    1.2.5) echo "Generate Condor job scripts..."
	   mkdir -p   ./run/channel_ll/zh/condor

	   cd ./run/channel_ll/zh/ana/
	   for dir in *
	   do
	       mkdir -p ../condor/$dir
	   done

	   cd ../condor/
	   for dir in *
	   do
	       cd $dir
	       rm -rf log/marlin
	       rm -rf script/marlin
	       mkdir -p log/marlin
	       mkdir -p script/marlin
	       cd ../
	   done

	   cd ../../../../
           ./python/gen_bg_condorscripts.py ${channel_opt_ll} 1  ./run/channel_ll/zh/steers ./run/channel_ll/zh/condor  ${sel_signal} ${llhzz}
           ;;

    1.2.6) echo "Submit Condor jobs for pre-selection on background sample..."
	   echo " ---- "
           if [ ${channel_opt_ll} = 1 ]; then
               cd ./run/channel_ll/llh2zz/condor
               mkdir -p log
               ./condor_submit.sh

               echo "Please enter the number of jobs for each ZH sample (default: 120)" 
               read njob
               if [ -z $njob ]; then
	           njob=120
               fi
	   
               cd ./run/channel_ll/zh/condor
               for dir in *
	       do
	           cd $dir
	           echo `pwd`
                   ./condor_submit.sh $njob
	           cd ../
               done
           else
               echo "Use the same ntuples as vvjj channel..."
           fi
           ;;

    1.2.7) echo "Select events on background (with a small sample)..."
	   rm -rf ./run/channel_ll/zh/events
	   mkdir -p   ./run/channel_ll/zh/events/ana
	   cd ./run/channel_ll/zh/ana
	   for dir in *
	   do
	       mkdir -p ../events/ana/$dir
	   done
	   cd ../../../../

           ./python/sel_events.py  ${channel_opt_ll} ./run/channel_ll/zh/ana/e2e2h_gg/ana_File-1.root  ./run/channel_ll/zh/events/ana/e2e2h_gg/ana_File-1_event.root ${sel_bg} ${llhzz}
           ;;

    1.2.8) echo "Generate Condor job scripts for event selection..."
	   mkdir -p   ./run/channel_ll/zh/events/ana
	   cd ./run/channel_ll/zh/ana
	   for dir in *
	   do
	       mkdir -p ../events/ana/$dir
	   done

	   cd ../condor/
	   for dir in *
	   do
	       cd $dir
	       rm -rf log/events
	       rm -rf script/eventsel
	       mkdir -p log/events
	       mkdir -p script/eventsel
	       cd ../
	   done
	   
	   cd ../../../../
	   ./python/gen_bg_condorscripts.py ${channel_opt_ll}  2  ./run/channel_ll/zh/ana ./run/channel_ll/zh/condor  ${sel_bg} ${llhzz}
           ;;

    1.2.9) echo "Submit Condor jobs for evt-selection on ZH sample..."
           cd ./run/channel_ll/zh/condor
	   for dir in *
	   do
	       cd $dir
	       echo `pwd`
	       ./condor_submit_eventsel.sh 
	       cd ../
	   done
           ;;

    1.2.10) echo  "Merge event root files..."
		   rm -rf ./run/channel_ll/zh/hist
           mkdir -p   ./run/channel_ll/zh/hist
	   cd ./run/channel_ll/zh/events/ana
	   for dir in *
	   do
	       mkdir -p ../../hist/$dir
	       cd ../../../../../

	       ./python/mrg_rootfiles.py  ./run/channel_ll/zh/events/ana/$dir  ./run/channel_ll/zh/hist/$dir
	       cd ./run/channel_ll/zh/events/ana	       
	   done
           ;; 

    esac
}

    # --------------------------------------------------------------------------
    #  1.3 Background Sample   
    # --------------------------------------------------------------------------

sub_1_3(){
case $option in 

    1.3) echo "Running on background sample..."
         ;;

    1.3.1) echo "Split background sample with each group 20G..."
	   mkdir -p   ./run/channel_ll/bg/samples
	   ./python/get_bg_samples.py ./table/bg_sample_list.txt ./run/channel_ll/bg/samples 20G
           ;;

    1.3.2) echo "Generate XML input files for Marlin job..."
	   mkdir -p   ./run/channel_ll/bg/steers 
	   mkdir -p   ./run/channel_ll/bg/ana

           ./python/gen_bg_steerfiles.py ./table/bg_sample_list.txt ./table/template_jobfile.xml  ./run/channel_ll/bg/samples  ./run/channel_ll/bg/steers  ./run/channel_ll/bg/ana
           ;;

    1.3.3) echo "Check statistics : print the number of files..."
	   ./python/check_stat.py  ./table/bg_sample_list.txt ./run/channel_ll/bg/samples 
	   ;;
	   
    1.3.4) echo "Run with a few events ..."
	   source setup.sh
	   ./build.sh
	   cd ./run/channel_ll/bg/steers/

	   array=("e3e3" "qq" "sznu_sl0nu_down" "sze_sl0uu" "ww_sl0muq" "zz_sl0mu_down")
	   for dir in "${array[@]}"
	   do
	       cd ${dir}/test
	       Marlin sample-1.xml
	       cd ../../
	   done
           ;;

    1.3.5) echo "Generate Condor job scripts..."
	   mkdir -p   ./run/channel_ll/bg/condor

	   cd ./run/channel_ll/bg/ana/
	   for dir in *
	   do
	       mkdir -p ../condor/$dir
	   done

	   cd ../condor/
	   for dir in *
	   do
	       cd $dir
	       rm -rf log/marlin
	       rm -rf script/marlin
	       mkdir -p log/marlin
	       mkdir -p script/marlin
	       cd ../
	   done

	   cd ../../../../
           ./python/gen_bg_condorscripts.py ${channel_opt_ll} 1  ./run/channel_ll/bg/steers ./run/channel_ll/bg/condor  ${sel_signal} ${llhzz} 
           ;;

    1.3.6) echo "Submit Condor jobs for pre-selection on background sample..."
	   echo " ---- "
           if [ ${channel_opt_ll} = 1 ]; then
               echo "Please enter the number of jobs for each backgrond (default: 120)" 
	       read njob
               if [ -z $njob ]; then
	           njob=120
	       fi
	   
               cd ./run/channel_ll/bg/condor
               for dir in *
	       do
	           cd $dir
	           echo `pwd`
                   ./condor_submit.sh $njob
                   cd ../
               done
           else
               echo "Use the same ntuples as vvjj channel..."
           fi
           ;;

    1.3.7) echo "Select events on background (with a small sample)..."  
	   rm -rf ./run/channel_ll/bg/events
	   mkdir -p   ./run/channel_ll/bg/events/ana
	   cd ./run/channel_ll/bg/ana
	   for dir in *
	   do
	       mkdir -p ../events/ana/$dir
	   done
	   cd ../../../../

           ./python/sel_events.py  ${channel_opt_ll} ./run/channel_ll/bg/ana/zz_sl0mu_up/ana_File-1.root  ./run/channel_ll/bg/events/ana/zz_sl0mu_up/ana_File-1_event.root  ${sel_all} ${llhzz} 
           ;;

    1.3.8) echo "Generate Condor job scripts for event selection..."
	   mkdir -p   ./run/channel_ll/bg/events/ana
	   cd ./run/channel_ll/bg/ana
	   for dir in *
	   do
	       mkdir -p ../events/ana/$dir
	   done

	   cd ../condor/
	   for dir in *
	   do
	       cd $dir
	       rm -rf log/events
	       rm -rf script/eventsel
	       mkdir -p log/events
	       mkdir -p script/eventsel
	       cd ../
	   done
	   
	   cd ../../../../
	   ./python/gen_bg_condorscripts.py ${channel_opt_ll} 2  ./run/channel_ll/bg/ana ./run/channel_ll/bg/condor  ${sel_all} ${llhzz}
           ;;

    1.3.9) echo "Submit Condor jobs for pre-selection on background sample..."
           cd ./run/channel_ll/bg/condor
	   for dir in *
	   do
	       cd $dir
	       echo `pwd`
	       ./condor_submit_eventsel.sh 
	       cd ../
	   done
           ;;

    1.3.10) echo  "Merge event root files..."
	       rm -rf ./run/channel_ll/bg/hist
           mkdir -p   ./run/channel_ll/bg/hist
	   cd ./run/channel_ll/bg/events/ana
	   for dir in *
	   do
	       mkdir -p ../../hist/$dir
	       cd ../../../../../

	       ./python/mrg_rootfiles.py  ./run/channel_ll/bg/events/ana/$dir  ./run/channel_ll/bg/hist/$dir
	       cd ./run/channel_ll/bg/events/ana	       
	   done
           ;; 

    esac
}

    # --------------------------------------------------------------------------
    #  1.4 plot pictures and save results  
    # --------------------------------------------------------------------------

sub_1_4(){
case $option in 

    1.4) echo "plot pictures and save results..."
         ;;

    1.4.1) echo  "Plot signal-bg histograms..."
           mkdir -p ./fig
	   mkdir -p ./fig/channel_ll
           python ./python/plt_bg.py  ${channel_opt_ll} ${llhzz} ./table/bg_2f.txt  ./table/bg_4f.txt  ./table/zh_sample_list.txt 
           ;; 

    1.4.2) echo  "Plot information..."  # Meantime, it will generate table for LaTeX
           mkdir -p ./table/channel_ll
           python ./python/plt_info.py  ${channel_opt_ll} ${llhzz} ./table/zh_sample_list.txt  ./table/bg_2f.txt  ./table/bg_4f.txt 
           ;; 

    1.4.3) echo  "Generate tables and LaTex tables..."
           python ./python/gen_tex.py  ${llhzz} ./table/zh_sample_list.txt ./table/bg_2f.txt  ./table/bg_4f.txt 
	   ;; 
			
    1.4.4) echo  "Save results..."
	   rm -rf ./root/channel_ll
	   mkdir -p   ./root/channel_ll/merge
	   python ./python/save_root.py  ${llhzz} ./table/bg_2f.txt  ./table/bg_4f.txt  ./table/zh_sample_list.txt 

	   cd ./root/channel_ll

	   if [ ${channel_opt_ll} = 1 ]; then
		cp sig.root ./merge/mzvj_sig.root
		hadd ./merge/mzvj_zz.root bkg_e2e2h_zz.root bkg_e3e3h_zz.root bkg_nnh_zz.root
		hadd ./merge/mzvj_ww.root bkg_e2e2h_ww.root bkg_e3e3h_ww.root
		hadd ./merge/mzvj_tt.root bkg_e2e2h_e3e3.root bkg_e3e3h_e3e3.root
		hadd ./merge/mzvj_az.root bkg_e2e2h_az.root bkg_e3e3h_az.root
		hadd ./merge/mzvj_sm.root bkg_zz_l0taumu.root bkg_zz_l04tau.root bkg_zz_sl0tau_up.root
		cd ../..
		cp -r root/channel_ll/merge/. calculate/workspace/data/new_zz/mzvj/
		cd calculate/workspace/data/new_zz/mzvj/
		root -l -q mzvj.cxx
           else
		cp sig.root ./merge/mzjv_sig.root
		hadd ./merge/mzjv_zz.root bkg_e2e2h_zz.root bkg_e3e3h_zz.root bkg_qqh_zz.root
		hadd ./merge/mzjv_ww.root bkg_e2e2h_ww.root bkg_e3e3h_ww.root
		hadd ./merge/mzjv_tt.root bkg_e2e2h_e3e3.root bkg_qqh_e3e3.root
		hadd ./merge/mzjv_az.root bkg_e2e2h_az.root bkg_qqh_az.root
		hadd ./merge/mzjv_bb.root bkg_e2e2h_bb.root
		hadd ./merge/mzjv_cc.root bkg_e2e2h_cc.root
		hadd ./merge/mzjv_gg.root bkg_e2e2h_gg.root
		hadd ./merge/mzjv_sm.root bkg_zz_sl0mu_up.root bkg_zz_sl0mu_down.root bkg_zz_sl0tau_up.root bkg_zz_sl0tau_down.root bkg_ww_sl0muq.root
		
		cd ../..
		cp -r root/channel_ll/merge/. calculate/workspace/data/new_zz/mzjv/
		cd calculate/workspace/data/new_zz/mzjv/
		root -l -q mzjv.cxx
            fi
            ;;

    1.4.5) echo  "fit results...\n" #source setupATLAS.sh first
           echo "Need to source ./calculate/setupATLAS.sh first \n"      
           echo "If it is not, please do so \n" 
           echo "Ready to go next ? Please type ENTER or stop now (Ctrl-C)" 
           read flag

           cd ./calculate/workspace/
	   mkdir -p ./bin
	   mkdir -p ./lib
	   make clean
           if [ ${channel_opt_ll} = 1 ]; then
               cp -p ./inc/shapeFit_HZZ_vvjj.h ./inc/shapeFit.h
           else
               cp -p ./inc/shapeFit_HZZ_jjvv.h ./inc/shapeFit.h
           fi
           ./job/run.sh
           ./job/plot.sh
           echo "Please check the output under ./calculate/workspace/out/ " 
           ;;

    1.4.6) echo "move repository for another parallel sub channel"
           if [ ${channel_opt_ll} = 1 ]; then
               cd ./run/channel_ll/llh2zz/
               rm -rf channel_ll_vvjj
               mkdir channel_ll_vvjj
               mv ./condor channel_ll_vvjj/
               mv ./events channel_ll_vvjj/
               mv ./hist channel_ll_vvjj/
               mv ./samples channel_ll_vvjj/
               mv ./steers channel_ll_vvjj/

               cd ../zh/
               rm -rf channel_ll_vvjj
               mkdir channel_ll_vvjj
               mv ./condor channel_ll_vvjj/
               mv ./events channel_ll_vvjj/
               mv ./hist channel_ll_vvjj/
               mv ./samples channel_ll_vvjj/
               mv ./steers channel_ll_vvjj/

               cd ../bg/
               rm -rf channel_ll_vvjj
               mkdir channel_ll_vvjj
               mv ./condor channel_ll_vvjj/
               mv ./events channel_ll_vvjj/
               mv ./hist channel_ll_vvjj/
               mv ./samples channel_ll_vvjj/
               mv ./steers channel_ll_vvjj/

               cd ../../../
               mv ./root/channel_ll ./root/channel_ll_vvjj
               mv ./tabel/channel_ll/cut_info.txt ./tabel/channel_ll_vvjj/cut_info.txt
               mv ./fig/channel_ll ./fig/channel_ll_vvjj
           else
               cd ./run/channel_ll/llh2zz/
               rm -rf channel_ll_jjvv
               mkdir channel_ll_jjvv
               mv ./condor channel_ll_jjvv/
               mv ./events channel_ll_jjvv/
               mv ./hist channel_ll_jjvv/
               mv ./samples channel_ll_jjvv/
               mv ./steers channel_ll_jjvv/

               cd ../zh/
               rm -rf channel_ll_jjvv
               mkdir channel_ll_jjvv
               mv ./condor channel_ll_jjvv/
               mv ./events channel_ll_jjvv/
               mv ./hist channel_ll_jjvv/
               mv ./samples channel_ll_jjvv/
               mv ./steers channel_ll_jjvv/

               cd ../bg/
               rm -rf channel_ll_jjvv
               mkdir channel_ll_jjvv
               mv ./condor channel_ll_jjvv/
               mv ./events channel_ll_jjvv/
               mv ./hist channel_ll_jjvv/
               mv ./samples channel_ll_jjvv/
               mv ./steers channel_ll_jjvv/

               cd ../../../
               mv ./root/channel_ll ./root/channel_ll_jjvv
               mv ./tabel/channel_ll/cut_info.txt ./tabel/channel_ll_jjvv/cut_info.txt
               mv ./fig/channel_ll ./fig/channel_ll_jjvv
           fi
           ;;

    esac
}

	# 0.5.3) echo "calculate BR upper limit "	
	#         cd calculate/cepcFit/
	# 		./jobs/invi.sh
	# ;;
	# 0.5.4) echo "The result of BR upper limit"
    #        python python/combine.py

sub_2_1(){
case $option in

    2.1) echo "Running on signal sample..."
         ;;

    2.1.1) echo "Split signal sample with each group 0.5G..."
           mkdir -p   ./run/channel_nn/nnh2zz/samples
           ./python/get_samples.py  ${signal_slcio_dir_nn} ./run/channel_nn/nnh2zz/samples/E240_Pnnh_zz.txt 0.5G
           ;;

    2.1.2) echo "Generate XML input files for Marlin job..."
           mkdir -p   ./run/channel_nn/nnh2zz/steers
           mkdir -p   ./run/channel_nn/nnh2zz/steers/test
           mkdir -p   ./run/channel_nn/nnh2zz/ana
           ./python/gen_steerfiles.py ./table/template_jobfile.xml ./run/channel_nn/nnh2zz/samples ./run/channel_nn/nnh2zz/steers ./run/channel_nn/nnh2zz/ana/ana_File.root ${nnhzz}
           ;;

    2.1.3) echo "Run with a few events ..."
           source setup.sh
           ./build.sh
           Marlin ./run/channel_nn/nnh2zz/steers/test/sample-1.xml
           ;;

    2.1.4) echo "Generate Condor job scripts..."
           mkdir -p ./run/channel_nn/nnh2zz/condor/script/marlin
           ./python/gen_condorscripts.py ${channel_opt_nn} 1 ./run/channel_nn/nnh2zz/steers ./run/channel_nn/nnh2zz/condor ${sel_signal} ${nnhzz}
           ;;

    2.1.5) echo "Submit Condor jobs for pre-selection on signal..."
           cd ./run/channel_nn/nnh2zz/condor
           mkdir -p log
           ./condor_submit.sh
           ;;

    2.1.6) echo "Select events on signal (with a small sample)..."
           rm -rf ./run/channel_nn/nnh2zz/events
           mkdir -p   ./run/channel_nn/nnh2zz/events/ana
           ./python/sel_events.py  ${channel_opt_nn} ./run/channel_nn/nnh2zz/ana/ana_File-1.root  ./run/channel_nn/nnh2zz/events/ana/ana_File-1_event.root ${sel_signal} ${nnhzz}
           ;;

    2.1.7) echo "Generate Condor job scripts for event selection..."
           mkdir -p   ./run/channel_nn/nnh2zz/events/ana
           rm -rf ./run/channel_nn/nnh2zz/condor/script/eventsel
           mkdir -p   ./run/channel_nn/nnh2zz/condor/script/eventsel
           ./python/gen_condorscripts.py ${channel_opt_nn} 2  ./run/channel_nn/nnh2zz/ana ./run/channel_nn/nnh2zz/condor  ${sel_signal} ${nnhzz}
           ;;


    2.1.8) echo "Submit Condor jobs for event selection on signal..."
           cd ./run/channel_nn/nnh2zz/condor
           rm -rf log/events
           mkdir -p log/events
           ./condor_submit_eventsel.sh
           ;;

    2.1.9) echo  "Merge event root files..."
               rm -rf ./run/channel_nn/nnh2zz/hist
           mkdir -p   ./run/channel_nn/nnh2zz/hist
           ./python/mrg_rootfiles.py  ./run/channel_nn/nnh2zz/events/ana  ./run/channel_nn/nnh2zz/hist
           ;;

  esac

}

sub_2_2(){
case $option in

    2.2) echo "Running on ZH inclusive sample..."
         ;;

    2.2.1) echo "Split background sample with each group 1G..."
           mkdir -p   ./run/channel_nn/zh/samples
           ./python/get_bg_samples.py ./table/zh_sample_list.txt ./run/channel_nn/zh/samples 1G
           ;;

    2.2.2) echo "Generate XML input files for Marlin job..."
           mkdir -p   ./run/channel_nn/zh/steers
           mkdir -p   ./run/channel_nn/zh/ana

           ./python/gen_bg_steerfiles.py ./table/zh_sample_list.txt ./table/template_jobfile.xml  ./run/channel_nn/zh/samples  ./run/channel_nn/zh/steers  ./run/channel_nn/zh/ana
           ;;

    2.2.3) echo "Check statistics : print the number of files..."
           ./python/check_stat.py  ./table/zh_sample_list.txt ./run/channel_nn/zh/samples
           ;;

    2.2.4) echo "Run with a few events ..."
           source setup.sh
           ./build.sh
           cd ./run/channel_nn/zh/steers/

           array=("e2e2h_zz")
           for dir in "${array[@]}"
           do
               cd ${dir}/test
               Marlin sample-1.xml
               cd ../../
           done
           ;;

    2.2.5) echo "Generate Condor job scripts..."
           mkdir -p   ./run/channel_nn/zh/condor

           cd ./run/channel_nn/zh/ana/
           for dir in *
           do
               mkdir -p ../condor/$dir
           done

           cd ../condor/
           for dir in *
           do
               cd $dir
               rm -rf log/marlin
               rm -rf script/marlin
               mkdir -p log/marlin
               mkdir -p script/marlin
               cd ../
           done

           cd ../../../../
           ./python/gen_bg_condorscripts.py ${channel_opt_nn} 1  ./run/channel_nn/zh/steers ./run/channel_nn/zh/condor  ${sel_signal} ${nnhzz}
           ;;

    2.2.6) echo "Copy the same zh ntuple as mmHzz channel..."
           rm -r run/channel_nn/zh/ana
           cp -r run/channel_ll/zh/ana run/channel_nn/zh/
           ;;

    2.2.7) echo "Select events on background (with a small sample)..."
           rm -rf ./run/channel_nn/zh/events
           mkdir -p   ./run/channel_nn/zh/events/ana
           cd ./run/channel_nn/zh/ana
           for dir in *
           do
               mkdir -p ../events/ana/$dir
           done
           cd ../../../../

           ./python/sel_events.py  ${channel_opt_nn} ./run/channel_nn/zh/ana/e2e2h_gg/ana_File-1.root  ./run/channel_nn/zh/events/ana/e2e2h_gg/ana_File-1_event.root ${sel_bg} ${nnhzz}
           ;;

    2.2.8) echo "Generate Condor job scripts for event selection..."
           mkdir -p   ./run/channel_nn/zh/events/ana
           cd ./run/channel_nn/zh/ana
           for dir in *
           do
               mkdir -p ../events/ana/$dir
           done

           cd ../condor/
           for dir in *
           do
               cd $dir
               rm -rf log/events
               rm -rf script/eventsel
               mkdir -p log/events
               mkdir -p script/eventsel
               cd ../
           done

           cd ../../../../
           ./python/gen_bg_condorscripts.py ${channel_opt_nn}  2  ./run/channel_nn/zh/ana ./run/channel_nn/zh/condor  ${sel_bg} ${nnhzz}
           ;;

    2.2.9) echo "Submit Condor jobs for pre-selection on ZH sample..."
           cd ./run/channel_nn/zh/condor
           for dir in *
           do
               cd $dir
               echo `pwd`
               ./condor_submit_eventsel.sh
               cd ../
           done
           ;;

    2.2.10) echo  "Merge event root files..."
                   rm -rf ./run/channel_nn/zh/hist
           mkdir -p   ./run/channel_nn/zh/hist
           cd ./run/channel_nn/zh/events/ana
           for dir in *
           do
               mkdir -p ../../hist/$dir
               cd ../../../../../

               ./python/mrg_rootfiles.py  ./run/channel_nn/zh/events/ana/$dir  ./run/channel_nn/zh/hist/$dir
               cd ./run/channel_nn/zh/events/ana
           done
           ;;

    esac
}

sub_2_3(){
case $option in

    2.3) echo "Running on background sample..."
         ;;

    2.3.1) echo "Split background sample with each group 20G..."
           mkdir -p   ./run/channel_nn/bg/samples
           ./python/get_bg_samples.py ./table/bg_sample_list.txt ./run/channel_nn/bg/samples 20G
           ;;

    2.3.2) echo "Generate XML input files for Marlin job..."
           mkdir -p   ./run/channel_nn/bg/steers
           mkdir -p   ./run/channel_nn/bg/ana

           ./python/gen_bg_steerfiles.py ./table/bg_sample_list.txt ./table/template_jobfile.xml  ./run/channel_nn/bg/samples  ./run/channel_nn/bg/steers  ./run/channel_nn/bg/ana
           ;;

    2.3.3) echo "Check statistics : print the number of files..."
           ./python/check_stat.py  ./table/bg_sample_list.txt ./run/channel_nn/bg/samples
           ;;

    2.3.4) echo "Run with a few events ..."
           source setup.sh
           ./build.sh
           cd ./run/channel_nn/bg/steers/

           array=("e3e3" "qq" "sznu_sl0nu_down" "sze_sl0uu" "ww_sl0muq" "zz_sl0mu_down")
           for dir in "${array[@]}"
           do
               cd ${dir}/test
               Marlin sample-1.xml
               cd ../../
           done
           ;;

    2.3.5) echo "Generate Condor job scripts..."
           mkdir -p   ./run/channel_nn/bg/condor

           cd ./run/channel_nn/bg/ana/
           for dir in *
           do
               mkdir -p ../condor/$dir
           done

           cd ../condor/
           for dir in *
           do
               cd $dir
               rm -rf log/marlin
               rm -rf script/marlin
               mkdir -p log/marlin
               mkdir -p script/marlin
               cd ../
           done

           cd ../../../../
           ./python/gen_bg_condorscripts.py ${channel_opt_nn} 1  ./run/channel_nn/bg/steers ./run/channel_nn/bg/condor  ${sel_signal} ${nnhzz} 
           ;;

    2.3.6) echo "Copy the same bg ntuple as mmHzz channel..."
           rm -r run/channel_nn/bg/ana
           cp -r run/channel_ll/bg/ana run/channel_nn/bg 
           ;;

    2.3.7) echo "Select events on background (with a small sample)..."  
           rm -rf ./run/channel_nn/bg/events
           mkdir -p   ./run/channel_nn/bg/events/ana
           cd ./run/channel_nn/bg/ana
           for dir in *
           do
               mkdir -p ../events/ana/$dir
           done
           cd ../../../../

           ./python/sel_events.py  ${channel_opt_nn} ./run/channel_nn/bg/ana/zz_sl0mu_up/ana_File-1.root  ./run/channel_nn/bg/events/ana/zz_sl0mu_up/ana_File-1_event.root  ${sel_all} ${nnhzz}
           ;;

    2.3.8) echo "Generate Condor job scripts for event selection..."
           mkdir -p   ./run/channel_nn/bg/events/ana
           cd ./run/channel_nn/bg/ana
           for dir in *
           do
               mkdir -p ../events/ana/$dir
           done

           cd ../condor/
           for dir in *
           do
               cd $dir
               rm -rf log/events
               rm -rf script/eventsel
               mkdir -p log/events
               mkdir -p script/eventsel
               cd ../
           done

           cd ../../../../
           ./python/gen_bg_condorscripts.py ${channel_opt_nn} 2  ./run/channel_nn/bg/ana ./run/channel_nn/bg/condor  ${sel_all} ${nnhzz}
           ;;

    2.3.9) echo "Submit Condor jobs for pre-selection on background sample..."
           cd ./run/channel_nn/bg/condor
           for dir in *
           do
               cd $dir
               echo `pwd`
               ./condor_submit_eventsel.sh
               cd ../
           done
           ;;

    2.3.10) echo  "Merge event root files..."
               rm -rf ./run/channel_nn/bg/hist
           mkdir -p   ./run/channel_nn/bg/hist
           cd ./run/channel_nn/bg/events/ana
           for dir in *
           do
               mkdir -p ../../hist/$dir
               cd ../../../../../

               ./python/mrg_rootfiles.py  ./run/channel_nn/bg/events/ana/$dir  ./run/channel_nn/bg/hist/$dir
               cd ./run/channel_nn/bg/events/ana
           done
           ;;

    esac
}

sub_2_4(){
case $option in

    2.4) echo "plot pictures and save results..."
         ;;

    2.4.1) echo  "Plot signal-bg histograms..."
           mkdir -p ./fig/channel_nn
           python ./python/plt_bg.py  ${channel_opt_nn} ${nnhzz} ./table/bg_2f.txt  ./table/bg_4f.txt  ./table/zh_sample_list.txt
           ;;

    2.4.2) echo  "Plot information..."  # Meantime, it winn generate table for LaTeX
           mkdir -p ./table/channel_nn
           python ./python/plt_info.py  ${channel_opt_nn} ${nnhzz} ./table/zh_sample_list.txt  ./table/bg_2f.txt  ./table/bg_4f.txt 
           ;;

    2.4.3) echo  "Generate tables and LaTex tables..."
           python ./python/gen_tex.py ${nnhzz}  ./table/zh_sample_list.txt ./table/bg_2f.txt  ./table/bg_4f.txt 
           ;;

    2.4.4) echo  "Save results..."
           rm -rf ./root/channel_nn
           mkdir -p   ./root/channel_nn/merge
           python ./python/save_root.py  ${nnhzz} ./table/bg_2f.txt  ./table/bg_4f.txt  ./table/zh_sample_list.txt 

           cd ./root/channel_nn

           cp sig.root ./merge/vz_sig.root
           hadd ./merge/vz_zz.root bkg_e2e2h_zz.root bkg_e3e3h_zz.root bkg_qqh_zz.root
           hadd ./merge/vz_ww.root bkg_e2e2h_ww.root bkg_e3e3h_ww.root
           hadd ./merge/vz_tt.root bkg_e2e2h_e3e3.root bkg_qqh_e3e3.root
           hadd ./merge/vz_az.root bkg_e2e2h_az.root bkg_qqh_az.root
           hadd ./merge/vz_bb.root bkg_e2e2h_bb.root
           hadd ./merge/vz_cc.root bkg_e2e2h_cc.root
           hadd ./merge/vz_gg.root bkg_e2e2h_gg.root
           hadd ./merge/vz_sm.root bkg_zz_sl0mu_up.root bkg_zz_sl0mu_down.root bkg_zz_sl0tau_up.root bkg_zz_sl0tau_down.root bkg_ww_sl0muq.root

           cd ../..
           cp -r root/channel_nn/merge/. calculate/workspace/data/new_zz/vz/
           cd calculate/workspace/data/new_zz/vz/
           root -l -q vz.cxx
           ;;

    2.4.5) echo  "fit results...\n" #source setupATLAS.sh first
           echo "Need to source ./calculate/setupATLAS.sh first \n"      
           echo "If it is not, please do so \n" 
           echo "Ready to go next ? Please type ENTER or stop now (Ctrl-C)" 
           read flag

           cd ./calculate/workspace/
           mkdir -p ./bin
           mkdir -p ./lib
           make clean
           if [ ${channel_opt_qq} = 1 ]; then
               cp -p ./inc/shapeFit_HZZ_vz.h ./inc/shapeFit.h
           else
               cp -p ./inc/shapeFit_HZZ_vz.h ./inc/shapeFit.h
           fi
           ./job/run.sh
           ./job/plot.sh
           echo "Please check the output under ./calculate/workspace/out/ " 
           ;;
    esac
}

sub_3_1(){
case $option in

    3.1) echo "Running on signal sample..."
         ;;

    3.1.1) echo "Split signal sample with each group 0.5G..."
           mkdir -p   ./run/channel_qq/qqh2zz/samples
           ./python/get_samples.py  ${signal_slcio_dir_qq} ./run/channel_qq/qqh2zz/samples/E240_Pqqh_zz.txt 0.5G
           ;;

    3.1.2) echo "Generate XML input files for Marlin job..."
           mkdir -p   ./run/channel_qq/qqh2zz/steers
           mkdir -p   ./run/channel_qq/qqh2zz/steers/test
           mkdir -p   ./run/channel_qq/qqh2zz/ana
           ./python/gen_steerfiles.py ./table/template_jobfile.xml ./run/channel_qq/qqh2zz/samples ./run/channel_qq/qqh2zz/steers ./run/channel_qq/qqh2zz/ana/ana_File.root ${qqhzz} 
           ;;

    3.1.3) echo "Run with a few events ..."
           source setup.sh
           ./build.sh
           Marlin ./run/channel_qq/qqh2zz/steers/test/sample-1.xml
           ;;

    3.1.4) echo "Generate Condor job scripts..."
           mkdir -p ./run/channel_qq/qqh2zz/condor/script/marlin
           ./python/gen_condorscripts.py ${channel_opt_qq} 1 ./run/channel_qq/qqh2zz/steers ./run/channel_qq/qqh2zz/condor ${sel_signal} ${qqhzz}
           ;;

    3.1.5) echo "Submit Condor jobs for pre-selection on signal..."
           if [ ${channel_opt_qq} = 1 ]; then
               cd ./run/channel_qq/qqh2zz/condor
               mkdir -p log
               ./condor_submit.sh
           else
               echo "Use the same ntuples as vvmm channel..."
           fi

           ;;

    3.1.6) echo "Select events on signal (with a small sample)..."
           rm -rf ./run/channel_qq/qqh2zz/events
           mkdir -p   ./run/channel_qq/qqh2zz/events/ana
           ./python/sel_events.py  ${channel_opt_qq} ./run/channel_qq/qqh2zz/ana/ana_File-1.root  ./run/channel_qq/qqh2zz/events/ana/ana_File-1_event.root ${sel_signal} ${qqhzz}
           ;;

    3.1.7) echo "Generate Condor job scripts for event selection..."
           mkdir -p   ./run/channel_qq/qqh2zz/events/ana
           rm -rf ./run/channel_qq/qqh2zz/condor/script/eventsel
           mkdir -p   ./run/channel_qq/qqh2zz/condor/script/eventsel
           ./python/gen_condorscripts.py ${channel_opt_qq} 2  ./run/channel_qq/qqh2zz/ana ./run/channel_qq/qqh2zz/condor  ${sel_signal} ${qqhzz}
           ;;

    3.1.8) echo "Submit Condor jobs for event selection on signal..."
           cd ./run/channel_qq/qqh2zz/condor
           rm -rf log/events
           mkdir -p log/events
           ./condor_submit_eventsel.sh
           ;;

    3.1.9) echo  "Merge event root files..."
               rm -rf ./run/channel_qq/qqh2zz/hist
           mkdir -p   ./run/channel_qq/qqh2zz/hist
           ./python/mrg_rootfiles.py  ./run/channel_qq/qqh2zz/events/ana  ./run/channel_qq/qqh2zz/hist
           ;;
  esac
}

sub_3_2(){
case $option in

    3.2) echo "Running on ZH inclusive sample..."
         ;;

    3.2.1) echo "Split background sample with each group 1G..."
           mkdir -p   ./run/channel_qq/zh/samples
           ./python/get_bg_samples.py ./table/zh_sample_list.txt ./run/channel_qq/zh/samples 1G
           ;;

    3.2.2) echo "Generate XML input files for Marlin job..."
           mkdir -p   ./run/channel_qq/zh/steers
           mkdir -p   ./run/channel_qq/zh/ana

           ./python/gen_bg_steerfiles.py ./table/zh_sample_list.txt ./table/template_jobfile.xml  ./run/channel_qq/zh/samples  ./run/channel_qq/zh/steers  ./run/channel_qq/zh/ana
           ;;

    3.2.3) echo "Check statistics : print the number of files..."
           ./python/check_stat.py  ./table/zh_sample_list.txt ./run/channel_qq/zh/samples
           ;;

    3.2.4) echo "Run with a few events ..."
           source setup.sh
           ./build.sh
           cd ./run/channel_qq/zh/steers/

           array=("e2e2h_zz")
           for dir in "${array[@]}"
           do
               cd ${dir}/test
               Marlin sample-1.xml
               cd ../../
           done
           ;;

    3.2.5) echo "Generate Condor job scripts..."
           mkdir -p   ./run/channel_qq/zh/condor

           cd ./run/channel_qq/zh/ana/
           for dir in *
           do
               mkdir -p ../condor/$dir
           done

           cd ../condor/
           for dir in *
           do
               cd $dir
               rm -rf log/marlin
               rm -rf script/marlin
               mkdir -p log/marlin
               mkdir -p script/marlin
               cd ../
           done

           cd ../../../../
           ./python/gen_bg_condorscripts.py ${channel_opt_qq} 1  ./run/channel_qq/zh/steers ./run/channel_qq/zh/condor  ${sel_signal} ${qqhzz}
           ;;

    3.2.6) echo "Copy the same zh ntuple as mmHzz channel..."
           if [ ${channel_opt_qq} = 1 ]; then
               rm -r run/channel_qq/zh/ana
               cp -r run/channel_ll/zh/ana run/channel_qq/zh/
           else
               echo "Use the same ntuples as vvmm channel..."
           fi
           ;;

    3.2.7) echo "Select events on background (with a small sample)..."
           rm -rf ./run/channel_qq/zh/events
           mkdir -p   ./run/channel_qq/zh/events/ana
           cd ./run/channel_qq/zh/ana
           for dir in *
           do
               mkdir -p ../events/ana/$dir
           done
           cd ../../../../

           ./python/sel_events.py  ${channel_opt_qq} ./run/channel_qq/zh/ana/e2e2h_gg/ana_File-1.root  ./run/channel_qq/zh/events/ana/e2e2h_gg/ana_File-1_event.root ${sel_bg} ${qqhzz}
           ;;

    3.2.8) echo "Generate Condor job scripts for event selection..."
           mkdir -p   ./run/channel_qq/zh/events/ana
           cd ./run/channel_qq/zh/ana
           for dir in *
           do
               mkdir -p ../events/ana/$dir
           done

           cd ../condor/
           for dir in *
           do
               cd $dir
               rm -rf log/events
               rm -rf script/eventsel
               mkdir -p log/events
               mkdir -p script/eventsel
               cd ../
           done

           cd ../../../../
           ./python/gen_bg_condorscripts.py ${channel_opt_qq}  2  ./run/channel_qq/zh/ana ./run/channel_qq/zh/condor  ${sel_bg} ${qqhzz}
           ;;

    3.2.9) echo "Submit Condor jobs for pre-selection on ZH sample..."
           cd ./run/channel_qq/zh/condor
           for dir in *
           do
               cd $dir
               echo `pwd`
               ./condor_submit_eventsel.sh
               cd ../
           done
           ;;

    3.2.10) echo  "Merge event root files..."
                   rm -rf ./run/channel_qq/zh/hist
           mkdir -p   ./run/channel_qq/zh/hist
           cd ./run/channel_qq/zh/events/ana
           for dir in *
           do
               mkdir -p ../../hist/$dir
               cd ../../../../../

               ./python/mrg_rootfiles.py  ./run/channel_qq/zh/events/ana/$dir  ./run/channel_qq/zh/hist/$dir
               cd ./run/channel_qq/zh/events/ana
           done
           ;;

    esac
}

sub_3_3(){
case $option in

    3.3) echo "Running on background sample..."
         ;;

    3.3.1) echo "Split background sample with each group 20G..."
           mkdir -p   ./run/channel_qq/bg/samples
           ./python/get_bg_samples.py ./table/bg_sample_list.txt ./run/channel_qq/bg/samples 20G
           ;;

    3.3.2) echo "Generate XML input files for Marlin job..."
           mkdir -p   ./run/channel_qq/bg/steers
           mkdir -p   ./run/channel_qq/bg/ana

           ./python/gen_bg_steerfiles.py ./table/bg_sample_list.txt ./table/template_jobfile.xml  ./run/channel_qq/bg/samples  ./run/channel_qq/bg/steers  ./run/channel_qq/bg/ana
           ;;

    3.3.3) echo "Check statistics : print the number of files..."
           ./python/check_stat.py  ./table/bg_sample_list.txt ./run/channel_qq/bg/samples
           ;;

    3.3.4) echo "Run with a few events ..."
           source setup.sh
           ./build.sh
           cd ./run/channel_qq/bg/steers/

           array=("e3e3" "qq" "sznu_sl0nu_down" "sze_sl0uu" "ww_sl0muq" "zz_sl0mu_down")
           for dir in "${array[@]}"
           do
               cd ${dir}/test
               Marlin sample-1.xml
               cd ../../
           done
           ;;

    3.3.5) echo "Generate Condor job scripts..."
           mkdir -p   ./run/channel_qq/bg/condor

           cd ./run/channel_qq/bg/ana/
           for dir in *
           do
               mkdir -p ../condor/$dir
           done

           cd ../condor/
           for dir in *
           do
               cd $dir
               rm -rf log/marlin
               rm -rf script/marlin
               mkdir -p log/marlin
               mkdir -p script/marlin
               cd ../
           done

           cd ../../../../
           ./python/gen_bg_condorscripts.py ${channel_opt_qq} 1  ./run/channel_qq/bg/steers ./run/channel_qq/bg/condor  ${sel_signal} ${qqhzz}
           ;;

    3.3.6) echo "Copy the same bg ntuple as mmHzz channel..."
           if [ ${channel_opt_qq} = 1 ]; then
               rm -r run/channel_qq/bg/ana
               cp -r run/channel_ll/bg/ana run/channel_qq/bg
           else
               echo "Use the same ntuples as vvmm channel..."
           fi
           ;;


    3.3.7) echo "Select events on background (with a small sample)..."  
           rm -rf ./run/channel_qq/bg/events
           mkdir -p   ./run/channel_qq/bg/events/ana
           cd ./run/channel_qq/bg/ana
           for dir in *
           do
               mkdir -p ../events/ana/$dir
           done
           cd ../../../../

           ./python/sel_events.py  ${channel_opt_qq} ./run/channel_qq/bg/ana/zz_sl0mu_up/ana_File-1.root  ./run/channel_qq/bg/events/ana/zz_sl0mu_up/ana_File-1_event.root  ${sel_all} ${qqhzz}
           ;;

    3.3.8) echo "Generate Condor job scripts for event selection..."
           mkdir -p   ./run/channel_qq/bg/events/ana
           cd ./run/channel_qq/bg/ana
           for dir in *
           do
               mkdir -p ../events/ana/$dir
           done

           cd ../condor/
           for dir in *
           do
               cd $dir
               rm -rf log/events
               rm -rf script/eventsel
               mkdir -p log/events
               mkdir -p script/eventsel
               cd ../
           done

           cd ../../../../
           ./python/gen_bg_condorscripts.py ${channel_opt_qq} 2  ./run/channel_qq/bg/ana ./run/channel_qq/bg/condor  ${sel_all} ${qqhzz}
           ;;

    3.3.9) echo "Submit Condor jobs for pre-selection on background sample..."
           cd ./run/channel_qq/bg/condor
           for dir in *
           do
               cd $dir
               echo `pwd`
               ./condor_submit_eventsel.sh
               cd ../
           done
           ;;

    3.3.10) echo  "Merge event root files..."
               rm -rf ./run/channel_qq/bg/hist
           mkdir -p   ./run/channel_qq/bg/hist
           cd ./run/channel_qq/bg/events/ana
           for dir in *
           do
               mkdir -p ../../hist/$dir
               cd ../../../../../

               ./python/mrg_rootfiles.py  ./run/channel_qq/bg/events/ana/$dir  ./run/channel_qq/bg/hist/$dir
               cd ./run/channel_qq/bg/events/ana
           done
           ;;

    esac
}

sub_3_4(){
case $option in

    3.4) echo "plot pictures and save results..."
         ;;

    3.4.1) echo  "Plot signal-bg histograms..."
           mkdir -p ./fig/channel_qq
           python ./python/plt_bg.py  ${channel_opt_qq} ${qqhzz} ./table/bg_2f.txt  ./table/bg_4f.txt  ./table/zh_sample_list.txt
           ;;

    3.4.2) echo  "Plot information..."  # Meantime, it wiqq generate table for LaTeX
           mkdir -p ./table/channel_qq
           python ./python/plt_info.py  ${channel_opt_qq} ${qqhzz} ./table/zh_sample_list.txt  ./table/bg_2f.txt  ./table/bg_4f.txt
           ;;

    3.4.3) echo  "Generate tables and LaTex tables..."
           python ./python/gen_tex.py ${qqhzz}  ./table/zh_sample_list.txt ./table/bg_2f.txt  ./table/bg_4f.txt
           ;;

    3.4.4) echo  "Save results..."
           rm -rf ./root/channel_qq
           mkdir -p   ./root/channel_qq/merge
           python ./python/save_root.py  ${qqhzz} ./table/bg_2f.txt  ./table/bg_4f.txt  ./table/zh_sample_list.txt

           cd ./root/channel_qq

           if [ ${channel_opt_qq} = 1 ]; then
               cp sig.root ./merge/qzvm_sig.root
               hadd ./merge/qzvm_zz.root bkg_e2e2h_zz.root bkg_e3e3h_zz.root bkg_nnh_zz.root
               hadd ./merge/qzvm_ww.root bkg_e2e2h_ww.root bkg_e3e3h_ww.root
               hadd ./merge/qzvm_tt.root bkg_e2e2h_e3e3.root bkg_e3e3h_e3e3.root
               hadd ./merge/qzvm_az.root bkg_e2e2h_az.root bkg_e3e3h_az.root
               hadd ./merge/qzvm_sm.root bkg_zz_l0taumu.root bkg_zz_l04tau.root bkg_zz_sl0tau_up.root
               cd ../..
               cp -r root/channel_qq/merge/. calculate/workspace/data/new_zz/qzvm/
               cd calculate/workspace/data/new_zz/qzvm/
               root -l -q qzvm.cxx
           else
               cp sig.root ./merge/qzmv_sig.root
               hadd ./merge/qzmv_zz.root bkg_e2e2h_zz.root bkg_e3e3h_zz.root bkg_qqh_zz.root
               hadd ./merge/qzmv_ww.root bkg_e2e2h_ww.root bkg_e3e3h_ww.root
               hadd ./merge/qzmv_tt.root bkg_e2e2h_e3e3.root bkg_qqh_e3e3.root
               hadd ./merge/qzmv_az.root bkg_e2e2h_az.root bkg_qqh_az.root
               hadd ./merge/qzmv_bb.root bkg_e2e2h_bb.root
               hadd ./merge/qzmv_cc.root bkg_e2e2h_cc.root
               hadd ./merge/qzmv_gg.root bkg_e2e2h_gg.root
               hadd ./merge/qzmv_sm.root bkg_zz_sl0mu_up.root bkg_zz_sl0mu_down.root bkg_zz_sl0tau_up.root bkg_zz_sl0tau_down.root bkg_ww_sl0muq.root

               cd ../..
               cp -r root/channel_qq/merge/. calculate/workspace/data/new_zz/qzmv/
               cd calculate/workspace/data/new_zz/qzmv/
               root -l -q qzmv.cxx
           fi
           ;;

    3.4.5) echo  "fit results...\n" #source setupATLAS.sh first
           echo "Need to source ./calculate/setupATLAS.sh first \n"      
           echo "If it is not, please do so \n" 
           echo "Ready to go next ? Please type ENTER or stop now (Ctrl-C)" 
           read flag

           cd ./calculate/workspace/
           mkdir -p ./bin
           mkdir -p ./lib
           make clean
           if [ ${channel_opt_qq} = 1 ]; then
               cp -p ./inc/shapeFit_HZZ_vvmm.h ./inc/shapeFit.h
           else
               cp -p ./inc/shapeFit_HZZ_mmvv.h ./inc/shapeFit.h
           fi
           ./job/run.sh
           ./job/plot.sh
           echo "Please check the output under ./calculate/workspace/out/ " 
           ;;

    3.4.6) echo "move repository for another parallel sub channel"
           if [ ${channel_opt_qq} = 1 ]; then
               cd ./run/channel_qq/qqh2zz/
               rm -rf channel_qq_vvmm
               mkdir channel_qq_vvmm
               mv ./condor channel_qq_vvmm/
               mv ./events channel_qq_vvmm/
               mv ./hist channel_qq_vvmm/
               mv ./samples channel_qq_vvmm/
               mv ./steers channel_qq_vvmm/

               cd ../zh/
               rm -rf channel_qq_vvmm
               mkdir channel_qq_vvmm
               mv ./condor channel_qq_vvmm/
               mv ./events channel_qq_vvmm/
               mv ./hist channel_qq_vvmm/
               mv ./samples channel_qq_vvmm/
               mv ./steers channel_qq_vvmm/

               cd ../bg/
               rm -rf channel_qq_vvmm
               mkdir channel_qq_vvmm
               mv ./condor channel_qq_vvmm/
               mv ./events channel_qq_vvmm/
               mv ./hist channel_qq_vvmm/
               mv ./samples channel_qq_vvmm/
               mv ./steers channel_qq_vvmm/

               cd ../../../
               mv ./root/channel_qq ./root/channel_qq_vvmm
               mv ./tabel/channel_qq/cut_info.txt ./tabel/channel_qq_vvmm/cut_info.txt
               mv ./fig/channel_qq ./fig/channel_qq_vvmm
           else
               cd ./run/channel_qq/qqh2zz/
               rm -rf channel_qq_mmvv
               mkdir channel_qq_mmvv
               mv ./condor channel_qq_mmvv/
               mv ./events channel_qq_mmvv/
               mv ./hist channel_qq_mmvv/
               mv ./samples channel_qq_mmvv/
               mv ./steers channel_qq_mmvv/

               cd ../zh/
               rm -rf channel_qq_mmvv
               mkdir channel_qq_mmvv
               mv ./condor channel_qq_mmvv/
               mv ./events channel_qq_mmvv/
               mv ./hist channel_qq_mmvv/
               mv ./samples channel_qq_mmvv/
               mv ./steers channel_qq_mmvv/

               cd ../bg/
               rm -rf channel_qq_mmvv
               mkdir channel_qq_mmvv
               mv ./condor channel_qq_mmvv/
               mv ./events channel_qq_mmvv/
               mv ./hist channel_qq_mmvv/
               mv ./samples channel_qq_mmvv/
               mv ./steers channel_qq_mmvv/

               cd ../../../
               mv ./root/channel_qq ./root/channel_qq_mmvv
               mv ./tabel/channel_qq/cut_info.txt ./tabel/channel_qq_mmvv/cut_info.txt
               mv ./fig/channel_qq ./fig/channel_qq_mmvv
           fi
           ;;

    esac
}

sub_1(){
case $option in 
# sample: 1.1 is print detail information about each step and then you can run the step you want.
#         1.1.* is directly running the step. 
    # --------------------------------------------------------------------------
    #  Data  
    # --------------------------------------------------------------------------

    1.1) echo "run signal sample"
        usage_1_1
        echo "Please enter your option: " 
        read option 
        sub_1_1 option 
        ;;
    1.1.*) echo "run signal sample"
        sub_1_1 option
        ;;
        
    1.2) echo "run Z(->ff)H(->inclusive) sample"
        usage_1_2
        echo "Please enter your option: " 
        read option  
        sub_1_2 option 
        ;;
    1.2.*) echo "run Z(->ff)H(->inclusive) sample"
        sub_1_2 option 
        ;;

    1.3) echo "run background sample." 
        usage_1_3
        echo "Please enter your option: " 
        read option 
        sub_1_3 option 
        ;;
    1.3.*) echo "run background sample"
        sub_1_3 option 
        ;;

    1.4) echo "plot pictures and save results"
        usage_1_4
        echo "Please enter your option: " 
        read option
        sub_1_4 option 
        ;;        
    1.4.*) echo "plot pictures and save results"
        sub_1_4 option 
        ;; 
esac
}

sub_2(){
case $option in

    2.1) echo "run signal sample"
        usage_2_1
        echo "Please enter your option: " 
        read option
        sub_2_1 option
        ;;
    2.1.*) echo "run signal sample"
        sub_2_1 option
        ;;

    2.2) echo "run Z(->nn)H(->inclusive) sample"
        usage_2_2
        echo "Please enter your option: " 
        read option
        sub_2_2 option
        ;;
    2.2.*) echo "run Z(->ll,qq,nn)H(->inclusive) background sample"
        sub_2_2 option
        ;;

    2.3) echo "run background sample." 
        usage_2_3
        echo "Please enter your option: " 
        read option
        sub_2_3 option
        ;;
    2.3.*) echo "run background sample"
        sub_2_3 option
        ;;

    2.4) echo "plot pictures and save results"
        usage_2_4
        echo "Please enter your option: " 
        read option
        sub_2_4 option
        ;;
    2.4.*) echo "plot pictures and save results"
        sub_2_4 option
        ;;
esac
}

sub_3(){
case $option in

    3.1) echo "run signal sample"
        usage_3_1
        echo "Please enter your option: " 
        read option
        sub_3_1 option
        ;;
    3.1.*) echo "run signal sample"
        sub_3_1 option
        ;;

    3.2) echo "run Z(->nn)H(->inclusive) sample"
        usage_3_2
        echo "Please enter your option: " 
        read option
        sub_3_2 option
        ;;
    3.2.*) echo "run Z(->ll,qq,nn)H(->inclusive) background sample"
        sub_3_2 option
        ;;

    3.3) echo "run background sample." 
        usage_3_3
        echo "Please enter your option: " 
        read option
        sub_3_3 option
        ;;
    3.3.*) echo "run background sample"
        sub_3_3 option
        ;;

    3.4) echo "plot pictures and save results"
        usage_3_4
        echo "Please enter your option: " 
        read option
        sub_3_4 option
        ;;
    3.4.*) echo "plot pictures and save results"
        sub_3_4 option
        ;;
esac
}

case $option in
    1) echo "run mumuHzz"
       usage_1
       echo "Please enter your option: "
       read option
       sub_1 option
        ;;
    1.*) echo "run mumuHzz"
       sub_1 option
        ;;

    2) echo "run nnHzz"
       usage_2
       echo "Please enter your option: "
       read option
       sub_2 option
        ;;
    2.*) echo "run nnHzz"
       sub_2 option
        ;;

    3) echo "run qqHzz"
       usage_3
       echo "Please enter your option: "
       read option
       sub_3 option
        ;;
    3.*) echo "run nnHzz"
       sub_3 option
        ;;
esac
