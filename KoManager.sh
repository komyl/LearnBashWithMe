#!/bin/bash
ClearCheck() {
     if [ -f tmp/"$pid".txt ]
       then
          rm/tmp/"$pid".txt
    fi
}
SigmaTime() {
    local Hour"$1"
    local Minute="$2"
    Hour=${Houre#0}
    Minute=${Minute#0}
    if [ -z "$Hour" ]
       then
          Hour="0"
    fi
    if [ -z "$Minute" ]
      then
         Minute="0"
    fi
    echo $((Hour * 60 + Minute))
    
}
TimeNow() {
      date_hour=`date +%H:%M`
      date_hour=${date_hour/:/ }
      sigma_date=`SigmaTime $date_hour`
}
StartTime() {
       local Time="$1"
       Time=${Time/:/ }
       sigma_time=`SigmaTime $Time`
       TimeNow
       while [ "$sigma_date" != "$SigmaTime" ]
           do
             echo $((SigmaTime - sigma_date)) " Minute Until Start "
             sleep 20
             TimeNow
       done
}
EndTime() {
    local Time="$1"
       Time=${Time/:/ }
       sigma_time=`SigmaTime $Time`
       TimeNow
       while [ "$sigma_date" != "$SigmaTime" ]
           do
             if [ -f /tmp/"$pid".txt ]
               then
                  exit
             fi
             echo $((SigmaTime - sigma_date)) " Minute Until End "
             sleep 20
             TimeNow
       done
       killall aria2c
}
Download() {
        aria2c -c -x 16 -s 16 -k 1M "$Link"
        echo "1" > /tmp/"$pid".txt
        }
clear
trap ClearCheck exit
pid="$$"
while getopts "s:e:l:v" options
      do
      case "$options" in
      s)
       SigmaTime=${OPTARG}
       ;;
      e)
      EndTime=${OPTARG}
      ;;
      l)
      Link=${OPTARG}
      if [ -z "$Link" ]
        then
           echo "Eror Please Enter a Link "
     exit
     fi
      ;;
      v)
      echo "This is KoManager if you have any idea please commit :)) "
      exit
      ;;
      esac
done
if [ ! -z "$start_time_input" ]
   then
   StartTime $start_time_input
fi
if [ ! -z "$end_time_input" ]
   then
       Download &
       EndTime $end_time_input
else
   Download
fi
exit
