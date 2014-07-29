require 'spec_helper'

module MtgSearchParser
  describe Lexer do
    it "lexes a word" do
      expect(subject.lex("word")).to eq([QueryNode.new("word")])
    end

    it "splits two words" do
      expect(subject.lex("word foo")).
        to eq([QueryNode.new("word"), QueryNode.new("foo")])
    end

    it "keeps characters in words" do
      expect(subject.lex("foo-bar cat")).
        to eq([QueryNode.new("foo-bar"), QueryNode.new("cat")])
    end

    it "allows apostrophes" do
      expect(subject.lex("foo's bar")).
        to eq([QueryNode.new("foo's"), QueryNode.new("bar")])
    end

    it "keeps : in the word" do
      expect(subject.lex("foo:bar cat")).
        to eq([QueryNode.new("foo:bar"), QueryNode.new("cat")])
    end

    it "keeps ! in the word" do
      expect(subject.lex("foo!bar cat")).
        to eq([QueryNode.new("foo!bar"), QueryNode.new("cat")])
    end

    it "keeps it all together if the word starts with a bang" do
      expect(subject.lex("!foo bar baz")).
        to eq([QueryNode.new("!foo bar baz")])
    end

    it "keeps tokens together with quotes" do
      expect(subject.lex('"foo bar" baz')).
        to eq([QueryNode.new('"foo bar"'), QueryNode.new("baz")])
    end

    it "allows quotes in the middle of the term" do
      expect(subject.lex('o:"foo bar" baz')).
        to eq([QueryNode.new('o:"foo bar"'), QueryNode.new("baz")])
    end

    it "recognizes left and right parens" do
      expect(subject.lex("(foo)")).
        to eq([LeftParenNode.new, QueryNode.new("foo"), RightParenNode.new])
    end

    it "recognizes left and right parens ignoring spaces" do
      expect(subject.lex(" ( foo ) ")).
        to eq([LeftParenNode.new, QueryNode.new("foo"), RightParenNode.new])
    end

    it "parses AND as an AndNode" do
      expect(subject.lex("foo AND bar")).
        to eq([QueryNode.new("foo"), AndNode.new, QueryNode.new("bar")])
    end

    it "parses and as an AndNode" do
      expect(subject.lex("foo and bar")).
        to eq([QueryNode.new("foo"), AndNode.new, QueryNode.new("bar")])
    end

    it "parses OR as an OrNode" do
      expect(subject.lex("foo OR bar")).
        to eq([QueryNode.new("foo"), OrNode.new, QueryNode.new("bar")])
    end

    it "parses or as an OrNode" do
      expect(subject.lex("foo or bar")).
        to eq([QueryNode.new("foo"), OrNode.new, QueryNode.new("bar")])
    end

    it "parses NOT as an NotNode" do
      expect(subject.lex("foo NOT bar")).
        to eq([QueryNode.new("foo"), NotNode.new, QueryNode.new("bar")])
    end

    it "parses not as an NotNode" do
      expect(subject.lex("foo not bar")).
        to eq([QueryNode.new("foo"), NotNode.new, QueryNode.new("bar")])
    end
  end
end
