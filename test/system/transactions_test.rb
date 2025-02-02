require "application_system_test_case"

class AccordionTest < ApplicationSystemTestCase
  test "deve expandir e mostrar a seção Financeiro" do
    visit transactions_url

    # Verifica se o botão está visível
    assert_selector "button.accordion-button", text: "Financeiro"

    # Clica no botão para expandir a seção
    find("button.accordion-button", text: "Financeiro").click

    # Aguarda a animação do Bootstrap e verifica se o conteúdo foi expandido
    assert_selector "#target-1", visible: true

    # Verifica se o botão está visível
    assert_selector "button.accordion-button", text: "Dados"

    # Clica no botão para expandir a seção
    find("button.accordion-button", text: "Dados").click

    # Aguarda a animação do Bootstrap e verifica se o conteúdo foi expandido
    assert_selector "#target-2", visible: true
  end
end
