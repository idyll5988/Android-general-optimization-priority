#!/system/bin/sh
[ ! "$MODDIR" ] && MODDIR=${0%/*}
MODPATH="/data/adb/modules/AA+™"
[[ ! -e ${MODDIR}/ll/log ]] && mkdir -p ${MODDIR}/ll/log
source "${MODPATH}/scripts/GK.sh"
while true; do
    screen_status=$(dumpsys window | grep "mScreenOn" | grep "true")
    if [[ "${screen_status}" ]]; then
        su -c "cmd activity kill-all"
        su -c "cmd package trim-caches 999G"
        for a in android com.android.systemui; do
            su -c "chrt -f -p 99 $(pgrep -f $a)"
            su -c "cmd activity clear-exit-info $a"
            su -c "taskset -p ff $(pgrep -f $a)"
        done >/dev/null 2>&1
    fi
    sleep 10
done
