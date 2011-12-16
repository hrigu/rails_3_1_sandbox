class MyClass
  def myMethod
    "hallo"
  end
  alias :alias_name :myMethod
end

require "rspec"

describe "stub the original method" do
  before :each do
    @myClass = MyClass.new
    @myClass.stub(:myMethod){"hi"}
  end

  it "returns the stubbed value" do
    @myClass.myMethod.should == "hi"
  end
  #why
  it "returns the original value" do
    @myClass.alias_name.should == "hallo"
  end
end

describe "stub the alias method" do
  before :each do
    @myClass = MyClass.new
    @myClass.stub(:alias_name){"hi"}
  end

  it "returns the original value" do
    @myClass.myMethod.should == "hallo"
  end
  it "returns the stubbed value" do
    @myClass.alias_name.should == "hi"
  end
end