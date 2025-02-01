require "dry/monads"

class CnabProcessor
  extend Dry::Monads::Result::Mixin # Permite usar Success e Failure em métodos de classe

  def self.process(file_path)
    return Failure("Arquivo não encontrado") unless File.exist?(file_path)

    errors        = []
    success_count = 0

    File.foreach(file_path) do |line|
      result = TransactionImporter.import_line(line)

      if result.success?
        success_count += 1
      else
        errors << result.failure
      end
    end

    if errors.empty?
      Success("✅ Processamento concluído com sucesso! #{success_count} transações salvas.")
    else
      Failure("⚠️ Processamento concluído com erros. #{success_count} transações salvas, #{errors.count} falhas. Erros: #{errors.uniq.join('; ')}")
    end
  rescue StandardError => e
    Failure("❌ Erro inesperado: #{e.message}")
  end
end
