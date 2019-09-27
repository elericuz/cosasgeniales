# encoding: UTF-8
module ToPostit
  class Phrase
    include Mongoid::Document
    include Mongoid::Timestamps

    store_in collection: "phrases"

    field :topic, type: String
    field :msg, type: String
  end
end