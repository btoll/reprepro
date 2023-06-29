#!/usr/bin/env python3

import os
import subprocess


packages_dir = "/vagrant/packages"
package_names = [name for name in os.listdir(packages_dir) if os.path.isdir(f"{packages_dir}/{name}")]

for package_name in package_names:
    out = subprocess.run(["bash", "-c", f"reprepro --basedir base listfilter bullseye 'Package (== {package_name}), Version (== 1.0.0)'"], capture_output=True, check=True)

    if not len(out.stdout):
        deb = f"{package_name}_1.0.0_amd64.deb"
        dsc = f"{package_name}_1.0.0.dsc"

        try:
            subprocess.run(["bash", "-c", f"reprepro --basedir base includedeb bullseye {packages_dir}/{package_name}/1.0.0/{deb}"], capture_output=False, check=True)
            print(f"Imported {packages_dir}/{package_name}/1.0.0/{deb}")
        except subprocess.CalledProcessError as exc:
            print(
                f"Process failed because did not return a successful return code. "
                f"Returned {exc.returncode}\n{exc}"
            )

        try:
            subprocess.run(["bash", "-c", f"reprepro --basedir base includedsc bullseye {packages_dir}/{package_name}/1.0.0/{dsc}"], capture_output=False, check=True)
            print(f"Imported {packages_dir}/{package_name}/1.0.0/{dsc}")
        except subprocess.CalledProcessError as exc:
            print(
                f"Process failed because did not return a successful return code. "
                f"Returned {exc.returncode}\n{exc}"
            )

