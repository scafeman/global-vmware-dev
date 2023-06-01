# VCD NSX-T Edge Gateway Firewall Module Details README

This Terraform configuration is designed to manage the firewall rules of a VMware Cloud Director (VCD) environment. It makes use of the VMware VCD provider to interact with the VCD APIs.

## Data Sources

Data sources are used to fetch the data that already exists in your VCD environment. The configuration uses several data sources:

- `vcd_vdc_group`: Fetches the Virtual Data Center (VDC) group data.
- `vcd_nsxt_edgegateway`: Fetches the NSX-T Edge Gateway data.
- `vcd_nsxt_app_port_profile`: Fetches application port profile data.
- `vcd_nsxt_ip_set`: Fetches the NSX-T IP sets.
- `vcd_nsxt_dynamic_security_group`: Fetches the dynamic security group data.
- `vcd_nsxt_security_group`: Fetches the security group data.

The data sources use `for_each` expressions to fetch multiple sets of data in parallel. For example, `vcd_nsxt_app_port_profile` and `vcd_nsxt_ip_set` fetch data for each of the app port profiles and IP sets specified in the input variables.

## Resource

The `vcd_nsxt_distributed_firewall` resource manages the NSX-T Distributed Firewall rules. It uses a `for_each` statement within a `dynamic` block to create a firewall rule for each entry in the `var.rules` list.

The `source_ids`, `destination_ids`, and `app_port_profile_ids` use conditional expressions and the `try` function to set their values based on the provided input. If the input does not provide a list for these parameters, it defaults to `null`.

## Functions

Several Terraform functions are used in this configuration:

- `toset`: Used to convert a list to a set, ensuring each value is unique.
- `lookup`: Retrieves the value of a key in a map, or a default value if the key isn't present.
- `length`: Used to check if the optional parameters in `var.rules` have been provided.
- `try`: Attempts to evaluate an expression and returns a default value if the evaluation fails.

## Input Variables

Input variables are defined in the `variables.tf` file. These variables include the name of the VDC organization, the VDC group, and the edge gateway. Other variables define the app port profiles, IP set names, dynamic and static security group names, and the rules to apply to the Distributed Firewall.

The `rules` variable is a list of objects. Each object has parameters like `name`, `direction`, `ip_protocol`, `action`, etc. Some of these parameters are optional and have default values set within the `vcd_nsxt_distributed_firewall` resource.

## Summary

This Terraform configuration is a robust example of how to manage NSX-T Distributed Firewall rules in a VCD environment. It uses a combination of data sources, resources, variables, and functions to create a flexible and reusable configuration. The code allows for the dynamic creation and management of firewall rules based on input variables, providing an efficient and consistent way to manage network security.
