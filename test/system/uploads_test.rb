require "application_system_test_case"

class UploadsTest < ApplicationSystemTestCase
  test "deve exibir a tela de upload e permitir o envio do arquivo" do
    visit new_upload_path

    # Verifica se o título está presente
    assert_selector "h3", text: "Upload de Arquivo CNAB txt"

    # Verifica se o campo de input para upload de arquivo está presente
    assert_selector "input[type=file]", visible: :all

    # Verifica se o botão "Enviar Arquivo" está visível corretamente
    assert_selector "input[type=submit][value='Enviar Arquivo']"

    # Simula o upload de um arquivo CNAB
    attach_file("file", Rails.root.join("test/fixtures/files/valid_cnab.txt"))

    # Clica no botão de envio
    find("input[type=submit][value='Enviar Arquivo']").click

    # Aguarda o processamento e verifica a resposta esperada
    assert_text "Arquivo processado com sucesso"
  end
end
