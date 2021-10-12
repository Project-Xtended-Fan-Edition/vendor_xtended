# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017,2020 The LineageOS Project
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

# -----------------------------------------------------------------
# Xtended OTA update package

LINEAGE_TARGET_PACKAGE := $(PRODUCT_OUT)/$(LINEAGE_VERSION).zip

SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

CL_PRP="\033[35m"
CL_RED="\033[31m"
CL_GRN="\033[32m"

$(LINEAGE_TARGET_PACKAGE): $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) mv -f $(INTERNAL_OTA_PACKAGE_TARGET) $(LINEAGE_TARGET_PACKAGE)
	$(hide) $(SHA256) $(LINEAGE_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(LINEAGE_TARGET_PACKAGE).sha256sum
	$(hide) ./vendor/lineage/build/tools/createjson.py $(TARGET_DEVICE) $(PRODUCT_OUT) $(LINEAGE_VERSION).zip $(TARGET_BUILD_VARIANT) $(WITH_GMS)
	$(hide) rm -rf $(call intermediates-dir-for,PACKAGING,target_files)
	echo -e ${CL_BLD}${CL_RED}"===============================-Package complete-==============================="${CL_RED}
	echo -e ${CL_RED}"***********************************************" 
	echo -e ${CL_RED}"                                               "
	echo -e ${CL_RED}"██╗  ██╗██████╗█████╗█╗   █╗████╗ █████╗████╗  "
	echo -e ${CL_RED}"╚██╗██╔╝╚═██╔═╝█╔═══╝██╗  █║█╔══█╗█╔═══╝█╔══█╗ "
	echo -e ${CL_RED}" ╚███╔╝   ██║  ████╗ █╔█╗ █║█║  █║████╗ █║  █║ "
	echo -e ${CL_RED}" ██╔██╗   ██║  █╔══╝ █║╚█╗█║█║  █║█╔══╝ █║  █║ "
	echo -e ${CL_RED}"██╔╝ ██╗  ██║  █████╗█║ ╚██║████╔╝█████╗████╔╝ "
	echo -e ${CL_RED}"╚═╝  ╚═╝  ╚═╝  ╚════╝╚╝  ╚═╝╚═══╝ ╚════╝╚═══╝  "
	echo -e ${CL_RED}"                                               "
	echo -e ${CL_RED}"***********************************************"
	echo -e ${CL_RED}"             Be Ready To Get Xtended           "
	echo -e ${CL_RED}"***********************************************"
	echo -e ${CL_RED}"    The Project-Xtended ROM by Team-Xtended    "
	echo -e ${CL_RED}"***********************************************"
	echo -e ${CL_BLD}${CL_RED}"===============================-Package complete-==============================="${CL_RED}
	echo -e ${CL_BLD}${CL_RED}"Zip: "${CL_RED} $(LINEAGE_TARGET_PACKAGE)${CL_RST}
	echo -e ${CL_BLD}${CL_RED}"SHA256: "${CL_RED}" `cat $(LINEAGE_TARGET_PACKAGE).sha256sum | awk '{print $$1}' `"${CL_RST}
	echo -e ${CL_BLD}${CL_RED}"Size:"${CL_RED}" `du -sh $(LINEAGE_TARGET_PACKAGE) | awk '{print $$1}' `"${CL_RST}
	echo -e ${CL_BLD}${CL_RED}"TimeStamp:"${CL_RED}" `cat $(PRODUCT_OUT)/system/build.prop | grep ro.build.date.utc | cut -d'=' -f2 | awk '{print $$1}' `"${CL_RST}
	echo -e ${CL_BLD}${CL_RED}"Integer Value:"${CL_RED}" `wc -c $(LINEAGE_TARGET_PACKAGE) | awk '{print $$1}' `"${CL_RST}
	echo -e ${CL_BLD}${CL_RED}"================================================================================"${CL_RED}

.PHONY: xtended
xtended: $(LINEAGE_TARGET_PACKAGE) $(DEFAULT_GOAL)
