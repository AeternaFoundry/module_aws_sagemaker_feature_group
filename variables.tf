variable "sagemaker_feature_groups" {
  description = <<EOT
Map of sagemaker_feature_groups, attributes below
Required:
    - event_time_feature_name
    - feature_group_name
    - record_identifier_feature_name
    - role_arn
    - feature_definition (block):
        - collection_config (optional, block):
            - vector_config (optional, block):
                - dimension (optional)
        - collection_type (optional)
        - feature_name (optional)
        - feature_type (optional)
Optional:
    - description
    - region
    - tags
    - tags_all
    - offline_store_config (block):
        - data_catalog_config (optional, block):
            - catalog (optional)
            - database (optional)
            - table_name (optional)
        - disable_glue_table_creation (optional)
        - s3_storage_config (required, block):
            - kms_key_id (optional)
            - resolved_output_s3_uri (optional)
            - s3_uri (required)
        - table_format (optional)
    - online_store_config (block):
        - enable_online_store (optional)
        - security_config (optional, block):
            - kms_key_id (optional)
        - storage_type (optional)
        - ttl_duration (optional, block):
            - unit (optional)
            - value (optional)
    - throughput_config (block):
        - provisioned_read_capacity_units (optional)
        - provisioned_write_capacity_units (optional)
        - throughput_mode (optional)
EOT

  type = map(object({
    event_time_feature_name        = string
    feature_group_name             = string
    record_identifier_feature_name = string
    role_arn                       = string
    description                    = optional(string)
    region                         = optional(string)
    tags                           = optional(map(string))
    tags_all                       = optional(map(string))
    feature_definition = list(object({
      collection_config = optional(object({
        vector_config = optional(object({
          dimension = optional(number)
        }))
      }))
      collection_type = optional(string)
      feature_name    = optional(string)
      feature_type    = optional(string)
    }))
    offline_store_config = optional(object({
      data_catalog_config = optional(object({
        catalog    = optional(string)
        database   = optional(string)
        table_name = optional(string)
      }))
      disable_glue_table_creation = optional(bool)
      s3_storage_config = object({
        kms_key_id             = optional(string)
        resolved_output_s3_uri = optional(string)
        s3_uri                 = string
      })
      table_format = optional(string)
    }))
    online_store_config = optional(object({
      enable_online_store = optional(bool)
      security_config = optional(object({
        kms_key_id = optional(string)
      }))
      storage_type = optional(string)
      ttl_duration = optional(object({
        unit  = optional(string)
        value = optional(number)
      }))
    }))
    throughput_config = optional(object({
      provisioned_read_capacity_units  = optional(number)
      provisioned_write_capacity_units = optional(number)
      throughput_mode                  = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_feature_groups : (
        length(v.feature_definition) >= 1 && length(v.feature_definition) <= 2500
      )
    ])
    error_message = "Each feature_definition list must contain between 1 and 2500 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_feature_groups : (
        (length(v.event_time_feature_name) >= 1 && length(v.event_time_feature_name) <= 64) && (can(regex("^[0-9A-Za-z]([-_]*[0-9A-Za-z]){0,63}", v.event_time_feature_name)))
      )
    ])
    error_message = "all of: must be between 1 and 64 characters; Must start and end with an alphanumeric character and Can only contains alphanumeric characters, hyphens, underscores. Spaces are not allowed."
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_feature_groups : (
        alltrue([for item in v.feature_definition : (item.collection_config == null || (item.collection_config.vector_config == null || (item.collection_config.vector_config.dimension == null || (item.collection_config.vector_config.dimension >= 1 && item.collection_config.vector_config.dimension <= 8192))))])
      )
    ])
    error_message = "must be between 1 and 8192"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_feature_groups : (
        (length(v.feature_group_name) >= 1 && length(v.feature_group_name) <= 64) && (can(regex("^[0-9A-Za-z](-*[0-9A-Za-z]){0,63}", v.feature_group_name)))
      )
    ])
    error_message = "all of: must be between 1 and 64 characters; Must start and end with an alphanumeric character and Can only contain alphanumeric character and hyphens. Spaces are not allowed."
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_feature_groups : (
        (length(v.record_identifier_feature_name) >= 1 && length(v.record_identifier_feature_name) <= 64) && (can(regex("^[0-9A-Za-z]([-_]*[0-9A-Za-z]){0,63}", v.record_identifier_feature_name)))
      )
    ])
    error_message = "all of: must be between 1 and 64 characters; Must start and end with an alphanumeric character and Can only contains alphanumeric characters, hyphens, underscores. Spaces are not allowed."
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_feature_groups : (
        v.throughput_config == null || (v.throughput_config.provisioned_read_capacity_units == null || (v.throughput_config.provisioned_read_capacity_units >= 0 && v.throughput_config.provisioned_read_capacity_units <= 10000000))
      )
    ])
    error_message = "must be between 0 and 10000000"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_feature_groups : (
        v.throughput_config == null || (v.throughput_config.provisioned_write_capacity_units == null || (v.throughput_config.provisioned_write_capacity_units >= 0 && v.throughput_config.provisioned_write_capacity_units <= 10000000))
      )
    ])
    error_message = "must be between 0 and 10000000"
  }
  # Note: 11 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

