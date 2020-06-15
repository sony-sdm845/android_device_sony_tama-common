LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := android.hardware.biometrics.fingerprint@2.1-service.sony
LOCAL_INIT_RC := android.hardware.biometrics.fingerprint@2.1-service.sony.rc
LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_SRC_FILES := \
    $(call all-subdir-cpp-files) \
    QSEEComFunc.c \
    ion_buffer.c \
    common.c

LOCAL_SRC_FILES += fpc_imp_yoshino_nile_tama.c
HAS_FPC := true
LOCAL_CFLAGS += \
    -DUSE_FPC_TAMA \
    -DHAS_DYNAMIC_POWER_MANAGEMENT

ifneq ($(HAS_FPC),true)
# This file heavily depends on fpc_ implementations from the
# above fpc_imp_* files. There is no sensible default file
# on some platforms, so just remove the file altogether:
LOCAL_SRC_FILES -= BiometricsFingerprint.cpp
endif

LOCAL_SHARED_LIBRARIES := \
    android.hardware.biometrics.fingerprint@2.1 \
    libcutils \
    libdl \
    libhardware \
    libhidlbase \
    libhidltransport \
    libion \
    liblog \
    libutils

LOCAL_CFLAGS += \
    -DPLATFORM_SDK_VERSION=$(PLATFORM_SDK_VERSION) \
    -fexceptions

include $(BUILD_EXECUTABLE)
