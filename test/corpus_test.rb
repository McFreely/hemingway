require "minitest/autorun"

require "hemingway/document"
require "hemingway/corpus"

class CorpusTest < Minitest::Test
  def setup
    doc_one = "The cat likes to eat pasta. He wants more each time."
    doc_two = "He doesn't like tomato sauce. The cat prefer pesto sauce."
    @document_one = Hemingway::Document.new(doc_one)
    @document_two = Hemingway::Document.new(doc_two)
    document_collection = [@document_one, @document_two]
    @corpus = Hemingway::Corpus.new(document_collection)
  end

  def test_document_preparation
    refute_empty @document_one.id
    refute_empty @document_two.id

    assert_equal ["The cat likes to eat pasta.", "He wants more each time."], @document_one.text
    assert_equal ["He doesn't like tomato sauce.", "The cat prefer pesto sauce."], @document_two.text
  end
  
  def test_corpus_generation
    assert_equal 2, @corpus.original_corpus.keys.size
    assert_equal 2, @corpus.original_corpus.values.size
  end

  def test_summary
    summary = @corpus.summary(2, 0.2)

    refute_empty summary
    assert_equal 2, summary.size
  end
end
