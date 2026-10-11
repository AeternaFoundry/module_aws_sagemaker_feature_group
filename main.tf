resource "aws_sagemaker_feature_group" "sagemaker_feature_groups" {
  for_each = var.sagemaker_feature_groups

  event_time_feature_name        = each.value.event_time_feature_name
  feature_group_name             = each.value.feature_group_name
  record_identifier_feature_name = each.value.record_identifier_feature_name
  role_arn                       = each.value.role_arn
  description                    = each.value.description
  region                         = each.value.region
  tags                           = each.value.tags
  tags_all                       = each.value.tags_all

  dynamic "feature_definition" {
    for_each = each.value.feature_definition
    content {
      dynamic "collection_config" {
        for_each = feature_definition.value.collection_config != null ? [feature_definition.value.collection_config] : []
        content {
          dynamic "vector_config" {
            for_each = collection_config.value.vector_config != null ? [collection_config.value.vector_config] : []
            content {
              dimension = vector_config.value.dimension
            }
          }
        }
      }
      collection_type = feature_definition.value.collection_type
      feature_name    = feature_definition.value.feature_name
      feature_type    = feature_definition.value.feature_type
    }
  }

  dynamic "offline_store_config" {
    for_each = each.value.offline_store_config != null ? [each.value.offline_store_config] : []
    content {
      dynamic "data_catalog_config" {
        for_each = offline_store_config.value.data_catalog_config != null ? [offline_store_config.value.data_catalog_config] : []
        content {
          catalog    = data_catalog_config.value.catalog
          database   = data_catalog_config.value.database
          table_name = data_catalog_config.value.table_name
        }
      }
      disable_glue_table_creation = offline_store_config.value.disable_glue_table_creation
      s3_storage_config {
        kms_key_id             = offline_store_config.value.s3_storage_config.kms_key_id
        resolved_output_s3_uri = offline_store_config.value.s3_storage_config.resolved_output_s3_uri
        s3_uri                 = offline_store_config.value.s3_storage_config.s3_uri
      }
      table_format = offline_store_config.value.table_format
    }
  }

  dynamic "online_store_config" {
    for_each = each.value.online_store_config != null ? [each.value.online_store_config] : []
    content {
      enable_online_store = online_store_config.value.enable_online_store
      dynamic "security_config" {
        for_each = online_store_config.value.security_config != null ? [online_store_config.value.security_config] : []
        content {
          kms_key_id = security_config.value.kms_key_id
        }
      }
      storage_type = online_store_config.value.storage_type
      dynamic "ttl_duration" {
        for_each = online_store_config.value.ttl_duration != null ? [online_store_config.value.ttl_duration] : []
        content {
          unit  = ttl_duration.value.unit
          value = ttl_duration.value.value
        }
      }
    }
  }

  dynamic "throughput_config" {
    for_each = each.value.throughput_config != null ? [each.value.throughput_config] : []
    content {
      provisioned_read_capacity_units  = throughput_config.value.provisioned_read_capacity_units
      provisioned_write_capacity_units = throughput_config.value.provisioned_write_capacity_units
      throughput_mode                  = throughput_config.value.throughput_mode
    }
  }
}

