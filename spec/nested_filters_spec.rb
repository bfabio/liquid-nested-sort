require 'spec_helper'
require 'liquid_nested_sort/nested_filters'

describe NestedFilters do
  include NestedFilters

  before :each do
    ab = { 'title' => 'Harry Potter', 'author' => 'JK Rowling' }
    bb = { 'title' => 'HARRY POTTER 2: Harry Potter and the Chamber of Secrets', 'author' => 'JK Rowling' }
    cb = { 'title' => 'Lord of the Flies', 'author' => 'William Golding' }
    db = { 'title' => 'The Circle', 'author' => 'Dave Eggers' }
    eb = { 'title' => 'The Accidental Billionaires', 'author' => 'Ben Mezrich' }

    am = { 'title' => 'Harry Potter', 'distributor' => 'Warner Brothers' }
    bm = { 'title' => 'Harry Potter 2: Chamber of Secrets', 'distributor' => 'Warner Brothers' }
    cm = { 'title' => 'Lord of the Flies', 'distributor' => 'Columbia Pictures' }
    dm = { 'title' => 'The Circle', 'distributor' => 'Devolver' }
    em = { 'title' => 'The Social Network', 'distributor' => 'Big Pictures' }

    @a = { 'book' => ab, 'movie' => am, 'id' => 5 }
    @b = { 'book' => bb, 'movie' => bm, 'id' => 4 }
    @c = { 'book' => cb, 'movie' => cm, 'id' => 3 }
    @d = { 'book' => db, 'movie' => dm, 'id' => 2 }
    @e = { 'book' => eb, 'movie' => em, 'id' => 1 }

    @collection = [@a, @b, @c, @d, @e]
  end

  describe 'nested_sort_natural' do
    context 'collection empty or nil' do
      it "returns an empty array when there's no property" do
        expect(nested_sort_natural([])).to eq([])
        expect(nested_sort_natural(nil)).to eq([])
      end

      it "returns an empty array when there's a property" do
        expect(nested_sort_natural([], 'property')).to eq([])
        expect(nested_sort_natural(nil, 'property')).to eq([])
      end
    end

    context 'property empty or nil' do
      it 'returns' do
        # TODO
        # expect(nested_sort_natural(@collection, '')).to eq([])
        # expect(nested_sort_natural(@collection, nil)).to eq([])
        # expect(nested_sort_natural(@collection)).to eq([])
      end
    end

    context 'nil property' do
      it 'returns' do
        # TODO
        # expect(nested_sort_natural(@collection, '')).to eq([])
        # expect(nested_sort_natural(@collection, nil)).to eq([])
        # expect(nested_sort_natural(@collection)).to eq([])
      end
    end

    context 'valid collection' do
      it 'returns the sorted array' do
        expect(nested_sort_natural(@collection, 'id')).to                eq([@e, @d, @c, @b, @a])
        expect(nested_sort_natural(@collection, 'book.author')).to       eq([@e, @d, @a, @b, @c])
        expect(nested_sort_natural(@collection, 'movie.distributor')).to eq([@e, @c, @d, @a, @b])
        expect(nested_sort_natural(@collection, 'movie.title')).to       eq([@a, @b, @c, @d, @e])
      end
    end
  end
end
