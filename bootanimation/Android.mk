#
# Copyright (C) 2016 The CyanogenMod Project
#               2017-2019 The LineageOS Project
# Copyright (C) 2019 The halogenOS Project
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

ifeq ($(TARGET_SCREEN_WIDTH),)
    $(warning TARGET_SCREEN_WIDTH is not set, using default value: 1080)
    TARGET_SCREEN_WIDTH := 1080
endif
ifeq ($(TARGET_SCREEN_HEIGHT),)
    $(warning TARGET_SCREEN_HEIGHT is not set, using default value: 1920)
    TARGET_SCREEN_HEIGHT := 1920
endif

TARGET_GENERATED_BOOTANIMATION := $(TARGET_OUT_INTERMEDIATES)/BOOTANIMATION/bootanimation.zip
$(TARGET_GENERATED_BOOTANIMATION): INTERMEDIATES := $(TARGET_OUT_INTERMEDIATES)/BOOTANIMATION
$(TARGET_GENERATED_BOOTANIMATION): $(SOONG_ZIP)
	@echo "Building bootanimation.zip"
	@rm -rf $(INTERMEDIATES)
	@mkdir -p $(INTERMEDIATES)
	$(hide) cp -R $(CUSTOM_VENDOR_DIR)/bootanimation/bootanimation/. $(INTERMEDIATES)/.
	$(hide) if [ $(TARGET_SCREEN_HEIGHT) -lt $(TARGET_SCREEN_WIDTH) ]; then \
	    IMAGEWIDTH=$(TARGET_SCREEN_WIDTH); \
	else \
	    IMAGEHEIGHT=$(TARGET_SCREEN_HEIGHT); \
	fi; \
	MOGRIFY="prebuilts/tools-lineage/${HOST_OS}-x86/bin/mogrify"; \
	RESOLUTION="$$IMAGEWIDTH"x"$$IMAGEHEIGHT" ; \
	$$MOGRIFY -resize $$RESOLUTION $(INTERMEDIATES)/*/*.png; \
	NEWWIDTH="$$($$MOGRIFY -print %w $(INTERMEDIATES)/part0/$$(ls $(INTERMEDIATES)/part0 | head -n1))"; \
	NEWHEIGHT="$$($$MOGRIFY -print %h $(INTERMEDIATES)/part0/$$(ls $(INTERMEDIATES)/part0 | head -n1))"; \
	echo "$$NEWWIDTH $$NEWHEIGHT 60" > $(INTERMEDIATES)/desc.txt; \
	cat $(CUSTOM_VENDOR_DIR)/bootanimation/desc.txt >> $(INTERMEDIATES)/desc.txt
	$(hide) $(SOONG_ZIP) -L 0 -o $(TARGET_GENERATED_BOOTANIMATION) -C $(INTERMEDIATES) -D $(INTERMEDIATES)

ifeq ($(TARGET_BOOTANIMATION),)
    TARGET_BOOTANIMATION := $(TARGET_GENERATED_BOOTANIMATION)
endif

include $(CLEAR_VARS)
LOCAL_MODULE := bootanimation.zip
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT)/media

include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): $(TARGET_BOOTANIMATION)
	@cp $(TARGET_BOOTANIMATION) $@
