require 'shrine'

require 'jobs/promote_job'
require 'jobs/delete_job'

# First approach using file system
require 'shrine/storage/file_system'

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new('tmp', prefix: 'uploads/cache'),
  store: Shrine::Storage::FileSystem.new('tmp', prefix: 'uploads'),
}

Shrine.plugin :activerecord
Shrine.plugin :backgrounding
Shrine.plugin :logging
Shrine.plugin :determine_mime_type
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data

Shrine.plugin :upload_endpoint # only for file system

Shrine::Attacher.promote { |data| PromoteJob.perform_async(data) }
Shrine::Attacher.delete { |data| DeleteJob.perform_async(data) }
