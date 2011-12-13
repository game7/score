# encoding: utf-8

module Score
  class LogoUploader < CarrierWave::Uploader::Base

    # Include RMagick or MiniMagick support:
    include CarrierWave::RMagick
    # include CarrierWave::MiniMagick

    # Choose what kind of storage to use for this uploader:
    storage :file
    # storage :fog

    # Override the directory where uploaded files will be stored.
    # This is a sensible default for uploaders that are meant to be mounted:
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    # Provide a default URL as a default if there hasn't been a file uploaded:
    # def default_url
    #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
    # end

    def cache_dir
      "#{Rails.root}/tmp/uploads"
    end

    process :resize_to_limit => [400,400]

    version :small do
      process :crop_and_scale => 200
    end

    version :thumb do
      process :crop_and_scale => 100
    end

    version :tiny do
      process :crop_and_scale => 50
    end

    version :micro do
      process :crop_and_scale => 25
    end

    # Add a white list of extensions which are allowed to be uploaded.
    # For images you might use something like this:
    def extension_white_list
      %w(jpg jpeg gif png)
    end

    # Override the filename of the uploaded files:
    # Avoid using model.id or version_name here, see uploader/store.rb for details.
    # def filename
    #   "something.jpg" if original_filename
    # end
    
    def crop_and_scale(resize_to = nil)
      if model.cropping?
        manipulate! do |img|
          img = img.crop(model.crop_x.to_i, model.crop_y.to_i, model.crop_h.to_i, model.crop_w.to_i, true)
          img = img.resize(resize_to, resize_to) if resize_to
        end
      else
        resize_to_limit(resize_to, resize_to)
      end
    end    

  end
end