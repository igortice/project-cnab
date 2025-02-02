class Api::UploadsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :create ]

  def create
    file = upload_params[:file]
    if file.present?
      result = CnabProcessor.process(file.tempfile.path)

      if result.success?
        render json: { message: "Arquivo processado com sucesso", processed: result.value! }, status: :ok
      else
        render json: { error: result.failure }, status: :unprocessable_entity
      end
    else
      render json: { error: "Arquivo não enviado" }, status: :unprocessable_entity
    end
  end

  private

  def upload_params
    params.permit(:file)
  end
end
