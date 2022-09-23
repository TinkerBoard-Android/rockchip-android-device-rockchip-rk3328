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

# First lunching is S, api_level is 31
PRODUCT_SHIPPING_API_LEVEL := 31
PRODUCT_DTBO_TEMPLATE := $(LOCAL_PATH)/dt-overlay.in
PRODUCT_BOOT_DEVICE := ff520000.dwmmc
BOARD_SELINUX_ENFORCING := false

#
# This file is the build configuration for an aosp Android
# build for rockchip rk3328 hardware. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps). Except for a few implementation
# details, it only fundamentally contains two inherit-product
# lines, aosp and rk3328, hence its name.

include device/rockchip/common/build/rockchip/DynamicPartitions.mk
include device/rockchip/rk3328/rk3328_box/BoardConfig.mk
include device/rockchip/rk3328/rk3328_box_32/BoardConfig.mk
include device/rockchip/common/BoardConfig.mk
$(call inherit-product, device/rockchip/rk3328/device-common.mk)
# Inherit from those products. Most specific first.
$(call inherit-product, device/rockchip/common/device.mk)

PRODUCT_FSTAB_TEMPLATE := device/rockchip/rk3328/fstab_box.in

DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/../overlay
#TODO TV?
PRODUCT_CHARACTERISTICS := tv

PRODUCT_NAME := rk3328_box_32
PRODUCT_DEVICE := rk3328_box_32
PRODUCT_BRAND := Rockchip
PRODUCT_MODEL := rk3328_box
PRODUCT_MANUFACTURER := Rockchip
# Display
TARGET_BASE_PARAMETER_IMAGE := device/rockchip/rk3328/rk3328_box/etc/baseparameter_auto.img


#Need to build system as root for the device upgrading to Q.
#BOARD_BUILD_SYSTEM_ROOT_IMAGE := false

# Disable bluetooth because of continuous driver crashes
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += config.disable_bluetooth=true

BOARD_WITH_SPECIAL_PARTITIONS := baseparameter:1M,logo:16M

# tmp compile needed
BOARD_WITH_RKTOOLBOX := false

# Google TV Service and frp overlay
PRODUCT_USE_PREBUILT_GTVS := no
BUILD_WITH_GOOGLE_FRP := false

BOARD_WITH_SPECIAL_PARTITIONS := baseparameter:1M,logo:16M
# Get the long list of APNs
PRODUCT_COPY_FILES += vendor/rockchip/common/phone/etc/apns-full-conf.xml:system/etc/apns-conf.xml
PRODUCT_COPY_FILES += vendor/rockchip/common/phone/etc/spn-conf.xml:system/etc/spn-conf.xml

PRODUCT_AAPT_CONFIG := normal large tvdpi hdpi
PRODUCT_AAPT_PREF_CONFIG := tvdpi
PRODUCT_PACKAGES += \
    libcrypto_vendor.vendor \
#PRODUCT_PACKAGES += \
    android.hardware.memtrack@1.0-service \
    android.hardware.memtrack@1.0-impl \
    memtrack.$(TARGET_BOARD_PLATFORM)

# GTVS add the Client ID (provided by Google)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-rockchip-tv

# copy input keylayout and device config
keylayout_files := $(shell ls device/rockchip/rk3588/rk3588_box/remote_config )
PRODUCT_COPY_FILES += \
        $(foreach file, $(keylayout_files), device/rockchip/rk3588/rk3588_box/remote_config/$(file):$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/$(file))

# Vendor seccomp policy files for media components:
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/seccomp_policy/mediacodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy

PRODUCT_COPY_FILES += \
    frameworks/av/media/libeffects/data/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \

BOARD_HS_ETHERNET := true

# use box external_camera_config.xml
PRODUCT_USB_CAMERA_CONFIG := $(LOCAL_PATH)/etc/external_camera_config.xml

# TV Input HAL
PRODUCT_PACKAGES += \
    android.hardware.tv.input@1.0-impl

# Display
#TARGET_BASE_PARAMETER_IMAGE := device/rockchip/rk3328/baseparameter.img
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=160 \
    persist.vendor.framebuffer.main=1280x720@60
    ro.vendor.sdkversion=RK3328_ANDROID12.0_BOX_V1.0.6 \
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.zygote=zygote32

# Enable DM file preopting to reduce first boot time
PRODUCT_DEX_PREOPT_GENERATE_DM_FILES := true
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := verify

# Save space for Go-device
DONT_UNCOMPRESS_PRIV_APPS_DEXS := true

# Reduces GC frequency of foreground apps by 50%
PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.foreground-heap-growth-multiplier=2.0
