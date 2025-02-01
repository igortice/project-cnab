require "application_system_test_case"

class HomesTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit root_url

    # Verifica se a página tem o título esperado
    assert_selector "h1", text: "Desáfio CNAB"

    # Verifica se o botão está oculto inicialmente
    assert_selector "button", text: "Ir para tela de upload", visible: :hidden

    # Aguarda 3 segundos para o botão aparecer
    sleep 1

    # Agora o botão deve estar visível
    assert_selector "button", text: "Ir para tela de upload", visible: :true
  end
end
