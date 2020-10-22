
include $(CUSTOM_VENDOR_DIR)/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include $(CUSTOM_VENDOR_DIR)/config/BoardConfigQcom.mk
endif

include $(CUSTOM_VENDOR_DIR)/config/BoardConfigSoong.mk
