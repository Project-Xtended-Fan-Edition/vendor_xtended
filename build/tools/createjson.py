#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# SPDX-FileCopyrightText: 2025 The Evolution X Project
# SPDX-License-Identifier: Apache-2.0

import argparse
import os
import hashlib
import json

def generate_json(target_device, product_out, file_name, build_variant, with_gms):
    output = os.path.join(product_out, f"{target_device}.json")

    if os.path.exists(output):
        os.remove(output)

    channel = "15_vanilla" if with_gms == "false" else "15"

    existing_ota_json = os.path.join(f"./xtended/OTA{'-VANILLA' if with_gms == 'false' else ''}/builds", f"{target_device}.json")

    maintainer, oem, device, forum, firmware, paypal, telegram, github, initial_installation_images = "", "", "", "", "", "", "", "", []

    if os.path.exists(existing_ota_json):
        with open(existing_ota_json, 'r') as f:
            ota_data = json.load(f)
        response_data = ota_data["response"][0]
        maintainer = response_data.get("maintainer", "")
        oem = response_data.get("oem", "")
        device = response_data.get("device", "")
        forum = response_data.get("forum", "")
        firmware = response_data.get("firmware", "")
        paypal = response_data.get("paypal", "")
        telegram = response_data.get("telegram", "")
        github = response_data.get("github", "")
        initial_installation_images = response_data.get("initial_installation_images", [])

    filename = file_name
    download = f"https://sourceforge.net/projects/evolution-x/files/{target_device}/{channel}/{file_name}/download"
    version = file_name.split('-')[4]
    v_max, v_min = version.split('.')[0], version.split('.')[1]
    version = f"{v_max}.{v_min}"
    buildprop = os.path.join(product_out, "system", "build.prop")
    timestamp = get_timestamp_from_buildprop(buildprop)
    md5 = get_checksum(os.path.join(product_out, file_name), 'md5')
    sha256 = get_checksum(os.path.join(product_out, file_name), 'sha256')
    size = os.path.getsize(os.path.join(product_out, file_name))

    json_data = {
        "response": [
            {
                "maintainer": maintainer,
                "oem": oem,
                "device": device,
                "filename": filename,
                "download": download,
                "timestamp": timestamp,
                "md5": md5,
                "sha256": sha256,
                "size": size,
                "version": version,
                "buildtype": build_variant,
                "forum": f"{forum}" if forum else "",
                "firmware": f"{firmware}" if firmware else "",
                "paypal": f"{paypal}" if paypal else "",
                "telegram": f"{telegram}" if telegram else "",
                "github": github,
                "initial_installation_images": initial_installation_images
            }
        ]
    }

    with open(output, 'w') as f:
        json.dump(json_data, f, indent=2)

def get_timestamp_from_buildprop(buildprop_path):
    with open(buildprop_path, 'r') as f:
        for line in f:
            if "ro.system.build.date.utc" in line:
                return int(line.split('=')[1].strip())
    return 0

def get_checksum(file_path, checksum_type='md5'):
    if checksum_type == 'md5':
        return calculate_md5(file_path)
    elif checksum_type == 'sha256':
        return calculate_sha256(file_path)

def calculate_md5(file_path):
    hash_md5 = hashlib.md5()
    with open(file_path, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()

def calculate_sha256(file_path):
    hash_sha256 = hashlib.sha256()
    with open(file_path, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash_sha256.update(chunk)
    return hash_sha256.hexdigest()

def main():
    parser = argparse.ArgumentParser(description="Generate a JSON file for OTA.")
    parser.add_argument("target_device", help="Target device name")
    parser.add_argument("product_out", help="Product output directory")
    parser.add_argument("file_name", help="File name for OTA")
    parser.add_argument("build_variant", help="Build variant")
    parser.add_argument("with_gms", help="Whether with GMS (true/false)")

    args = parser.parse_args()
    generate_json(args.target_device, args.product_out, args.file_name, args.build_variant, args.with_gms)

if __name__ == "__main__":
    main()
