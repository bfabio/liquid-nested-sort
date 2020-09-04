require 'spec_helper'
require 'nested_filters'

describe NestedFilters do
  include NestedFilters

  before :each do
    ab = { 'title' => 'Harry Potter', 'author' => 'JK Rowling', 'series' => [1, 2] }
    bb = { 'title' => 'Lord of the Flies', 'author' => 'William Golding' }
    cb = { 'title' => 'The Circle', 'author' => 'Dave Eggers' }
    db = { 'title' => 'The Accidental Billionaires', 'author' => 'Ben Mezrich' }

    am = { 'title' => 'Harry Potter', 'distributor' => 'Warner Brothers' }
    bm = { 'title' => 'Lord of the Flies', 'distributor' => 'Columbia Pictures' }
    cm = { 'title' => 'The Circle', 'distributor' => 'Devolver' }
    dm = { 'title' => 'The Social Network', 'distributor' => 'Big Pictures' }

    @a = { 'book' => ab, 'movie' => am, 'id' => 4 }
    @b = { 'book' => bb, 'movie' => bm, 'id' => 3 }
    @c = { 'book' => cb, 'movie' => cm, 'id' => 2 }
    @d = { 'book' => db, 'movie' => dm, 'id' => 1 }

    @collection = [@a, @b, @c, @d]
  end

  describe 'nested_sort' do
    context 'collection empty or nil' do
      it "returns an empty array when there's no property" do
        expect(nested_sort([])).to eq([])
        expect(nested_sort(nil)).to eq([])
      end

      it "returns an empty array when there's a property" do
        expect(nested_sort([], 'property')).to eq([])
        expect(nested_sort(nil, 'property')).to eq([])
      end
    end

    context 'property empty or nil' do
      it 'returns' do
        # TODO
        # expect(nested_sort(@collection, '')).to eq([])
        # expect(nested_sort(@collection, nil)).to eq([])
        # expect(nested_sort(@collection)).to eq([])
      end
    end

    context 'nil property' do
      it 'returns' do
        # TODO
        # expect(nested_sort(@collection, '')).to eq([])
        # expect(nested_sort(@collection, nil)).to eq([])
        # expect(nested_sort(@collection)).to eq([])
      end
    end

    context 'valid collection' do
      it 'returns the sorted array' do
        expect(nested_sort(@collection, 'id')).to                eq([@d, @c, @b, @a])
        expect(nested_sort(@collection, 'book.author')).to       eq([@d, @c, @a, @b])
        expect(nested_sort(@collection, 'movie.distributor')).to eq([@d, @b, @c, @a])
      end
    end
  end
end
