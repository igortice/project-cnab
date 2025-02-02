module TransactionSchema
  def self.schema
    {
      type:       :object,
      properties: {
        data:     TransactionSchema.transaction_data_schema,
        included: {
          type:  :array,
          items: StoreSchema.schema
        }
      }
    }
  end

  def self.transaction_data_schema
    {
      type:       :object,
      properties: {
        id:            { type: :string },
        type:          { type: :string },
        attributes:    {
          type:       :object,
          properties: {
            date:             { type: :string, format: :date },
            transaction_type: { type: :string },
            value:            { type: :integer },
            formatted_value:  { type: :string },
            cpf:              { type: :string },
            card:             { type: :string },
            hour:             { type: :string }
          }
        },
        relationships: {
          type:       :object,
          properties: {
            store: {
              type:       :object,
              properties: {
                data: {
                  type:       :object,
                  properties: {
                    id:   { type: :string },
                    type: { type: :string }
                  }
                }
              }
            }
          }
        }
      }
    }
  end
end
