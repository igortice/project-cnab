require "dry/monads"

class CnabProcessor
  extend Dry::Monads::Result::Mixin

  def self.process(file_path)
    return Failure("🚨 Arquivo não encontrado") unless File.exist?(file_path)
    return Failure("⚠️ Arquivo vazio") if File.zero?(file_path)

    errors        = []
    success_count = 0

    ActiveRecord::Base.transaction do
      File.open(file_path).each_line do |line|
        result = TransactionImporter.import_line(line.strip)

        if result.success?
          success_count += 1
        else
          errors << result.failure
        end
      end

      # Se todas as transações falharem, rollback automático
      raise ActiveRecord::Rollback if success_count.zero?
    end

    if errors.empty?
      Success({
                message: "✅ Processamento concluído com sucesso!",
                transactions_saved: success_count
              })
    else
      Failure({
                message: "⚠️ Processamento concluído com erros.",
                transactions_saved: success_count,
                errors: errors.uniq
              })
    end
  rescue StandardError => e
    Failure({ message: "❌ Erro inesperado", error: e.message })
  end
end
