# VCD Independent Disk Module Details README

This Terraform configuration is designed to manage independent disks in a VMware Cloud Director (VCD) environment. It makes use of the VMware VCD provider to interact with the VCD APIs.

## Resource

The `vcd_independent_disk` resource is used to create and manage independent disks in VCD. The `count` argument is set to the `length` of the `var.disk_params` list, which means that Terraform will create one disk for each object in the `disk_params` list.

Each argument of the resource (like `name`, `size_in_mb`, `bus_type`, `bus_sub_type`, `storage_profile`, and `sharing_type`) uses `count.index` to access the corresponding property of each object in the `disk_params` list. The `count.index` is an implicit variable in Terraform that gives the current iteration of a `count` loop, starting from 0.

A `dynamic "metadata_entry"` block is used inside the `vcd_independent_disk` resource to create metadata entries for each disk. The `for_each` expression is set to the `metadata` property of the current `disk_params` object, which means that one metadata entry will be created for each object in the `metadata` list.

The `content` block defines the properties of each metadata entry, and uses `metadata_entry.value` to access the properties of the current `metadata` object. Here `metadata_entry` is the iteration variable introduced by `for_each`, and `value` is a keyword that refers to the value of the current iteration.

## Variables

The `vdc_org_name` variable is defined without a default value, which means it must be provided when the Terraform configuration is applied.

The `disk_params` variable is a complex variable that defines the parameters for creating disks. Its type is a list of objects, where each object represents a disk and has properties for `name`, `size_in_mb`, `bus_type`, `bus_sub_type`, `storage_profile`, `sharing_type`, and `metadata`.

The `metadata` property itself is a list of objects, where each object represents a metadata entry and has properties for `key`, `value`, `type`, `user_access`, and `is_system`.

A default value is provided for `disk_params`, which describes two disks with no metadata.

## Outputs

The `outputs.tf` file defines an output variable called `independent_disks`. This output is a map where the keys are the IDs of the created disks, and the values are maps of the disks' properties.

The value of `independent_disks` is created using a `for` expression, which iterates over `vcd_independent_disk.disk` (i.e., the disks created by the `vcd_independent_disk` resource). For each disk, it creates a key-value pair where the key is the disk's ID and the value is a map of the disk's properties.

## Summary

This Terraform configuration provides a flexible way to create and manage independent disks in a VCD environment. It uses a `count` loop to create multiple disks based on the `disk_params` input variable, and a dynamic block to create metadata entries for each disk. The output provides a detailed view of the properties of the created disks.
