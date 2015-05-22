require 'spec_helper'

describe Doorkeeper::Application, type: :model do

  it { is_expected.to have_many(:authorizations).dependent(:destroy) }
  it { is_expected.to have_many(:roles).through(:authorizations) }

  it { is_expected.to serialize(:permissions) }

  ['valid', 'VALID', 'v4lid'].each do |val|
    it { is_expected.to allow_value([val]).for(:permissions) }
  end

  ['inv&lid', 'not valid'].each do |val|
    it { is_expected.not_to allow_value([val]).for(:permissions) }
  end

  it 'should have default secret and uid attributes' do
    app = create(:application, secret: nil, uid: nil)
    expect(app.secret).to_not be_nil
    expect(app.uid).to_not be_nil
  end

  it 'should all secret and uid to be user set' do
    app = create(:application, secret: 'secr3t', uid: 'nexusU1D')
    expect(app.secret).to eq('secr3t')
    expect(app.uid).to eq('nexusU1D')
  end

  it 'should normalize permissions' do
    app = create(:application, permissions: ['admin', 'Finance', ' employee ', ''])
    expect(app.permissions).to eq ['admin', 'finance', 'employee']
  end

  it 'should set and return string of permissions' do
    app = create(:application)
    app.permissions_string = 'admin, finance, employee'
    expect(app.permissions).to eq ['admin', 'finance', 'employee']
    expect(app.permissions_string).to eq 'admin employee finance'
  end

  it 'should scope ordered' do
    create(:application)
    expect(described_class.ordered.size).to eq(1)
  end

end

