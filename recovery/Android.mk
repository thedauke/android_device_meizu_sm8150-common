LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := librecovery_updater_meizu_m1928

LOCAL_C_INCLUDES := \
    bootable/recovery \
    bootable/recovery/edify/include \
    bootable/recovery/otautil/include

LOCAL_SRC_FILES := recovery_updater.cpp

include $(BUILD_STATIC_LIBRARY)
