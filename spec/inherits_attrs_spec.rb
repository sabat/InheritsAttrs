require 'spec_helper'
require 'inherits_attrs'

describe InheritsAttrs do
  it "should have a VERSION constant" do
    subject.const_get('VERSION').should_not be_empty
  end
end
