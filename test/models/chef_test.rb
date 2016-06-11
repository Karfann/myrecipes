require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "jonh", email: "jonh@example.com")
  end
  
  test "chef should be valid" do
    assert @chef.valid?
  end
  
  test "chefname should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end
  
  test "chefname should not be too long" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end
  
  test "chefname should not be too short" do
    @chef.chefname = "aa"
    assert_not @chef.valid?
  end
  
  test "email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end
  
  test "email length should be within bounds" do
    @chef.email = "a" * 101 + "@example.com"
    assert_not @chef.valid?
  end
  
  test "email address should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test "email validation should accept valid address" do
      valid_addresses = %w[user@eee.com R_TDD-DS@hello.org user@example.com first.last@eem.au laura+joe@monk.com]
      valid_addresses.each do |v|
        @chef.email = v
        assert @chef.valid?, "#{v.inspect} should be valid"
      end
  end
  
  test "email validation should reject invalid addresss" do
      invalid_addresses = %w[user@example,com user_at_eee.org user.name@example.]
      invalid_addresses.each do |i|
        @chef.email = i
        assert_not @chef.valid?, "#{i.inspect} should be invalid"
      end
  end
end
  