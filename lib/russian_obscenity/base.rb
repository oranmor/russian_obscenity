# encoding: UTF-8
require 'yaml'

module RussianObscenity extend self

  DEFAULT_DICTIONARY = File.dirname(__FILE__) + "/../../config/dictionary.yml"

  @dictionary_list = [:default]

  def obscene?(text)
    (text =~ regexp) ? true : false
  end

  def sanitize(text, replace = '*')
    text.gsub(regexp, replace)
  end

  def find(text)
    text.gsub(regexp).map {|word| word}.uniq
  end

  def dictionary
    @dictionary_list
  end

  def dictionary=(list)
    list = [:default] if list.nil? or list.empty?
    @dictionary_list = list.uniq.compact
    reload_regexp
  end

  private

  def regexp
    reload_regexp if @regexp.nil?
    @regexp
  end

  def reload_regexp
    @regexp = make_regexp(@dictionary_list)
  end

  def make_regexp(dict_list)
    words = []
    dict_list.each do |dict|
      dict = DEFAULT_DICTIONARY if dict == :default
      words << YAML.load_file(dict)
    end
    Regexp.new prepare_regexp_str(words), Regexp::IGNORECASE
  end

  def prepare_regexp_str(words)
    reg = words.join('|')
    reg.gsub!(/\\W/, '[^a-zA-Z0-9а-яА-ЯёЁ_]') # because \W in ruby support only ASCII symbols
    reg.gsub!(/\\w/, '[a-zA-Z0-9а-яА-ЯёЁ]')   # because \w in ruby support only ASCII symbols
    '(\b|(?<=_))(' + reg + ')(\b|(?<=_))'
  end

end