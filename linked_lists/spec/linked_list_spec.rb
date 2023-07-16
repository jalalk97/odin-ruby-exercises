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
end
