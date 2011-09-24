require "rspec"

describe "Using should: " do

  describe "when my true object:" do

    before do
      @true = true
      puts @true.class
    end

    it "should be true" do
      @true.should be true
    end

    it "should be an instance of TrueClass" do
      @true.should be_an_instance_of TrueClass
    end



  end

end