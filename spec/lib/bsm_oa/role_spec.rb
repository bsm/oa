require 'spec_helper'

RSpec.describe BsmOa::Role, type: :model do

  it { is_expected.to have_many(:authorizations).dependent(:destroy) }
  it { is_expected.to have_many(:applications).through(:authorizations) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(80) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

  it 'should have ordered scope' do
    create(:role)
    expect(described_class.ordered.length).to eq(1)
  end

  it 'should normalize name attribute' do
    subject = create(:role, name: ' Something ')
    expect(subject.name).to eq('Something')
  end

end

