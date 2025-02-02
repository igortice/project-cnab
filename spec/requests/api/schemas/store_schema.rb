module StoreSchema
  def self.schema
    {
      type:       :object,
      properties: {
        id:         { type: :string },
        type:       { type: :string },
        attributes: {
          type:       :object,
          properties: {
            name:  { type: :string },
            owner: { type: :string }
          }
        }
      }
    }
  end
end
