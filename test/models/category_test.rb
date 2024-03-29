require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(name:"sports")
  end

  test "category is valid" do 
    assert @category.valid?
  end

  test "category is not valid" do 
    @category.name = ""
    assert_not @category.valid?
  end

  test "category name should be unique" do 
    @category.save
    category2 = Category.new(name:"sports")
    assert_not category2.valid?
  end

  test "name should not be too long" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end

  test "name should not be too short" do
    @category.name = "a"
    assert_not @category.valid?
    @category.name = "aa"
    assert_not @category.valid?
    @category.name = "aaa"
    assert @category.valid?
  end
end