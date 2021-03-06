require "spec_helper"
load "lib/sass_updater/processor.rb"

RSpec.describe Processor do

  test_case = [
    ["#some_element",                         "#some_element"],
    ["  :width 80px",                         "  width: 80px"],
    ["  :height 80px",                        "  height: 80px"],
    ["  :background",                         "  background:"],
    ["    :color red",                        "    color: red"],
    ["    :image image-url('some_pic.png')",  "    image: image-url('some_pic.png')"],
    ["  +transparent(60)",                    "  +transparent(60)"],
    ["  @extend .some_class",                 "  @extend .some_class"],
    ["  +gradient($high, $low)",              "  +gradient($high, $low)"],
    ["  //:dont change comments",             "  //:dont change comments"]
  ]

  it 'should be initialized with a string or array of strings and contain the input as an array' do 
    Processor.new("I am foo").data.should == ["I am foo"]
    Processor.new(["I am foo", "I am also foo"]).data.should == ["I am foo", "I am also foo"]
    Processor.new("foo", "bar", "lar").data.should == ["foo", "bar", "lar"]
  end

  describe "update_sass" do 
    before :each do 
      @p = Processor.new
      @p.data = [":display none", ":foo bar", "//can't touch this"]
    end

    it 'should process each element and alter as appropriate and store updated values in @updated' do 
      @p.updated.should == nil
      @p.update_sass
      @p.updated.should == ["display: none", "foo: bar", "//can't touch this"]
    end

    describe "test cases" do 
      it 'should convert the test case into expected values' do 
        p = Processor.new(test_case.map{|d| d[0]})
        p.update_sass
        p.updated.should == test_case.map{|d| d[1]}
      end

      it 'should preserve new lines with sub clauses' do 
        p = Processor.new(["  p\n", "    :margin\n", "      :top 1em\n", "      :bottom 2em\n", "\n"])
        p.update_sass
        p.updated.should == ["  p\n", "    margin:\n", "      top: 1em\n", "      bottom: 2em\n", "\n"]
      end

      it 'should preserve new lines with sub clauses when there are trailing whitespaces' do 
        p = Processor.new([":margin \n", "  :bottom 6px\n", "  :left 10%\n"] )
        p.update_sass
        p.updated.should == ["margin:\n", "  bottom: 6px\n", "  left: 10%\n"] 
      end

      it 'should not add a new line' do 
        @p.update_line("    :repeat no-repeat\n").should == "    repeat: no-repeat\n"
      end

    end


    describe "update_line" do 
      it 'should preserve leading white space' do 
        @p.update_line("    :position absolute").should == "    position: absolute"
      end

      it 'should ignore any other instances of : in the line' do 
        @p.update_line(":this isn't real :sass but just incase").should == "this: isn't real :sass but just incase"
      end

      it 'should not alter lines like &:hover' do 
        @p.update_line("&:hover").should == "&:hover"
      end

      describe "test case" do 

        test_case.each do |example, result|
          it "should convert #{example} into #{result}" do 
            @p.update_line(example).should == result
          end

        end

      end
    end

  end

  describe "needs_updating?" do 
    before :each do 
      @p = Processor.new      
    end

    it 'should return true if there are lines which have : as the first char' do 
      @p.data = test_case.map{|d| d[0]}
      @p.should be_needs_updating      
    end

    it 'should return false if there are no lines which have : as the first char' do 
      @p.data = test_case.map{|d| d[1]}
      @p.should_not be_needs_updating
    end

  end

end 

