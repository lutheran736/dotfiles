#!/bin/bash
# Default acpi script that takes an entry for all actions

case "$1" in
button/power)
    case "$2" in
    PBTN | PWRF)
        /etc/acpi/suspend_slock
        logger 'PowerButton pressed'
        ;;
    *)
        logger "ACPI action undefined: $2"
        ;;
    esac
    ;;
button/sleep)
    case "$2" in
    SLPB | SBTN)
        logger 'SleepButton pressed'
        ;;
    *)
        logger "ACPI action undefined: $2"
        ;;
    esac
    ;;
ac_adapter)
    case "$2" in
    AC* | AD*)
        case "$4" in
        00000000)
            echo "powersave" >/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
            echo -n 10 >/sys/class/backlight/acpi_video0/brightness
            logger 'AC unpluged'
            ;;
        00000001)
            echo "performance" >/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
            echo -n 15 >/sys/class/backlight/acpi_video0/brightness
            logger 'AC pluged'
            ;;
        esac
        ;;
    *)
        logger "ACPI action undefined: $2"
        ;;
    esac
    ;;
battery)
    case "$2" in
    BAT0)
        case "$4" in
        00000000)
            logger 'Battery online'
            ;;
        00000001)
            logger 'Battery offline'
            ;;
        esac
        ;;
    CPU0) ;;
    *) logger "ACPI action undefined: $2" ;;
    esac
    ;;
button/lid)
    case "$3" in
    close)
        /etc/acpi/suspend_slock
        logger 'LID closed'
        ;;
    open)
        sv restart NetworkManager
        logger 'LID opened'
        ;;
    *)
        logger "ACPI action undefined: $3"
        ;;
    esac
    ;;
jack/headphone)
    case "$3" in
    plug)
        mpc play
        ;;
    unplug)
        mpc pause
        ;;
    *)
        logger "ACPI action undefined: $3"
        ;;
    esac
    ;;
button/mute) 
    ;;
*)
    logger "ACPI group/action undefined: $1 / $2"
    ;;
esac

# vim:set ts=4 sw=4 ft=sh et:
