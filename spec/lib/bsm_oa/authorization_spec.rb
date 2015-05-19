require 'spec_helper'

RSpec.describe BsmOa::Authorization, type: :model do

  it { is_expected.to belong_to(:role) }
  it { is_expected.to belong_to(:application) }

  it { is_expected.to validate_presence_of :role }
  it { is_expected.to validate_presence_of :role_id }
  it { is_expected.to validate_presence_of :application }
  it { is_expected.to validate_presence_of :application_id }

  describe 'uniqueness validation' do
    subject { build(:authorization) }
    it { is_expected.to validate_uniqueness_of(:application_id).scoped_to(:role_id) }
  end

  it { is_expected.to serialize(:permissions) }

  it 'should set and return string of permissions' do
    subject = create(:authorization)
    subject.permissions_string = 'admin operations finance'
    expect(subject.permissions).to eq ['admin', 'operations', 'finance']
    expect(subject.permissions_string).to eq 'admin finance operations'
  end

  it 'should normalize permissions' do
    subject = create(:authorization)
    subject.permissions = ["admin ", "Finance", "operatiOns", "unknown"]
    expect(subject).to be_valid
    expect(subject.permissions).to eq ['admin', 'finance', 'operations']
  end

  it 'should have ordered scope' do
    create(:authorization)
    expect(described_class.ordered.size).to eq(1)
  end

  describe 'toggle' do
    let(:authorization) { create :authorization}

    it 'should toggle adding permissions' do
      authorization.toggle('finance')
      expect(authorization.reload.permissions).to eq(['admin', 'finance'])
    end
    it 'should toggle removing permissions' do
      authorization.toggle('admin')
      expect(authorization.reload.permissions).to eq([])
    end
  end
end


