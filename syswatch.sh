#!/bin/bash

# Function to print the ASCII art with blue text
print_syswatch_ascii() {
    printf "\e[1;34m"
    cat << "EOF"
  ______                       __       __              __                __       
 /      \                     /  |  _  /  |            /  |              /  |      
/$$$$$$  | __    __   _______ $$ | / \ $$ |  ______   _$$ |_     _______ $$ |____  
$$ \__$$/ /  |  /  | /       |$$ |/$  \$$ | /      \ / $$   |   /       |$$      \ 
$$      \ $$ |  $$ |/$$$$$$$/ $$ /$$$  $$ | $$$$$$  |$$$$$$/   /$$$$$$$/ $$$$$$$  |
 $$$$$$  |$$ |  $$ |$$      \ $$ $$/$$ $$ | /    $$ |  $$ | __ $$ |      $$ |  $$ |
/  \__$$ |$$ \__$$ | $$$$$$  |$$$$/  $$$$ |/$$$$$$$ |  $$ |/  |$$ \_____ $$ |  $$ |
$$    $$/ $$    $$ |/     $$/ $$$/    $$$ |$$    $$ |  $$  $$/ $$       |$$ |  $$ |
 $$$$$$/   $$$$$$$ |$$$$$$$/  $$/      $$/  $$$$$$$/    $$$$/   $$$$$$$/ $$/   $$/ 
          /  \__$$ |                                                               
          $$    $$/                                                                
           $$$$$$/                                                                 
EOF
    printf "\e[0m\n"
}

# Print syswatch ASCII art
print_syswatch_ascii

# Check the OS platform
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS specific commands
    printf "\e[1;31mSystem Information:\e[0m\n"
    printf "\e[1;32m-------------------\e[0m\n"
    printf "\e[1;33mHost:\e[0m \e[1;34m$(system_profiler SPHardwareDataType | awk '/Model Name/ {print $3,$4,$5}')\e[0m\n"
    printf "\e[1;33mOS Details:\e[0m \e[1;34m$(sw_vers -productName) $(sw_vers -productVersion)\e[0m\n"
    printf "\e[1;33mUser:\e[0m \e[1;34m$(whoami)\e[0m\n"
    printf "\e[1;33mUptime:\e[0m \e[1;34m$(system_profiler SPSoftwareDataType | awk '/Time since boot/ {print $4,$5,$6,$7,$8,$9}')\e[0m\n"
    printf "\e[1;33mShell:\e[0m \e[1;34m$(zsh --version | awk '{print $1}') $(zsh --version | awk '{print $2}')\e[0m\n"
    printf "\e[1;33mCPU Name:\e[0m \e[1;34m$(system_profiler SPHardwareDataType | awk '/Processor Name/ {print substr($0, index($0, $3))}')\e[0m\n"
    printf "\e[1;33mCPU Cores:\e[0m \e[1;34m$(system_profiler SPHardwareDataType | awk '/Total Number of Cores/ {print $5}')\e[0m\n"
    printf "\e[1;33mGPU Name:\e[0m \e[1;34m$(system_profiler SPDisplaysDataType | awk '/Chipset Model/ {print substr($0, index($0, $3))}')\e[0m\n"
    printf "\e[1;33mScreen Resolution:\e[0m \e[1;34m$(system_profiler SPDisplaysDataType | awk '/Resolution:/ {print $2 "x" $4}')\e[0m\n"

elif [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "cygwin" ]]; then
    # Windows specific commands
    printf "\e[1;31mSystem Information:\e[0m\n"
    printf "\e[1;32m-------------------\e[0m\n"
    printf "\e[1;33mHost:\e[0m \e[1;34m$(hostname)\e[0m\n"
    
    # OS Details
    printf "\e[1;33mOS Details:\e[0m \e[1;34m\n"
    os_name=$(wmic os get Caption)
    printf "Your laptop is running: \e[1;34m%s\e[0m\n" "$os_name"
    
    printf "\e[1;33mUser:\e[0m \e[1;34m$(whoami)\e[0m\n"
    
    # Screen Resolution
    res_width=$(powershell -Command "(Get-WmiObject -Class Win32_VideoController).CurrentHorizontalResolution" | tr -d '\r')
    res_height=$(powershell -Command "(Get-WmiObject -Class Win32_VideoController).CurrentVerticalResolution" | tr -d '\r')
    printf "\e[1;33mScreen Resolution:\e[0m \e[1;34m$res_width x $res_height\e[0m\n"

    echo -e "\n\e[1;33mYour laptop uptime:\e[0m"
    powershell -Command "(Get-Date) - (gcim Win32_OperatingSystem).LastBootUpTime"
    echo -e "\e[1;33mIdeally, it shouldn't be more than 7 days. If it is, a restart is advisable.\e[0m"

    # Architecture check (64-bit or 32-bit)
    architecture=$(uname -m)

    if [[ "$architecture" == "x86_64" ]]; then
        echo -e "\n\e[1;33mArchitecture:\e[0m Your system has a 64-bit architecture (\e[1;34m$architecture\e[0m)"
    elif [[ "$architecture" == "i686" || "$architecture" == "i386" ]]; then
        echo -e "\n\e[1;33mArchitecture:\e[0m Your system has a 32-bit architecture (\e[1;34m$architecture\e[0m)"
    else
        echo -e "\n\e[1;33mUnable to determine architecture:\e[0m \e[1;34m$architecture\e[0m"
    fi


	echo -e "\e[1;34mDisk Space Information:\e[0m"
	echo -e "\e[1;32m----------------------------------------\e[0m"
	df -h --output=source,size,used,avail,pcent,target | column -t
	echo -e "\e[1;32m----------------------------------------\e[0m"

	
	wmic OS get FreePhysicalMemory,TotalVisibleMemorySize /format:value | awk -F= '/TotalVisibleMemorySize/ {total=$2} /FreePhysicalMemory/ {free=$2} END {if(total && free) printf "Memory Usage: %.2f MB used out of %.2f MB total\n", (total - free) / 1024, total / 1024}'

fi
