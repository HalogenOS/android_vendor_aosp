# Charger
# Accept WITH_LINEAGE_CHARGER to keep compatibility with some device trees
ifeq ($(WITH_LINEAGE_CHARGER),true)
    BOARD_HAL_STATIC_LIBRARIES := libhealthd.custom
endif
# This is the new standard
ifeq ($(WITH_CUSTOM_CHARGER),true)
    BOARD_HAL_STATIC_LIBRARIES := libhealthd.custom
endif

include $(CUSTOM_VENDOR_DIR)/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include $(CUSTOM_VENDOR_DIR)/config/BoardConfigQcom.mk
endif

include $(CUSTOM_VENDOR_DIR)/config/BoardConfigSoong.mk
