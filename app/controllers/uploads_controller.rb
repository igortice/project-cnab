class UploadsController < ApplicationController
  def new
  end

  def create
    file = upload_params[:file]

    if file.present?
      result = CnabProcessor.process(file.path)

      if result.success?
        flash[:notice] = "Arquivo processado com sucesso!"

        return redirect_to transactions_path
      else
        flash[:alert] = "Erro ao processar o arquivo: #{result.failure[:message]}"
      end
    else
      flash[:alert] = "Nenhum arquivo foi enviado."
    end

    redirect_to new_upload_path
  end

  private

  def upload_params
    params.permit(:file)
  end
end
