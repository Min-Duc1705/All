@echo off
echo Starting Build > build_log.txt
echo Checking Flutter version >> build_log.txt
call flutter --version >> build_log.txt 2>&1
echo Running Build... >> build_log.txt
call flutter build web --release >> build_log.txt 2>&1
echo Build Finished. >> build_log.txt
echo Listing build/web: >> build_log.txt
dir build\web >> build_log.txt 2>&1
echo Done. >> build_log.txt
