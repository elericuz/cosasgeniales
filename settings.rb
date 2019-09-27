module ToPostit
  module Entities
    class Mongoid < Grape::Entity
      format_with(:mongo_id) { |id| id.to_s }
      with_options(format_with: :mongo_id) do
        expose :_id, as: :id
      end
      expose :created_at, :updated_at
    end
  end
end