# frozen_string_literal: true

class TimeFormatter
  AVAILABLE_FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  def initialize(string)
    @format = parse_format(string)
    @errors = []

    validate!
  end

  def valid?
    @errors.empty?
  end

  def errors
    @errors.join("\n")
  end

  def time
    Time.now.strftime(strftime_format)
  end

  private

  def parse_format(string)
    string.to_s.strip.split(',')
  end

  def validate!
    @errors << 'Missing time format' if @format.empty?

    unknown_time_format = @format - AVAILABLE_FORMATS.keys

    @errors << "Unknown time format: #{unknown_time_format.join(', ')}" if unknown_time_format.any?
  end

  def strftime_format
    @format.map { |f| AVAILABLE_FORMATS[f] }.join('-')
  end
end
