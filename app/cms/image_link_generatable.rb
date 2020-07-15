module ImageLinkGeneratable
    
    def last_image_url
        domain_name = ENV['DOMAIN_NAME'] || "localhost:3000"
            
        return domain_name + rails_blob_path(last_image, disposition: "attachment", only_path: true) if last_image
        
        nil
    end

    def url_from_blob(filename)
        blob = ActiveStorage::Blob.find_by_filename(filename)
        
        return domain_name + rails_blob_path(blob, disposition: "attachment", only_path: true) if blob

        filename
    end
    
    private

        def last_image
            self.images.last
        end

        def domain_name
            ENV['DOMAIN_NAME'] || "localhost:3000"
        end
end