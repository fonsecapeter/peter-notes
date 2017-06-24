require "spec_helper"

RSpec.describe Peter::Notes do
  it "has a version number" do
    expect(Peter::Notes::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
