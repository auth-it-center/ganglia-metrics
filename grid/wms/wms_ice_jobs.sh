#!/bin/bash
QUERYDB=$(command -v queryDb)
GMETRIC=$(command -v gmetric)

if [[ -z $QUERYDB ]] || [[ -z $GMETRIC ]]; then
   echo "necessary commands not found"
else
   for i in REALLY-RUNNING IDLE ABORTED UNKNOWN REALLY-RUNNING,IDLE,ABORTED,UNKNOWN
   do
      VALUE=$( $QUERYDB -s $i | sed 's/[^0-9]*//g' )
      NAME=$( echo $i | sed 's/-/_/g' )
      $GMETRIC --name=$NAME --type=uint16 --units=Jobs --value=$VALUE
   done
fi
