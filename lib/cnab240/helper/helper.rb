module Cnab240
  class Helper
    include Cnab240::Filler

    attr_accessor :arquivo

    def string
      arquivo.string
    end

    def save_to_file(file)
      arquivo.save_to_file(file)
    end

    def self.paying(movement)
      bank_equal = movement['bank_account']['bank']['code'] == $kiik_compensation['bank_account']['code']
      document_equal = movement['customer']['document'] == $kiik_compensation['document']
      make_doc = movement['amount'].to_i < 5000000
      trans_of_banks = document_equal ? ( make_doc ? '07' : '43' ) : (make_doc ? '03' : '47')
      {
        arquivo_sequencia: '1',

        empresa_tipo: $kiik_compensation['document'].length > 12 ? '2' : '1',
        empresa_numero: $kiik_compensation['document'],
        empresa_nome: $kiik_compensation['name'],

        empresa_agencia_codigo: $kiik_compensation['bank_account']['branch'],
        empresa_agencia_conta_dv: $kiik_compensation['bank_account']['digit'],
        empresa_conta_numero: $kiik_compensation['bank_account']['number'],

        endereco_logradouro: $kiik_compensation['address']['street'],
        endereco_numero: $kiik_compensation['address']['number'],
        endereco_cidade: $kiik_compensation['address']['city'],
        endereco_cep: $kiik_compensation['address']['zip'],
        endereco_estado: $kiik_compensation['address']['state'],

        servico_tipo: '98',
        servico_forma: bank_equal ? '01' : trans_of_banks
      }
    end

    def self.favored(movement)
      {
        favorecido_banco: movement['bank_account']['bank']['code'],
        favorecido_agencia: movement['bank_account']['branch'],
        favorecido_agencia_conta_dv: movement['bank_account']['digit'],
        favorecido_conta: movement['bank_account']['number'],
        favorecido_nome: I18n.transliterate(movement['customer']['name']),
        numero_inscricao: movement['customer']['document'],
        credito_seu_numero: movement['id'].to_s,
        credito_data_pagamento: Time.now.strftime('%d%m%Y'),
        credito_valor_pagamento: movement['amount'].to_s
      }
    end
  end
end
