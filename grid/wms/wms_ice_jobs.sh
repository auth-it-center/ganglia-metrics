#!/bin/bash

if ( ! ( command -v queryDb &>/dev/null ) ) || ( ! ( command -v gmetric &>/dev/null ) ); then
   echo "neccessary commands not found"
else
   QUERYDB=$(command -v queryDb)
   GMETRIC=$(command -v gmetric)

   for i in REALLY-RUNNING IDLE ABORTED UNKNOWN REALLY-RUNNING,IDLE,ABORTED,UNKNOWN
   do
      VALUE=$( $QUERYDB -s $i | sed 's/[^0-9]*//g' )
      NAME=$( echo $i | sed 's/-/_/g' )
      $GMETRIC --name=$NAME --type=uint16 --units=Jobs --value=$VALUE
   done
fi
