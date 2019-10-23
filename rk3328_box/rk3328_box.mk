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

TARGET_BOARD_PLATFORM_PRODUCT := box
TARGET_BASE_PARAMETER_IMAGE := device/rockchip/common/baseparameter/baseparameter_fb720.img

# First lunching is Q, api_level is 29
PRODUCT_SHIPPING_API_LEVEL := 29
PRODUCT_FSTAB_TEMPLATE := $(LOCAL_PATH)/fstab.in
PRODUCT_DTBO_TEMPLATE := $(LOCAL_PATH)/dt-overlay.in
PRODUCT_BOOT_DEVICE := ff520000.dwmmc

#
# This file is the build configuration for an aosp Android
# build for rockchip rk3328 hardware. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps). Except for a few implementation
# details, it only fundamentally contains two inherit-product
# lines, aosp and rk3328, hence its name.

include device/rockchip/common/build/rockchip/DynamicPartitions.mk
include device/rockchip/common/BoardConfig.mk
include device/rockchip/rk3328/rk3328_box/BoardConfig.mk
$(call inherit-product, device/rockchip/rk3328/device-common.mk)
# Inherit from those products. Most specific first.
$(call inherit-product, device/rockchip/common/device.mk)

#TODO TV?
PRODUCT_CHARACTERISTICS := tv

PRODUCT_NAME := rk3328_box
PRODUCT_DEVICE := rk3328_box
PRODUCT_BRAND := Android
PRODUCT_MODEL := rk3328
PRODUCT_MANUFACTURER := Rockchip

#BUILD_WITH_GO_OPT := true

# No need to place dtb into boot.img for the device upgrading to Q.
BOARD_INCLUDE_DTB_IN_BOOTIMG :=
BOARD_PREBUILT_DTBIMAGE_DIR :=

#Need to build system as root for the device upgrading to Q.
#BOARD_BUILD_SYSTEM_ROOT_IMAGE := false

# Disable bluetooth because of continuous driver crashes
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += config.disable_bluetooth=true

# Google TV Service and frp overlay
BUILD_WITH_GTVS := false
BUILD_WITH_GOOGLE_FRP := false

# Get the long list of APNs
PRODUCT_COPY_FILES += vendor/rockchip/common/phone/etc/apns-full-conf.xml:system/etc/apns-conf.xml
PRODUCT_COPY_FILES += vendor/rockchip/common/phone/etc/spn-conf.xml:system/etc/spn-conf.xml

PRODUCT_AAPT_CONFIG := normal large tvdpi hdpi
PRODUCT_AAPT_PREF_CONFIG := tvdpi

# TV Input HAL
PRODUCT_PACKAGES += \
    android.hardware.tv.input@1.0-impl
