#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later

# shellcheck source=packaging/makeself/functions.sh
. "$(dirname "${0}")/../functions.sh" "${@}" || exit 1

version="1.35.0"

# shellcheck disable=SC2015
[ "${GITHUB_ACTIONS}" = "true" ] && echo "::group::Building busybox" || true

dir="busybox-${version}"
url="https://www.busybox.net/downloads/busybox-${version}.tar.bz2"
sha256="faeeb244c35a348a334f4a59e44626ee870fb07b6884d68c10ae8bc19f83a694"
key="busybox"

tar="${dir}.tar.bz2"
cache="${NETDATA_SOURCE_PATH}/artifacts/cache/${BUILDARCH}/${key}"

if [ -d "${NETDATA_MAKESELF_PATH}/tmp/${dir}" ]; then
    rm -rf "${NETDATA_MAKESELF_PATH}/tmp/${dir}"
fi

if [ -d "${cache}/${dir}" ]; then
    echo "Found cached copy of build directory for ${key}, using it."
    cp -a "${cache}/${dir}" "${NETDATA_MAKESELF_PATH}/tmp/"
    CACHE_HIT=1
else
    echo "No cached copy of build directory for ${key} found, fetching sources instead."

    if [ ! -f "${NETDATA_MAKESELF_PATH}/tmp/${tar}" ]; then
        run wget -O "${NETDATA_MAKESELF_PATH}/tmp/${tar}" "${url}"
    fi

    # Check SHA256 of gzip'd tar file (apparently alpine's sha256sum requires
    # two empty spaces between the checksum and the file's path)
    set +e
    echo "${sha256}  ${NETDATA_MAKESELF_PATH}/tmp/${tar}" | sha256sum -c -s
    rc=$?
    if [ ${rc} -ne 0 ]; then
        echo >&2 "SHA256 verification of tar file ${tar} failed (rc=${rc})"
        echo >&2 "expected: ${sha256}, got $(sha256sum "${NETDATA_MAKESELF_PATH}/tmp/${tar}")"
        exit 1
    fi
    set -e

    cd "${NETDATA_MAKESELF_PATH}/tmp"
    run tar -jxpf "${tar}"
    cd -

    CACHE_HIT=0
fi

run cd "${NETDATA_MAKESELF_PATH}/tmp/${dir}"

export CFLAGS="-static -pipe"
export LDFLAGS="-static"

if [ "${CACHE_HIT:-0}" -eq 0 ]; then
    run make clean
    run make defconfig
    run make -j "$(nproc)"
fi

run cp busybox_unstripped "${NETDATA_INSTALL_PATH}"/bin/busybox

store_cache busybox "${NETDATA_MAKESELF_PATH}/tmp/busybox-${version}"

if [ "${NETDATA_BUILD_WITH_DEBUG}" -eq 0 ]; then
  run strip "${NETDATA_INSTALL_PATH}"/bin/busybox
fi

# shellcheck disable=SC2015
[ "${GITHUB_ACTIONS}" = "true" ] && echo "::group::Preparing build environment" || true