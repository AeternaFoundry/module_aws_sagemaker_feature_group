output "sagemaker_feature_groups_id" {
  description = "Map of id values across all sagemaker_feature_groups, keyed the same as var.sagemaker_feature_groups"
  value       = { for k, v in aws_sagemaker_feature_group.sagemaker_feature_groups : k => v.id if v.id != null && length(v.id) > 0 }
}
output "sagemaker_feature_groups_arn" {
  description = "Map of arn values across all sagemaker_feature_groups, keyed the same as var.sagemaker_feature_groups"
  value       = { for k, v in aws_sagemaker_feature_group.sagemaker_feature_groups : k => v.arn if v.arn != null && length(v.arn) > 0 }
}
output "sagemaker_feature_groups_description" {
  description = "Map of description values across all sagemaker_feature_groups, keyed the same as var.sagemaker_feature_groups"
  value       = { for k, v in aws_sagemaker_feature_group.sagemaker_feature_groups : k => v.description if v.description != null && length(v.description) > 0 }
}
output "sagemaker_feature_groups_event_time_feature_name" {
  description = "Map of event_time_feature_name values across all sagemaker_feature_groups, keyed the same as var.sagemaker_feature_groups"
  value       = { for k, v in aws_sagemaker_feature_group.sagemaker_feature_groups : k => v.event_time_feature_name if v.event_time_feature_name != null && length(v.event_time_feature_name) > 0 }
}
output "sagemaker_feature_groups_feature_definition" {
  description = "Map of feature_definition values across all sagemaker_feature_groups, keyed the same as var.sagemaker_feature_groups"
  value       = { for k, v in aws_sagemaker_feature_group.sagemaker_feature_groups : k => v.feature_definition if v.feature_definition != null && length(v.feature_definition) > 0 }
}
output "sagemaker_feature_groups_feature_group_name" {
  description = "Map of feature_group_name values across all sagemaker_feature_groups, keyed the same as var.sagemaker_feature_groups"
  value       = { for k, v in aws_sagemaker_feature_group.sagemaker_feature_groups : k => v.feature_group_name if v.feature_group_name != null && length(v.feature_group_name) > 0 }
}
output "sagemaker_feature_groups_offline_store_config" {
  description = "Map of offline_store_config values across all sagemaker_feature_groups, keyed the same as var.sagemaker_feature_groups"
  value       = { for k, v in aws_sagemaker_feature_group.sagemaker_feature_groups : k => one(v.offline_store_config) if v.offline_store_config != null && length(v.offline_store_config) > 0 }
}
output "sagemaker_feature_groups_online_store_config" {
  description = "Map of online_store_config values across all sagemaker_feature_groups, keyed the same as var.sagemaker_feature_groups"
  value       = { for k, v in aws_sagemaker_feature_group.sagemaker_feature_groups : k => one(v.online_store_config) if v.online_store_config != null && length(v.online_store_config) > 0 }
}
output "sagemaker_feature_groups_record_identifier_feature_name" {
  description = "Map of record_identifier_feature_name values across all sagemaker_feature_groups, keyed the same as var.sagemaker_feature_groups"
  value       = { for k, v in aws_sagemaker_feature_group.sagemaker_feature_groups : k => v.record_identifier_feature_name if v.record_identifier_feature_name != null && length(v.record_identifier_feature_name) > 0 }
}
output "sagemaker_feature_groups_region" {
  description = "Map of region values across all sagemaker_feature_groups, keyed the same as var.sagemaker_feature_groups"
  value       = { for k, v in aws_sagemaker_feature_group.sagemaker_feature_groups : k => v.region if v.region != null && length(v.region) > 0 }
}
output "sagemaker_feature_groups_role_arn" {
  description = "Map of role_arn values across all sagemaker_feature_groups, keyed the same as var.sagemaker_feature_groups"
  value       = { for k, v in aws_sagemaker_feature_group.sagemaker_feature_groups : k => v.role_arn if v.role_arn != null && length(v.role_arn) > 0 }
}
output "sagemaker_feature_groups_tags" {
  description = "Map of tags values across all sagemaker_feature_groups, keyed the same as var.sagemaker_feature_groups"
  value       = { for k, v in aws_sagemaker_feature_group.sagemaker_feature_groups : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "sagemaker_feature_groups_tags_all" {
  description = "Map of tags_all values across all sagemaker_feature_groups, keyed the same as var.sagemaker_feature_groups"
  value       = { for k, v in aws_sagemaker_feature_group.sagemaker_feature_groups : k => v.tags_all if v.tags_all != null && length(v.tags_all) > 0 }
}
output "sagemaker_feature_groups_throughput_config" {
  description = "Map of throughput_config values across all sagemaker_feature_groups, keyed the same as var.sagemaker_feature_groups"
  value       = { for k, v in aws_sagemaker_feature_group.sagemaker_feature_groups : k => one(v.throughput_config) if v.throughput_config != null && length(v.throughput_config) > 0 }
}

