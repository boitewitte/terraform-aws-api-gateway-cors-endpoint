variable "api_id" {
  type = "string"
  description = "The ID of the API Gateway."
}

variable "endpoint_id" {
  type = "string"
  description = "The ID of the endpoint within the API Gateway"  
}

variable "all_headers" {
  description = "Allow all Headers (*)"
  default = false
}

variable "headers" {
  type = "list"
  description = "List of all the Headers that are allowed (only applied when all_headers = false)"
  default = []
}

variable "all_methods" {
  description = "Allow all Methods (*)"
  default = false
}

variable "methods" {
  type = "list"
  description = "List of all the Methods that are allowed (only applied when all_methods = false)"
  default = []
}

variable "all_origins" {
  description = "Allow all Origins (*)"
  default = false
}

variable "origins" {
  type = "list"
  description = "List of all the Origins that are allowed (only applied when all_origins = false)"
  default = []
}
