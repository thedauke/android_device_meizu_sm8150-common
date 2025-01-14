#!/bin/bash
#
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

export DEVICE=m1928
export VENDOR=meizu


# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

RR_ROOT="${MY_DIR}/../../.."

HELPER="${RR_ROOT}/vendor/rr/build/tools/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true
SECTION=
KANG=

while [ "$1" != "" ]; do
    case "$1" in
        -n | --no-cleanup )     CLEAN_VENDOR=false
                                ;;
        -k | --kang)            KANG="--kang"
                                ;;
        -s | --section )        shift
                                SECTION="$1"
                                CLEAN_VENDOR=false
                                ;;
        * )                     SRC="$1"
                                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC=adb
fi

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${RR_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" ${KANG} --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"

# "./../../${VENDOR}/${DEVICE}/extract-files.sh" "$@"

# BLOB_ROOT="${RR_ROOT}/vendor/${VENDOR}/${DEVICE}/proprietary"
