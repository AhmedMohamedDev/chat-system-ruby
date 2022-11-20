class Message < ApplicationRecord
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    document_type 'doc'

    belongs_to :chat ,optional: true#,counter_cache: true

      settings index: { number_of_shards: 1,
      analysis: {
        normalizer: {
          keyword_icase: {
            type: 'custom',
            filter: %w[lowercase asciifolding]
          }
        }
      } } do
            mappings dynamic: 'false' do
              indexes :message, type: 'keyword'
              indexes :message_number, type: 'keyword'
            end
          end


        #   def as_json(options = {})
        #   {
        #       application_token: self.chat.application_token,
        #       message_chat_number: self.chat.chat_number,
        #       message_number: message_number,
        #       message: message,
        #   }
        # end
      
        # def as_indexed_json(options = {})
        #   {
      
        #       message: message
        #   }
        # end
end

#end

Message.__elasticsearch__.create_index!

Message.import
