variable "app_name" {
  type        = string
  description = "Kubernetes app name used for Deployment and Service."
}

variable "app_html" {
  type        = string
  description = "HTML content served by the test application."
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace for the test app."
  default     = "default"
}

variable "replicas" {
  type        = number
  description = "Number of app replicas."
  default     = 1
}
