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

# Use the non-open-source parts, if they're present
-include vendor/rockchip/rk3328/BoardConfigVendor.mk

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a53
TARGET_CPU_SMP := true

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53
TARGET_PREBUILT_KERNEL := kernel/arch/arm64/boot/Image

# support devices to install magisk through include ramdisk in boot.img
BOOTIMG_SUPPORT_MAGISK := false

BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_AVB_ENABLE := false
ifneq ($(filter true, $(BOARD_AVB_ENABLE)), )
BOARD_KERNEL_CMDLINE := console=ttyFIQ0 androidboot.baseband=N/A androidboot.selinux=permissive androidboot.wificountrycode=US androidboot.veritymode=enforcing androidboot.hardware=rk30board androidboot.console=ttyFIQ0 firmware_class.path=/vendor/etc/firmware init=/init rootwait ro init=/init
init=/init rootwait ro init=/init
PRODUCT_COPY_FILES += \
        frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml
else
#Config the cmdline for boot or recpvery
BOARD_KERNEL_CMDLINE := console=ttyFIQ0 androidboot.baseband=N/A androidboot.selinux=permissive androidboot.wificountrycode=US androidboot.veritymode=enforcing androidboot.hardware=rk30board androidboot.verifiedbootstate=orange androidboot.console=ttyFIQ0 firmware_class.path=/vendor/etc/firmware init=/init rootwait ro init=/init root=PARTUUID=af01642c-9b84-11e8-9b2a-234eb5e198a0
endif

ifneq ($(filter true, $(BOOTIMG_SUPPORT_MAGISK)), )
BOARD_KERNEL_CMDLINE += skip_initramfs
endif

BOARD_KERNEL_CMDLINE += loop.max_part=7

BOARD_KERNEL_CMDLINE += androidboot.boot_devices=ff520000.dwmmc

BOARD_KERNEL_CMDLINE += earlyprintk=uart8250-32bit,0xff130000 swiotlb=1 kpti=0 coherent_pool=1m

# Disable emulator for "make dist" until there is a 64-bit qemu kernel
BUILD_EMULATOR := false
TARGET_BOARD_PLATFORM := rk3328
TARGET_BOARD_PLATFORM_GPU := mali450
BOARD_USE_DRM := true

# RenderScript
# OVERRIDE_RS_DRIVER := libnvRSDriver.so
BOARD_OVERRIDE_RS_CPU_VARIANT_32 := cortex-a53
BOARD_OVERRIDE_RS_CPU_VARIANT_64 := cortex-a53
# DISABLE_RS_64_BIT_DRIVER := true

TARGET_USES_64_BIT_BCMDHD := true
TARGET_USES_64_BIT_BINDER := true

# HACK: Build apps as 64b for volantis_64_only
ifneq (,$(filter ro.zygote=zygote64, $(PRODUCT_DEFAULT_PROPERTY_OVERRIDES)))
TARGET_PREFER_32_BIT_APPS :=
TARGET_SUPPORTS_64_BIT_APPS := true
endif

ENABLE_CPUSETS := true

BOARD_CAMERA_SUPPORT := false
BOARD_CAMERA_SUPPORT_EXT := false
BOARD_NFC_SUPPORT := false
BOARD_HAS_GPS := false

BOARD_GRAVITY_SENSOR_SUPPORT := false
BOARD_COMPASS_SENSOR_SUPPORT := false
BOARD_GYROSCOPE_SENSOR_SUPPORT := false
BOARD_PROXIMITY_SENSOR_SUPPORT := false
BOARD_LIGHT_SENSOR_SUPPORT := false
BOARD_PRESSURE_SENSOR_SUPPORT := false
BOARD_TEMPERATURE_SENSOR_SUPPORT := false
BOARD_USB_HOST_SUPPORT := true
BOARD_USER_FAKETOUCH := false

PRODUCT_HAVE_RKAPPS := true

# for optee support
PRODUCT_HAVE_OPTEE := true

BOARD_USE_SPARSE_SYSTEM_IMAGE := true

# Google Service and frp overlay
BUILD_WITH_GOOGLE_MARKET := false
BUILD_WITH_GOOGLE_MARKET_ALL := false
BUILD_WITH_GOOGLE_FRP := false
# Add widevine L3 support
BOARD_WIDEVINE_OEMCRYPTO_LEVEL := 3

#for microsoft drm
BUILD_WITH_MICROSOFT_PLAYREADY :=true
DEVICE_MANIFEST_FILE := $(TARGET_DEVICE_DIR)/manifest.xml

# copy mount rc file for FDE
PRODUCT_COPY_FILES += $(LOCAL_PATH)/init.mount_all.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.mount_all.rc

# enable SVELTE malloc
#MALLOC_SVELTE := true

#Config omx to support codec type.
BOARD_SUPPORT_VP9 := false
BOARD_SUPPORT_VP6 := false
