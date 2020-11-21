require 'jekyll'
require 'fastimage'
require 'jekyll-emd-generator/version'

module EnhanceMetaData
  class Generator < Jekyll::Generator
    
    def generate(site)

      site.pages.each do |page|
        #if File.fnmatch( "index.{html,md}", page.path, File::FNM_EXTGLOB )
        #  ["elements"].each do |method|
        #    Generator.method(method).call page
        #  end
        #end
        #if File.fnmatch( "**/index.{html,md}", page.path, File::FNM_EXTGLOB )
        if File.fnmatch( "**index.{html,md}", page.path, File::FNM_EXTGLOB )
          ["product", "elements"].each do |method|
            Generator.method(method).call page
          end
        end
      end
    end

    def self.product(doc)

      dir = File.dirname(doc.path)
      file = dir + "/product.json"
      if File.exist?(file)

        doc.data['product'] = SafeYAML.load_file(file)
        #
        Jekyll.logger.info "", file
        #
        # jekyll-seo-plugin @title
        # Der Product.name wird zu @title falls nicht im 
        # Frontmatter überschrieben
        if doc.data['title'].nil?
          doc.data['title'] = doc.data['product']['name']
        end
        # jekyll-seo-plugin @description
        # Product.description wird zu @description falls nicht
        # im Frontmatter überschrieben
        if doc.data['description'].nil?
          doc.data['description'] = doc.data['product']['description']
        end
        # jekyll-seo-plugin @image
        # Product.image wird zu @image falls nicht im
        # Frontmatter überschrieben
        if doc.data['image'].nil?
          image = "#{dir}/#{doc.data['product']['image']}"
          if File.exist?(image)
            dimensions = FastImage.size(image)
            doc.data['image'] = {}
            doc.data['image']['path'] = '/' + image
            doc.data['image']['width'] = dimensions[0]
            doc.data['image']['height'] = dimensions[1]
          else
            Jekyll.logger.warn "Missing:", image
          end
        end
      end
    end

    def self.elements(doc)

      dir = File.dirname(doc.path)
      file = dir + "/elements.json"
      if File.exist?(file)
        #
        Jekyll.logger.info "", file
        #
        doc.data['elements'] = SafeYAML.load_file(file)
      end
    end
  end
end