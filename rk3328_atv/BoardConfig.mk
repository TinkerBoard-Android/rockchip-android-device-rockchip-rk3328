#
# Copyright 2014 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include device/rockchip/rk3328/BoardConfig.mk

PRODUCT_UBOOT_CONFIG ?= rk3328
PRODUCT_KERNEL_ARCH ?= arm64
PRODUCT_KERNEL_DTS ?= rk3328-evb-android-avb
PRODUCT_KERNEL_CONFIG ?= rockchip_defconfig android-10.config
BOARD_ROCKCHIP_DYNAMIC_PARTITIONS_SIZE := 2848000000
BOARD_AVB_ENABLE := true
