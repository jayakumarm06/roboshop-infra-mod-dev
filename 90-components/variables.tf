variable "project" {
  default = "roboshop"

}

variable "environment" {
  default = "dev"

}



variable "zone_id" {
  default = "Z05495581I6HEYCS2FC3W"

}

variable "domain_name" {
  default = "dewsecopai.online"

}

variable "components" {
  default = {
    # frontend = {
    #   rule_priority = 10
    #   app_version   = "v4"
    # }

    user = {
      rule_priority = 20
      app_version   = "v4"
    }
    # cart = {
    #   rule_priority = 30
    #   app_version   = "v4"
    # }
    # shipping = {
    #   rule_priority = 40
    #   app_version   = "v4"
    # }
    # payment = {
    #   rule_priority = 50
    #   app_version   = "v4"
    # }
  }

}
