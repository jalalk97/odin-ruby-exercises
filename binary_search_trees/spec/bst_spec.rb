# frozen_string_literal: true

require "bst"

RSpec.describe Tree do
  describe "#initialize" do
    context "when the input array is sorted and doesn't contain duplicates" do
      it "creates the correct tree from (1..7)" do
        tree = Tree.new((1..7).to_a)

        expect(tree.root.data).to eql(4)
        expect(tree.root.left.data).to eql(2)
        expect(tree.root.left.left.data).to eql(1)
        expect(tree.root.left.right.data).to eql(3)
        expect(tree.root.right.data).to eql(6)
        expect(tree.root.right.left.data).to eql(5)
        expect(tree.root.right.right.data).to eql(7)
      end

      it "creates the correct tree from (1..4)" do
        tree = Tree.new((1..4).to_a)

        expect(tree.root.data).to eql(2)
        expect(tree.root.left.data).to eql(1)
        expect(tree.root.right.data).to eql(3)
        expect(tree.root.right.right.data).to eql(4)
      end

      it "creates the correct tree from (1..9)" do
        tree = Tree.new((1..9).to_a)

        expect(tree.root.data).to eql(5)
        expect(tree.root.left.data).to eql(2)
        expect(tree.root.left.left.data).to eql(1)
        expect(tree.root.left.right.data).to eql(3)
        expect(tree.root.left.right.right.data).to eql(4)
        expect(tree.root.right.data).to eql(7)
        expect(tree.root.right.left.data).to eql(6)
        expect(tree.root.right.right.data).to eql(8)
        expect(tree.root.right.right.right.data).to eql(9)
      end
    end

    context "when the input array contains duplicates" do
      it "creates the correct tree with duplicates removed" do
        tree = Tree.new([1, 1, 2, 2, 3, 3, 4, 4])

        expect(tree.root.data).to eql(2)
        expect(tree.root.left.data).to eql(1)
        expect(tree.root.right.data).to eql(3)
        expect(tree.root.right.right.data).to eql(4)
      end
    end

    context "when the input array is not sorted" do
      it "creates the correct tree" do
        tree = Tree.new([1, 4, 3, 2, 6, 8, 9, 7, 5])

        expect(tree.root.data).to eql(5)
        expect(tree.root.left.data).to eql(2)
        expect(tree.root.left.left.data).to eql(1)
        expect(tree.root.left.right.data).to eql(3)
        expect(tree.root.left.right.right.data).to eql(4)
        expect(tree.root.right.data).to eql(7)
        expect(tree.root.right.left.data).to eql(6)
        expect(tree.root.right.right.data).to eql(8)
        expect(tree.root.right.right.right.data).to eql(9)
      end
    end

    context "when the input array is not sorted and contains duplicates" do
      it "creates the correct tree" do
        tree = Tree.new([1, 3, 2, 5, 7, 6, 4, 4, 2, 1, 3, 6, 5, 7])

        expect(tree.root.data).to eql(4)
        expect(tree.root.left.data).to eql(2)
        expect(tree.root.left.left.data).to eql(1)
        expect(tree.root.left.right.data).to eql(3)
        expect(tree.root.right.data).to eql(6)
        expect(tree.root.right.left.data).to eql(5)
        expect(tree.root.right.right.data).to eql(7)
      end
    end
  end

  describe "#insert" do
    let(:tree) { Tree.new([1, 2, 4, 5]) }
    context "when the value is not already present in the tree" do
      it "inserts the value smaller than the minimum at the right place" do
        tree.insert(0)

        expect(tree.root.data).to eql(2)
        expect(tree.root.left.data).to eql(1)
        expect(tree.root.right.data).to eql(4)
        expect(tree.root.right.right.data).to eql(5)

        expect(tree.root.left.left.data).to eql(0)
      end

      it "inserts the value greater than the maximum at the right place" do
        tree.insert(6)

        expect(tree.root.data).to eql(2)
        expect(tree.root.left.data).to eql(1)
        expect(tree.root.right.data).to eql(4)
        expect(tree.root.right.right.data).to eql(5)

        expect(tree.root.right.right.right.data).to eql(6)
      end

      it "inserts the value between the minimum and the maximum at the right place" do
        tree.insert(3)

        expect(tree.root.data).to eql(2)
        expect(tree.root.left.data).to eql(1)
        expect(tree.root.right.data).to eql(4)
        expect(tree.root.right.right.data).to eql(5)

        expect(tree.root.right.left.data).to eql(3)
      end

      it "returns the root of the tree" do
        expect(tree.insert(0)).to be tree.root
      end
    end

    context "when the value is already present in the tree" do
      it "leaves the tree unchanged" do
        tree.insert(2)

        expect(tree.root.data).to eql(2)
        expect(tree.root.left.data).to eql(1)
        expect(tree.root.right.data).to eql(4)
        expect(tree.root.right.right.data).to eql(5)
      end

      it "returns the root of the tree" do
        expect(tree.insert(2)).to be tree.root
      end
    end
  end
end
