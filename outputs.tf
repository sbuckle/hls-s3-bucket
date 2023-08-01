output "bucket_name" {
  value = aws_s3_bucket.hls.id
}

output "bucket_domain" {
  value = aws_s3_bucket.hls.bucket_regional_domain_name
}
