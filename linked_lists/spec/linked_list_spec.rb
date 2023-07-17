# frozen_string_literal: true

require "linked_list"

RSpec.describe LinkedList do
  let(:list) { LinkedList.new }

  describe "#append" do
    it "when the list is empty" do
      value = 1
      list.append(value)

      expect(list.head_sentinel.next_node.value).to eql(value)
      expect(list.tail_sentinel.prev_node.value).to eql(value)
    end

    it "when the list is not empty" do
      list.append(1)
      list.append(2)

      expect(list.head_sentinel.next_node.value).to eql(1)
      expect(list.tail_sentinel.prev_node.value).to eql(2)
    end
  end

  describe "#prepend" do
    it "when the list is empty" do
      value = 1
      list.prepend(value)

      expect(list.head_sentinel.next_node.value).to eql(value)
      expect(list.tail_sentinel.prev_node.value).to eql(value)
    end

    it "when the list is not empty" do
      list.append(1)
      list.append(3)
      list.prepend(2)

      expect(list.head_sentinel.next_node.value).to eql(2)
      expect(list.tail_sentinel.prev_node.value).to eql(3)
    end
  end

  describe "#size" do
    it "when the list is empty" do
      expect(list.size).to eql(0)
    end

    it "when the list contains one element" do
      list.append(1)

      expect(list.size).to eql(1)
    end

    it "when the list contains multiple elements" do
      size = 10
      size.times { |i| list.append(i) }

      expect(list.size).to eql(size)
    end
  end

  describe "#head" do
    it "when the list is empty" do
      expect(list.head).to be_nil
    end

    it "when the list contains one element" do
      list.append(1)

      expect(list.head.value).to eql(1)
    end

    it "when the list contains multiple elements" do
      list.append(1)
      list.append(2)

      expect(list.head.value).to eql(1)
    end
  end

  describe "#tail" do
    it "when the list is empty" do
      expect(list.tail).to be_nil
    end

    it "when the list contains one element" do
      list.append(1)

      expect(list.tail.value).to eql(1)
    end

    it "when the list contains multiple elements" do
      list.append(1)
      list.append(2)

      expect(list.tail.value).to eql(2)
    end
  end

  describe "#at" do
    before(:all) do
      @list = LinkedList.new
      @size = 10
      10.times { |i| @list.append(i + 1) }
    end

    it "first index" do
      index = 0
      expect(@list.at(index)).to eql(1)
    end

    it "last index" do
      index = @size - 1
      expect(@list.at(index)).to eql(10)
    end

    it "index between first and lasst" do
      index = 4
      expect(@list.at(index)).to eql(5)
    end

    it "negative index returns nil" do
      index = -1
      expect(@list.at(index)).to be_nil
    end

    it "positive out of bounds index returns nil" do
      index = 10
      expect(@list.at(index)).to be_nil
    end
  end

  describe "#pop" do
    context "when the list is empty" do
      it "returns nil" do
        expect(list.pop).to be_nil
      end

      it "size is zero" do
        list.pop
        expect(list.size).to eql(0)
      end
    end

    context "when the list is not empty" do
      before(:each) do
        list.append(1)
        list.append(2)
      end

      it "returns returns the last element" do
        expect(list.pop).to eql(2)
      end

      it "the size is reduced by one" do
        old_size = list.size
        list.pop

        expect(list.size).to eql(old_size - 1)
      end
    end
  end

  describe "#contains" do
    before(:each) do
      list.append(1)
      list.append(2)
    end

    it "when the value is present, returns true" do
      expect(list.contains?(1)).to be true
      expect(list.contains?(2)).to be true
    end

    it "when the value is absent, returns false" do
      expect(list.contains?(3)).to be false
      expect(list.contains?(4)).to be false
    end
  end

  describe "#find_index_of" do
    before(:each) do
      list.append(1)
      list.append(2)
    end

    it "when the value is present, returns its index" do
      expect(list.find_index_of(1)).to eql(0)
      expect(list.find_index_of(2)).to eql(1)
    end

    it "when the value is absent, returns nil" do
      expect(list.find_index_of(3)).to be_nil
      expect(list.find_index_of(4)).to be_nil
    end
  end

  describe "#insert_at" do
    describe "when index is in bounds" do
      before(:each) do
        10.times { |i| list.append(i + 1) }
      end

      it "inserts at the right position" do
        value = "a"
        index = 2
        list.insert_at("a", 2)

        expect(list.at(index)).to eql(value)
        expect(list.at(index - 1)).to eql(2)
        expect(list.at(index + 1)).to eql(3)
      end

      it "increases the size of the list by one" do
        list.insert_at("a", 2)

        expect(list.size).to eql(11)
      end
    end
  end

  describe "#remove_at" do
    before(:each) do
      10.times { |i| list.append(i + 1) }
    end

    describe "when index is in bounds" do
      it "inserts at the right position" do
        index = 2
        list.remove_at(2)

        expect(list.at(index)).to eql(4)
        expect(list.at(index - 1)).to eql(2)
        expect(list.at(index + 1)).to eql(5)
      end

      it "increases the size of the list by one" do
        list.remove_at(2)

        expect(list.size).to eql(9)
      end

      it "returns the removed object" do
        expect(list.remove_at(2)).to eql(3)
      end
    end

    describe "when index is negative" do
      it "doesn't change the size of the list" do
        list.remove_at(-1)

        expect(list.size).to eql(10)
      end

      it "returns nil" do
        expect(list.remove_at(-1)).to be_nil
      end
    end

    describe "when index is positive but out of bounds" do
      it "doesn't change the size of the list" do
        list.remove_at(10)

        expect(list.size).to eql(10)
      end

      it "returns nil" do
        expect(list.remove_at(10)).to be_nil
      end
    end
  end
end
