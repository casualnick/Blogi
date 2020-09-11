require 'rails_helper'

RSpec.describe Post, type: :model do
  

  it { should belong_to :user }
  it { should validate_presence_of :title }
  it { should validate_presence_of :content }
  it { should validate_length_of :content }
  it { should validate_length_of :title }
end
