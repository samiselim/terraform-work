variable "project" {}
variable "credentials_file" {}
variable "region" {
  default = "us-central1"
}
variable "zone" {
  default = "us-central1-a"
}
variable "os_image" {
  default = "debian-cloud/debian-11"
}
# variable "vm_param" {
#     type = tuple([ string , string , bool ])
#     description = "[0]Machine Type , [1]Zone , [2]Allow Stopping Update"
#     default = [ "e2-micro" , "us-central1-a" , true]
# }


# # easy to convert 12 or true to string
# variable "my-list" {
#   description = "this is the list "
#   type = list(string)
#   default = [12,"sami",true]
# }

# ## Wrong way : not able to convert "sami" or true to number
# # variable "my-list2" {
# #   description = "this is the list 2"
# #   type = list(number)
# #   default = [12,"sami"]
# # }

# # easy way to convert "30.5" to number
# variable "my-list3" {
#     description = "this is the list 3"
#     type = list(number)
#     default = [12,"30.5"]
# }
# variable "my-tuple" {
#     type = tuple([ string , number , bool ])
#     default = [ "value", 0 , false ]
# }
# variable "my-set" {
#    type = set(number)
#    description = "set elements not repeatable "
#    default = [ 5,55,2,12,2,4,55,5 ] # = [5,55,2,12,4]
# }

# variable "mapp" {
#     type = map(string)
#     description = "same type"
#     default = {
#         value1="value1"
#         value2="value2" 
#     }
# }
variable "instanceConfigs" {
    type = object({
        name = string
        machine_type = string
        zone = string
        allow_stopping_for_update = bool
        disk = object({
            source_image = string
        })
    })
    default = {
        name = "my-instance"
        machine_type = "e2-micro"
        zone = "us-central1-a"
        allow_stopping_for_update = true
        disk = {
            source_image = "debian-cloud/debian-11"
        }
    }
    validation {
        condition = length(var.instanceConfigs.name) > 3
        error_message = "ERROR MESSAGE: Vm name must be greater than3 chars "
    }

}