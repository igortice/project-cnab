require "test_helper"

class UploadsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @valid_file   = fixture_file_upload("test/fixtures/files/valid_cnab.txt", "text/plain")
    @invalid_file = fixture_file_upload("test/fixtures/files/invalid_cnab.txt", "text/plain")
  end

  test "deve exibir a página de upload" do
    get new_upload_url
    assert_response :success
    assert_select "h1", "Upload de Arquivo CNAB"
  end

  test "deve processar um arquivo CNAB válido" do
    post uploads_path, params: { file: @valid_file }

    assert_redirected_to new_upload_path
    follow_redirect!
    assert_match "Arquivo processado com sucesso!", response.body
  end

  test "deve mostrar erro ao tentar enviar sem arquivo" do
    post uploads_path, params: { file: nil }

    assert_redirected_to new_upload_path
    follow_redirect!
    assert_match "Nenhum arquivo foi enviado.", response.body
  end
end
