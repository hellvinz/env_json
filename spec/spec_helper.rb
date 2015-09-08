# encoding: utf-8
require 'bundler'
Bundler.setup

require 'simplecov'
require 'simplecov-rcov'
SimpleCov.start do
  add_filter '/.bundle/'
  add_filter '/spec/'
end
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter

require 'minitest/autorun'
require 'env_json'
