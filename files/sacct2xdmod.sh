#!/bin/bash
# Syockel - 2016
# Custom SLURM sacct to xdmod-shredder to xdmod-ingester meant for running each day to pull yesterdays data into XDMoD
# Get yesterday's date
ndate=`date -d yesterday +%F`

# Step 1 - Create slurm log
TZ=UTC sacct --allusers --allclusters --parsable2 --noheader --allocations --format jobid,cluster,partition,account,group,user,submit,eligible,start,end,elapsed,exitcode,nnodes,ncpus,nodelist,jobname --state CANCELLED,COMPLETED,FAILED,NODE_FAIL,PREEMPTED,TIMEOUT --starttime ${ndate}T00:00:00 --endtime ${ndate}T23:59:59 > /tmp/sacct-${ndate}.log
# clean up any bad data
grep -v ^0_0 /tmp/sacct-${ndate}.log > /tmp/sacct-${ndate}.v2.log
grep -v ^$ /tmp/sacct-${ndate}.v2.log > /tmp/slurm-${ndate}.log

# Step 2 - Shred Data into XDMoD DB
xdmod-shredder -v -r odyssey -f slurm -i /tmp/slurm-${ndate}.log &>> /var/log/xdmod/shredder.log

# Step 3 - Ingest the data to make Summaries from hierarchy
xdmod-ingestor -v --start-date ${ndate} &>> /var/log/xdmod/ingestor.log

