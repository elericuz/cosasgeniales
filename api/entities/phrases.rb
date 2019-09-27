module ToPostit
  module Entities
    class Phrases < ToPostit::Entities::Mongoid
      expose :topic, :msg
    end
  end
end