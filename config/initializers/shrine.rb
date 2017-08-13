require "shrine"
require "shrine/storage/file_system"
require "shrine/storage/s3"

if Rails.env.test?
	Shrine.storages = {
		cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
		store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store"), # permanent
	}
else
	s3_options = {
		access_key_id:     "abc",
		secret_access_key: "123",
		region:            "my-region",
		bucket:            "my-bucket",
	}

	Shrine.storages = {
		cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options),
		store: Shrine::Storage::S3.new(prefix: "store", **s3_options),
	}
end

Shrine.plugin :activerecord # or :activerecord
Shrine.plugin :cached_attachment_data # for forms
Shrine.plugin :direct_upload
Shrine.plugin :determine_mime_type
