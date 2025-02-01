class UploadsController < ApplicationController
  def new
  end

  def create
    if params[:file].present?
      file   = params[:file]
      result = CnabProcessor.process(file.path)

      if result.success?
        flash[:notice] = "Arquivo processado com sucesso!"
      else
        flash[:alert] = "Erro ao processar o arquivo: #{result.failure[:message]}"
      end
    else
      flash[:alert] = "Nenhum arquivo foi enviado."
    end

    redirect_to new_upload_path
  end
end
