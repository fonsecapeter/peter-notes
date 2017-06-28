require 'spec_helper'
require 'peter_notes/version'

RSpec.describe PeterNotes do
  it 'has a version number' do
    expect(PeterNotes::VERSION).not_to be nil
  end
end
