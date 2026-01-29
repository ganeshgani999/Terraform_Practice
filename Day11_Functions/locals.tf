locals {
    common_tags = merge(
        var.project_tags,
        var.environment_tags,
    )

    formatted_project_name = lower(replace(var.project_name, " ", "-"))

    formatted_bucket_name = replace(
        substr(lower("${local.formatted_project_name}-bucket"), 0, 63), " ", "-"
    )

    # Convert allowed ports from string to list of numbers
    ports_list = split(", ", var.allowed_ports)


    sg_rules = [
        for port in local.ports_list : {
            description     = "Allow inbound traffic on port ${port}"
            name = "allow_port_${port}"
            port = tonumber(port)
        }
    ]

    instance_size = lookup(var.instace_sizes, var.environment, "t2.micro")


}

