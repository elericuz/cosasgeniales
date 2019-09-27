module ToPostit
  module Resources
    class Phrases < Grape::API
      format :json

      resources :phrases do
        desc "get the phrases"
        params do
          optional :total, type: Integer, default: 80
        end
        get :get do
          ignored_words =  ["", "un", "una", "con", "y", "a", "la", "el", "te",
                            "mi", "buen", "en", "ir", "de", "que", "tu", "los",
                            "al", "ver", "las", "por", "del", "no", ",", "mis",
                            "!", "tus", "lo", "es", "sin", "ser", "vez", "se",
                            "para", "me", "mas", "venir", "hasta", "estar", "su",
                            "cada", "\"", "!!", "estas", "pero", "o", "hace",
                            "esta", "haber", "si", "sea", "muy", "le", "ti", "e",
                            "nada", "quieres", "lado", "haga", "decir", "este",
                            "quien", "desde", "darte", "tan", "tienes", "yo",
                            "mismo", "haciendo", "pesar", "aun", "vas", "ella",
                            "viendo", "bajo", "otro", "esa", "eres", "ese", "dos",
                            "sobre", "veces", "son", "misma", "donde", "meterte",
                            "junto", "puedes", "porque", "ya", "haya", ")",
                            "quiero", "3", "usar", "hagan", "entre", "tanto",
                            "nos", "otra", "uno", "sacar", "cuando", "tener",
                            "luego", "despues", "toda"]

          word_cloud = ToPostit::Phrase.collection.aggregate([
              {
                  :$addFields => {
                      words: {
                          :$map => {
                              input: { :$split => ["$msg", " "] },
                              as: "str",
                              in: { :$toLower => ["$$str"] }
                          }
                      }
                  }
              },
              {
                  :$unwind => "$words"
              },
              {
                  :$match => {
                      words: {
                          :$nin => ignored_words
                      }
                  }
              },
              {
                  :$group => {
                      _id: "$_id",
                      words: { :$addToSet => "$words" }
                  }
              },
              {
                  :$unwind => "$words"
              },
              {
                  :$sortByCount => "$words"
              },
              {
                  :$limit => params[:total]
              }
          ])

          present :word_cloud, word_cloud
          present :total, params[:total]
        end
      end
    end
  end
end