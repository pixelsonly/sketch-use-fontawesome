#!/usr/bin/env ruby

require 'json'
require 'yaml'

SEMVER = ARGV[0] || '4.5.0'

ICON_CONFIG = "https://raw.githubusercontent.com/FortAwesome/Font-Awesome/v#{SEMVER}/src/icons.yml"

RESOURCES_PATH = File.expand_path("../../fontawesome.sketchplugin/Contents/Resources/", __FILE__)

def init
  %x( curl -o "#{RESOURCES_PATH}/icons.yml" "#{ICON_CONFIG}")
  convert_yaml_to_json
end

def convert_yaml_to_json
  input_filename = "#{RESOURCES_PATH}/icons.yml"

  if File.exists?(input_filename)
    output_filename = input_filename.sub(/(yml|yaml)$/, 'json')
    input_file      = File.open(input_filename, 'r')
    input_yml       = input_file.read

    input_file.close

    output_json     = JSON.pretty_generate(YAML::load(input_yml))
    output_file     = File.open(output_filename, 'w+')

    output_file.write(output_json)
    output_file.close
  end
end

init
