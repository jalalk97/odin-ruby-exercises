# frozen_string_literal: true

require "linked_list"

RSpec.describe LinkedList do
  describe "append" do
    let(:list) { LinkedList.new }

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

  describe "prepend" do
    let(:list) { LinkedList.new }

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
end
