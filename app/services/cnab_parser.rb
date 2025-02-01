require "dry/monads"

class CnabParser
  extend Dry::Monads::Result::Mixin

  def self.parse_line(line)
    data = {
      transaction_type: line[0].to_i,
      date:             format_date(line[1..8]),
      value:            line[9..18].to_i,
      cpf:              line[19..29].strip,
      card:             line[30..41].strip,
      hour:             format_time(line[42..47]),
      store_owner:      line[48..61].strip,
      store_name:       line[62..].strip
    }

    Success(data)
  rescue StandardError => e
    Failure(e.message)
  end

  private

  def self.format_date(date_str)
    Date.strptime(date_str, "%Y%m%d")
  rescue ArgumentError
    nil
  end

  def self.format_time(time_str)
    "#{time_str[0..1]}:#{time_str[2..3]}:#{time_str[4..5]}"
  end
end
