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

  describe "#remove" do
    it "a leaf node" do
      tree = Tree.new([50])
      tree.root.left = Tree::Node.new(30)
      tree.root.left.left = Tree::Node.new(20)
      tree.root.left.right = Tree::Node.new(40)
      tree.root.right = Tree::Node.new(70)
      tree.root.right.left = Tree::Node.new(60)
      tree.root.right.right = Tree::Node.new(80)

      tree.remove(20)

      expect(tree.root.data).to eql(50)
      expect(tree.root.left.data).to eql(30)
      expect(tree.root.right.data).to eql(70)
      expect(tree.root.left.left).to be_nil
      expect(tree.root.left.right.data).to eql(40)
      expect(tree.root.right.left.data).to eql(60)
      expect(tree.root.right.right.data).to eql(80)
    end

    it "a node with a single child" do
      tree = Tree.new([44])
      tree.root.left = Tree::Node.new(17)
      tree.root.left.right = Tree::Node.new(32)
      tree.root.left.right.left = Tree::Node.new(28)
      tree.root.left.right.left.right = Tree::Node.new(29)
      tree.root.right = Tree::Node.new(88)
      tree.root.right.left = Tree::Node.new(65)
      tree.root.right.left.left = Tree::Node.new(54)
      tree.root.right.left.right = Tree::Node.new(82)
      tree.root.right.left.right.left = Tree::Node.new(76)
      tree.root.right.left.right.left.right = Tree::Node.new(80)
      tree.root.right.left.right.left.right.left = Tree::Node.new(78)
      tree.root.right.right = Tree::Node.new(97)

      tree.remove(32)

      expect(tree.root.data).to eql(44)
      expect(tree.root.left.data).to eql(17)
      expect(tree.root.left.right.data).to eql(28)
      expect(tree.root.left.right.right.data).to eql(29)
      expect(tree.root.right.data).to eql(88)
      expect(tree.root.right.left.data).to eql(65)
      expect(tree.root.right.left.left.data).to eql(54)
      expect(tree.root.right.left.right.data).to eql(82)
      expect(tree.root.right.left.right.left.data).to eql(76)
      expect(tree.root.right.left.right.left.right.data).to eql(80)
      expect(tree.root.right.left.right.left.right.left.data).to eql(78)
      expect(tree.root.right.right.data).to eql(97)
    end

    it "a node with both children" do
      tree = Tree.new([44])
      tree.root.left = Tree::Node.new(17)
      tree.root.left.right = Tree::Node.new(28)
      tree.root.left.right.right = Tree::Node.new(29)
      tree.root.right = Tree::Node.new(88)
      tree.root.right.left = Tree::Node.new(65)
      tree.root.right.left.left = Tree::Node.new(54)
      tree.root.right.left.right = Tree::Node.new(82)
      tree.root.right.left.right.left = Tree::Node.new(76)
      tree.root.right.left.right.left.right = Tree::Node.new(80)
      tree.root.right.left.right.left.right.left = Tree::Node.new(78)
      tree.root.right.right = Tree::Node.new(97)

      tree.remove(65)

      expect(tree.root.data).to eql(44)
      expect(tree.root.left.data).to eql(17)
      expect(tree.root.left.right.data).to eql(28)
      expect(tree.root.left.right.right.data).to eql(29)
      expect(tree.root.right.data).to eql(88)
      expect(tree.root.right.left.data).to eql(76)
      expect(tree.root.right.left.left.data).to eql(54)
      expect(tree.root.right.left.right.data).to eql(82)
      expect(tree.root.right.left.right.left.data).to eql(80)
      expect(tree.root.right.left.right.left.left.data).to eql(78)
      expect(tree.root.right.right.data).to eql(97)
    end
  end

  describe "#find" do
    let(:tree) { Tree.new((1..9).to_a) }

    it "a leaf node" do
      expect(tree.find(4).data).to eql(4)
    end

    it "an internal node" do
      expect(tree.find(7).data).to eql(7)
    end

    it "returns nil the when the value is absent" do
      expect(tree.find(10)).to be_nil
    end
  end

  describe "#level_order" do
    let(:tree) { Tree.new((1..9).to_a) }

    it "with no block provided" do
      expect(tree.level_order).to eql([5, 2, 7, 1, 3, 6, 8, 4, 9])
    end
  end

  describe "#inorder" do
    let(:tree) { Tree.new((1..9).to_a) }

    it "with no block provided" do
      expect(tree.inorder).to eql([1, 2, 3, 4, 5, 6, 7, 8, 9])
    end
  end

  describe "#preorder" do
    let(:tree) { Tree.new((1..9).to_a) }

    it "with no block provided" do
      expect(tree.preorder).to eql([5, 2, 1, 3, 4, 7, 6, 8, 9])
    end
  end

  describe "#postorder" do
    let(:tree) { Tree.new((1..9).to_a) }

    it "with no block provided" do
      expect(tree.postorder).to eql([1, 4, 3, 2, 6, 9, 8, 7, 5])
    end
  end

  describe "#height" do
    let(:tree) { Tree.new((1..9).to_a) }

    it "root" do
      node = tree.root

      expect(tree.height(node)).to eql(3)
    end

    it "leaf node" do
      node = tree.root.left.right.right

      expect(tree.height(node)).to eql(0)
    end

    it "internal node" do
      node = tree.root.right.right

      expect(tree.height(node)).to eql(1)
    end
  end

  describe "#depth" do
    let(:tree) { Tree.new((1..9).to_a) }

    it "root" do
      node = tree.root

      expect(tree.depth(node)).to eql(0)
    end

    it "leaf node" do
      node = tree.root.left.right.right

      expect(tree.depth(node)).to eql(3)
    end

    it "internal node" do
      node = tree.root.right.right

      expect(tree.depth(node)).to eql(2)
    end
  end
end
