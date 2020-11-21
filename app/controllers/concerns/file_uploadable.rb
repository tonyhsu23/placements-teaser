module FileUploadable
  extend ActiveSupport::Concern

  BUCKET_NAME = 'placements'

  def s3_resource
    Aws::S3::Resource.new(region: 'ap-northeast-1')
  end

  def object_uploaded?(object_key, body)
    object = s3_resource.bucket(BUCKET_NAME).object(object_key)
    object.put(body: body)
    true
  rescue StandardError => e
    puts "Error uploading object: #{e.message}"
    false
  end
end
