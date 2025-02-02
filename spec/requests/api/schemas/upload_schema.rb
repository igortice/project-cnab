# spec/support/schemas/api/upload_schema.rb
module UploadSchema
  def self.schema
    {
      type: :object,
      properties: {
        message: { type: :string, example: "Arquivo processado com sucesso" },
        processed: {
          type: :object,
          properties: {
            message: { type: :string, example: "✅ Processamento concluído com sucesso!" },
            transactions_saved: { type: :integer, example: 21 }
          }
        }
      },
      required: [ "message", "processed" ]
    }
  end
end
