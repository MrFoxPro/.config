#!/usr/bin/env bash

CMD="efibootmgr --create --disk /dev/nvme1n1 --part 1 --loader /vmlinuz-linux --quiet"
BASE="root=UUID=7d51ba80-a243-4694-93a6-a7cf3fdbf30d initrd=\initramfs-linux.img rw quiet splash loglevel=3 mitigations=off i8042.noaux=1"

$CMD --label 'Arch gpu:intel_only' --unicode "$BASE module_blacklist=nvidia nvidia_drm.modeset=0 preset=intel_only"
$CMD --label 'Arch gpu:nvidia_only' --unicode "$BASE i915.modeset=0 nvidia_drm.modeset=1 preset=nvidia_only"
$CMD --label 'Arch gpu:both' --unicode "$BASE preset=both"
efibootmgr --remove-dups
