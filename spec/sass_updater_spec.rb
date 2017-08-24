require "spec_helper"

RSpec.describe SassUpdater do
  it "has a version number" do
    expect(SassUpdater::VERSION).not_to be nil
  end
end
