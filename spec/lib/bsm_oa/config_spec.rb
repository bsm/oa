require 'spec_helper'

RSpec.describe BsmOa::Config do

  it "should have defaults" do
    expect(subject.user_class).to eq(::User)
    expect(subject.user_attrs).to eq([:id, :email])
  end

  it "should set custom user classes" do
    subject.user_class "String"
    expect(subject.user_class).to eq(::String)
  end

  it "should set custom user attributes" do
    subject.user_attrs :id, :name, :admin
    expect(subject.user_attrs).to eq([:id, :name, :admin])
  end

end
