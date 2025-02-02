require "swagger_helper"

RSpec.describe "Uploads API", type: :request do
  path "/api/uploads" do
    post "Faz upload e processa um arquivo CNAB" do
      tags "Uploads"
      consumes "multipart/form-data"

      parameter name: :file, in: :formData, schema: {
        type: :string,
        format: :binary
      }, required: true, description: "Arquivo CNAB para ser processado"

      response "200", "Arquivo processado com sucesso" do
        let(:file) { fixture_file_upload(Rails.root.join("spec/fixtures/files/sample_cnab.txt"), "text/plain") }

        run_test! do |response|
          json = JSON.parse(response.body)
          expect(json).to have_key("message")
          expect(json["message"]).to eq("Arquivo processado com sucesso")
          expect(json).to have_key("processed")
        end
      end

      response "422", "Erro no processamento do arquivo" do
        let(:file) { nil }

        run_test! do |response|
          json = JSON.parse(response.body)
          expect(json["error"]).to eq("Arquivo não enviado")
        end
      end
    end
  end
end
