#
# custom macros
#
define uniq
$(if $1,$(firstword $1) $(call uniq,$(filter-out $(firstword $1),$1)))
endef

# Include board/platform macros
include $(CUSTOM_VENDOR_DIR)/build/core/utils.mk

# Include vendor platform definitions
include $(CUSTOM_VENDOR_DIR)/build/core/vendor/*.mk
