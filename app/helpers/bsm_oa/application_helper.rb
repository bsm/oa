module BsmOa
  module ApplicationHelper

    def paginate_json(json, collection, &block)
      return unless collection
      json.(collection, :current_page, :total_count, :total_pages)
      json.collection(collection){ |record| block.call(json, record) }
    end

    def auth_element_id(auth, permission)
      ["authorization", auth.to_param, permission].join('-')
    end

  end
end
