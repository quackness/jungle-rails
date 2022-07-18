require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do
    before do
      @category = Category.new(:name => "test")
      @product = Product.new(:name => "Chair", :price_cents => 500, :quantity => 1, :category => @category )
      @product.save
      pp @product
    end

    it "should have name" do
      expect(@product.name).to eq("Chair")
      expect(@product.name).to_not eq(nil)
      expect(@product.name).to_not eq("")
    end
    it "should have price" do
      expect(@product.price).to_not eq(nil)
      expect(@product.price_cents).to eq(500)
    end
    it "should have quantity" do
      expect(@product.quantity).to_not eq(nil)
      expect(@product.quantity).to eq(1)
    end
    it "should have category" do
      expect(@product.category).to_not eq(nil)
    end

    it "should throw an error when product does not have a category" do
      new_product = Product.new(:name => "Sofa", :price_cents => 500, :quantity => 1 )
      expect(new_product.errors.full_messages).to_not eq(nil)
    end

    it "should throw an error when name of the product does not exist" do
      new_product = Product.new(:price_cents => 800, :quantity => 1, :category => @category )
      expect(new_product.errors.full_messages).to_not eq(nil)
    end

    it "should throw an error when name of the price does not exist" do
      no_price = Product.new(:name => "Sofa", :quantity => 1, :category => @category )
      expect(no_price.errors.full_messages).to_not eq(nil)
    end

    it "should throw an error when quantity does not exist" do
      no_quantity = Product.new(:name => "Sofa", :price_cents => 800, :category => @category )
      expect(no_quantity.errors.full_messages).to_not eq(nil)
    end
  end  
end


