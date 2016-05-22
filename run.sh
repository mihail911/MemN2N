#!/bin/bash

tasks="1 "
time for task in $tasks; do
  echo "running task: $task"
  for run in {1..5}; do
    python -u main.py --task $task > results/${task}_${run}.txt &
  done
  wait
done

for task in $tasks; do
  best=`grep -H TRAIN_ERROR results/${task}_*.txt | sort -n -k2 | head -n 1 | awk -F ":" '{print $1}'`
  echo "TASK $task: `grep TEST_ERROR $best | tail -n 1`"
done

