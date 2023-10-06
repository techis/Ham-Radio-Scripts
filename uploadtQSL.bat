@echo off
cd %1%
tqsl -d -u -a compliant -x -l "%2" %3 2> "%4\%2%_tqsl.txt"
exit 0